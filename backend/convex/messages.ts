import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

// Send a message
export const sendMessage = mutation({
  args: {
    chatId: v.id("chats"),
    senderId: v.id("users"),
    content: v.string(),
    type: v.string(), // "text", "image", "video", "audio", "document", "sticker", "gif", "voice", "location", "contact", "poll", "reaction", "system", "encrypted", "selfDestruct", "streak"
    replyToMessageId: v.optional(v.id("messages")),
    attachments: v.optional(v.array(v.object({
      type: v.string(),
      url: v.string(),
      filename: v.string(),
      size: v.number(),
      thumbnail: v.optional(v.string()),
    }))),
    encryption: v.optional(v.object({
      algorithm: v.string(),
      keyId: v.string(),
      iv: v.string(),
    })),
  },
  handler: async (ctx, args) => {
    const messageId = await ctx.db.insert("messages", {
      chatId: args.chatId,
      senderId: args.senderId,
      content: args.content,
      type: args.type,
      status: "sent",
      timestamp: Date.now(),
      replyToMessageId: args.replyToMessageId,
      forwardedFrom: [],
      reactions: [],
      attachments: args.attachments || [],
      isEdited: false,
      isDeleted: false,
      encryption: args.encryption,
      metadata: {
        readBy: [],
        deliveredTo: [],
        screenshotDetected: false,
        screenRecordDetected: false,
      },
    });

    // Update chat's last message
    await ctx.db.patch(args.chatId, {
      lastMessageId: messageId,
      lastMessageAt: Date.now(),
      updatedAt: Date.now(),
    });

    return messageId;
  },
});

// Get messages for a chat
export const getMessages = query({
  args: { 
    chatId: v.id("chats"),
    limit: v.optional(v.number()),
  },
  handler: async (ctx, args) => {
    const messages = await ctx.db
      .query("messages")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .order("desc")
      .take(args.limit || 50);

    return messages.reverse(); // Return in chronological order
  },
});

// Get message by ID
export const getMessageById = query({
  args: { messageId: v.id("messages") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.messageId);
  },
});

// Edit message
export const editMessage = mutation({
  args: {
    messageId: v.id("messages"),
    content: v.string(),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.messageId, {
      content: args.content,
      isEdited: true,
      editedAt: Date.now(),
    });

    return await ctx.db.get(args.messageId);
  },
});

// Delete message
export const deleteMessage = mutation({
  args: {
    messageId: v.id("messages"),
    reason: v.optional(v.string()),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.messageId, {
      isDeleted: true,
      deletedAt: Date.now(),
      deleteReason: args.reason,
    });
  },
});

// Add reaction to message
export const addReaction = mutation({
  args: {
    messageId: v.id("messages"),
    userId: v.id("users"),
    emoji: v.string(),
  },
  handler: async (ctx, args) => {
    const message = await ctx.db.get(args.messageId);
    if (!message) {
      throw new Error("Message not found");
    }

    // Remove existing reaction from this user
    const filteredReactions = message.reactions.filter(
      r => r.userId !== args.userId
    );

    // Add new reaction
    const newReactions = [
      ...filteredReactions,
      {
        emoji: args.emoji,
        userId: args.userId,
        timestamp: Date.now(),
      },
    ];

    await ctx.db.patch(args.messageId, {
      reactions: newReactions,
    });
  },
});

// Remove reaction from message
export const removeReaction = mutation({
  args: {
    messageId: v.id("messages"),
    userId: v.id("users"),
    emoji: v.string(),
  },
  handler: async (ctx, args) => {
    const message = await ctx.db.get(args.messageId);
    if (!message) {
      throw new Error("Message not found");
    }

    const filteredReactions = message.reactions.filter(
      r => !(r.userId === args.userId && r.emoji === args.emoji)
    );

    await ctx.db.patch(args.messageId, {
      reactions: filteredReactions,
    });
  },
});

// Mark message as read
export const markAsRead = mutation({
  args: {
    messageId: v.id("messages"),
    userId: v.id("users"),
  },
  handler: async (ctx, args) => {
    const message = await ctx.db.get(args.messageId);
    if (!message) {
      throw new Error("Message not found");
    }

    const readBy = message.metadata?.readBy || [];
    if (!readBy.includes(args.userId)) {
      readBy.push(args.userId);
    }

    await ctx.db.patch(args.messageId, {
      metadata: {
        ...message.metadata,
        readBy,
      },
    });
  },
});

// Search messages
export const searchMessages = query({
  args: {
    chatId: v.id("chats"),
    query: v.string(),
    limit: v.optional(v.number()),
  },
  handler: async (ctx, args) => {
    const messages = await ctx.db
      .query("messages")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .collect();

    const filteredMessages = messages
      .filter(message => 
        message.content.toLowerCase().includes(args.query.toLowerCase()) &&
        !message.isDeleted
      )
      .sort((a, b) => b.timestamp - a.timestamp)
      .slice(0, args.limit || 20);

    return filteredMessages;
  },
});

// Forward message
export const forwardMessage = mutation({
  args: {
    messageId: v.id("messages"),
    toChatId: v.id("chats"),
    senderId: v.id("users"),
  },
  handler: async (ctx, args) => {
    const originalMessage = await ctx.db.get(args.messageId);
    if (!originalMessage) {
      throw new Error("Message not found");
    }

    const forwardedMessageId = await ctx.db.insert("messages", {
      chatId: args.toChatId,
      senderId: args.senderId,
      content: originalMessage.content,
      type: originalMessage.type,
      status: "sent",
      timestamp: Date.now(),
      forwardedFrom: [...originalMessage.forwardedFrom, originalMessage._id],
      reactions: [],
      attachments: originalMessage.attachments,
      isEdited: false,
      isDeleted: false,
      metadata: {
        readBy: [],
        deliveredTo: [],
        screenshotDetected: false,
        screenRecordDetected: false,
      },
    });

    return forwardedMessageId;
  },
});
