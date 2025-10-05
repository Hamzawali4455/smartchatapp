import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  // Users table
  users: defineTable({
    email: v.string(),
    username: v.string(),
    profilePicture: v.optional(v.string()),
    bio: v.optional(v.string()),
    isOnline: v.boolean(),
    lastSeen: v.optional(v.number()),
    createdAt: v.number(),
    updatedAt: v.number(),
    settings: v.optional(v.object({
      notificationsEnabled: v.boolean(),
      theme: v.string(),
      language: v.string(),
      privacy: v.object({
        showOnlineStatus: v.boolean(),
        showLastSeen: v.boolean(),
        allowReadReceipts: v.boolean(),
      }),
    })),
  }).index("by_email", ["email"])
    .index("by_username", ["username"]),

  // Chats table
  chats: defineTable({
    name: v.string(),
    description: v.optional(v.string()),
    type: v.string(), // "direct" or "group"
    avatar: v.optional(v.string()),
    participants: v.array(v.id("users")),
    lastMessageId: v.optional(v.id("messages")),
    lastMessageAt: v.optional(v.number()),
    unreadCount: v.number(),
    isArchived: v.boolean(),
    isPinned: v.boolean(),
    createdAt: v.number(),
    updatedAt: v.number(),
    settings: v.optional(v.object({
      allowInvites: v.boolean(),
      allowMedia: v.boolean(),
      allowPolls: v.boolean(),
      encryptionEnabled: v.boolean(),
    })),
  }).index("by_participant", ["participants"])
    .index("by_type", ["type"]),

  // Messages table
  messages: defineTable({
    chatId: v.id("chats"),
    senderId: v.id("users"),
    content: v.string(),
    type: v.string(), // "text", "image", "video", "audio", "document", "sticker", "gif", "voice", "location", "contact", "poll", "reaction", "system", "encrypted", "selfDestruct", "streak"
    status: v.string(), // "sending", "sent", "delivered", "read", "failed", "deleted"
    timestamp: v.number(),
    editedAt: v.optional(v.number()),
    replyToMessageId: v.optional(v.id("messages")),
    forwardedFrom: v.array(v.string()),
    reactions: v.array(v.object({
      emoji: v.string(),
      userId: v.id("users"),
      timestamp: v.number(),
    })),
    attachments: v.array(v.object({
      type: v.string(),
      url: v.string(),
      filename: v.string(),
      size: v.number(),
      thumbnail: v.optional(v.string()),
    })),
    isEdited: v.boolean(),
    isDeleted: v.boolean(),
    deletedAt: v.optional(v.number()),
    deleteReason: v.optional(v.string()),
    encryption: v.optional(v.object({
      algorithm: v.string(),
      keyId: v.string(),
      iv: v.string(),
    })),
    metadata: v.optional(v.object({
      readBy: v.array(v.id("users")),
      deliveredTo: v.array(v.id("users")),
      screenshotDetected: v.boolean(),
      screenRecordDetected: v.boolean(),
    })),
  }).index("by_chat", ["chatId"])
    .index("by_sender", ["senderId"])
    .index("by_timestamp", ["timestamp"]),

  // Smart Streaks table
  streaks: defineTable({
    chatId: v.id("chats"),
    creatorId: v.id("users"),
    content: v.string(),
    type: v.string(), // "photo", "video", "text", "audio"
    mediaUrl: v.optional(v.string()),
    settings: v.object({
      allowSave: v.boolean(),
      allowView: v.boolean(),
      allowScreenshot: v.boolean(),
      timeoutMinutes: v.number(),
      isEncrypted: v.boolean(),
      requirePassword: v.boolean(),
      password: v.optional(v.string()),
    }),
    views: v.array(v.object({
      userId: v.id("users"),
      timestamp: v.number(),
      duration: v.optional(v.number()),
    })),
    saves: v.array(v.object({
      userId: v.id("users"),
      timestamp: v.number(),
      encrypted: v.boolean(),
    })),
    reactions: v.array(v.object({
      emoji: v.string(),
      userId: v.id("users"),
      timestamp: v.number(),
    })),
    expiresAt: v.number(),
    createdAt: v.number(),
    updatedAt: v.number(),
    isActive: v.boolean(),
  }).index("by_chat", ["chatId"])
    .index("by_creator", ["creatorId"])
    .index("by_expires", ["expiresAt"]),

  // Connection Suite - Shared Activities
  connectionSessions: defineTable({
    chatId: v.id("chats"),
    creatorId: v.id("users"),
    type: v.string(), // "breathing", "music", "shared_room", "doodle", "mood_roulette", "watch_together"
    title: v.string(),
    description: v.optional(v.string()),
    participants: v.array(v.id("users")),
    settings: v.object({
      maxParticipants: v.number(),
      isPublic: v.boolean(),
      allowInvites: v.boolean(),
      duration: v.number(), // in minutes
    }),
    status: v.string(), // "waiting", "active", "paused", "ended"
    startedAt: v.optional(v.number()),
    endedAt: v.optional(v.number()),
    createdAt: v.number(),
    updatedAt: v.number(),
  }).index("by_chat", ["chatId"])
    .index("by_creator", ["creatorId"])
    .index("by_type", ["type"]),

  // File Storage (for media uploads)
  files: defineTable({
    name: v.string(),
    type: v.string(),
    size: v.number(),
    url: v.string(),
    thumbnailUrl: v.optional(v.string()),
    uploadedBy: v.id("users"),
    chatId: v.optional(v.id("chats")),
    messageId: v.optional(v.id("messages")),
    isPublic: v.boolean(),
    expiresAt: v.optional(v.number()),
    createdAt: v.number(),
  }).index("by_uploader", ["uploadedBy"])
    .index("by_chat", ["chatId"])
    .index("by_type", ["type"]),

  // Notifications
  notifications: defineTable({
    userId: v.id("users"),
    type: v.string(), // "message", "streak", "connection", "system"
    title: v.string(),
    body: v.string(),
    data: v.optional(v.object({})),
    isRead: v.boolean(),
    createdAt: v.number(),
  }).index("by_user", ["userId"])
    .index("by_type", ["type"])
    .index("by_unread", ["isRead"]),
});
