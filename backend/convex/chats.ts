import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

// Create a new chat
export const createChat = mutation({
  args: {
    name: v.string(),
    description: v.optional(v.string()),
    type: v.string(), // "direct" or "group"
    participants: v.array(v.id("users")),
    avatar: v.optional(v.string()),
  },
  handler: async (ctx, args) => {
    const chatId = await ctx.db.insert("chats", {
      name: args.name,
      description: args.description,
      type: args.type,
      participants: args.participants,
      avatar: args.avatar,
      unreadCount: 0,
      isArchived: false,
      isPinned: false,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      settings: {
        allowInvites: true,
        allowMedia: true,
        allowPolls: true,
        encryptionEnabled: false,
      },
    });

    return chatId;
  },
});

// Get chat by ID
export const getChatById = query({
  args: { chatId: v.id("chats") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.chatId);
  },
});

// Get chats for a user
export const getChatsForUser = query({
  args: { userId: v.id("users") },
  handler: async (ctx, args) => {
    const chats = await ctx.db
      .query("chats")
      .withIndex("by_participant", (q) => q.eq("participants", args.userId))
      .collect();

    // Sort by last message time
    return chats.sort((a, b) => (b.lastMessageAt || 0) - (a.lastMessageAt || 0));
  },
});

// Add participant to chat
export const addParticipant = mutation({
  args: {
    chatId: v.id("chats"),
    userId: v.id("users"),
  },
  handler: async (ctx, args) => {
    const chat = await ctx.db.get(args.chatId);
    if (!chat) {
      throw new Error("Chat not found");
    }

    if (chat.participants.includes(args.userId)) {
      throw new Error("User already in chat");
    }

    await ctx.db.patch(args.chatId, {
      participants: [...chat.participants, args.userId],
      updatedAt: Date.now(),
    });
  },
});

// Remove participant from chat
export const removeParticipant = mutation({
  args: {
    chatId: v.id("chats"),
    userId: v.id("users"),
  },
  handler: async (ctx, args) => {
    const chat = await ctx.db.get(args.chatId);
    if (!chat) {
      throw new Error("Chat not found");
    }

    await ctx.db.patch(args.chatId, {
      participants: chat.participants.filter(id => id !== args.userId),
      updatedAt: Date.now(),
    });
  },
});

// Update chat settings
export const updateChatSettings = mutation({
  args: {
    chatId: v.id("chats"),
    name: v.optional(v.string()),
    description: v.optional(v.string()),
    avatar: v.optional(v.string()),
    settings: v.optional(v.object({
      allowInvites: v.boolean(),
      allowMedia: v.boolean(),
      allowPolls: v.boolean(),
      encryptionEnabled: v.boolean(),
    })),
  },
  handler: async (ctx, args) => {
    const { chatId, ...updates } = args;
    
    await ctx.db.patch(chatId, {
      ...updates,
      updatedAt: Date.now(),
    });

    return await ctx.db.get(chatId);
  },
});

// Archive chat
export const archiveChat = mutation({
  args: {
    chatId: v.id("chats"),
    isArchived: v.boolean(),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.chatId, {
      isArchived: args.isArchived,
      updatedAt: Date.now(),
    });
  },
});

// Pin chat
export const pinChat = mutation({
  args: {
    chatId: v.id("chats"),
    isPinned: v.boolean(),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.chatId, {
      isPinned: args.isPinned,
      updatedAt: Date.now(),
    });
  },
});

// Delete chat
export const deleteChat = mutation({
  args: { chatId: v.id("chats") },
  handler: async (ctx, args) => {
    // Delete all messages in the chat
    const messages = await ctx.db
      .query("messages")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .collect();

    for (const message of messages) {
      await ctx.db.delete(message._id);
    }

    // Delete the chat
    await ctx.db.delete(args.chatId);
  },
});
