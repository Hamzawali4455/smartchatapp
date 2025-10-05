import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

// Create a new streak
export const createStreak = mutation({
  args: {
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
  },
  handler: async (ctx, args) => {
    const expiresAt = Date.now() + (args.settings.timeoutMinutes * 60 * 1000);
    
    const streakId = await ctx.db.insert("streaks", {
      chatId: args.chatId,
      creatorId: args.creatorId,
      content: args.content,
      type: args.type,
      mediaUrl: args.mediaUrl,
      settings: args.settings,
      views: [],
      saves: [],
      reactions: [],
      expiresAt,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      isActive: true,
    });

    return streakId;
  },
});

// Get streaks for a chat
export const getStreaks = query({
  args: { chatId: v.id("chats") },
  handler: async (ctx, args) => {
    const streaks = await ctx.db
      .query("streaks")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .collect();

    // Filter out expired streaks
    const now = Date.now();
    return streaks
      .filter(streak => streak.expiresAt > now && streak.isActive)
      .sort((a, b) => b.createdAt - a.createdAt);
  },
});

// Get streak by ID
export const getStreakById = query({
  args: { streakId: v.id("streaks") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.streakId);
  },
});

// View a streak
export const viewStreak = mutation({
  args: {
    streakId: v.id("streaks"),
    userId: v.id("users"),
    duration: v.optional(v.number()),
  },
  handler: async (ctx, args) => {
    const streak = await ctx.db.get(args.streakId);
    if (!streak) {
      throw new Error("Streak not found");
    }

    // Check if streak is still active
    if (Date.now() > streak.expiresAt || !streak.isActive) {
      throw new Error("Streak has expired");
    }

    // Check if user already viewed
    const existingView = streak.views.find(v => v.userId === args.userId);
    if (existingView) {
      // Update duration if provided
      if (args.duration !== undefined) {
        existingView.duration = args.duration;
        await ctx.db.patch(args.streakId, {
          views: streak.views,
          updatedAt: Date.now(),
        });
      }
      return;
    }

    // Add new view
    const newViews = [
      ...streak.views,
      {
        userId: args.userId,
        timestamp: Date.now(),
        duration: args.duration,
      },
    ];

    await ctx.db.patch(args.streakId, {
      views: newViews,
      updatedAt: Date.now(),
    });
  },
});

// Save a streak
export const saveStreak = mutation({
  args: {
    streakId: v.id("streaks"),
    userId: v.id("users"),
    encrypted: v.boolean(),
  },
  handler: async (ctx, args) => {
    const streak = await ctx.db.get(args.streakId);
    if (!streak) {
      throw new Error("Streak not found");
    }

    // Check if streak allows saving
    if (!streak.settings.allowSave) {
      throw new Error("Saving is not allowed for this streak");
    }

    // Check if user already saved
    const existingSave = streak.saves.find(s => s.userId === args.userId);
    if (existingSave) {
      return; // Already saved
    }

    // Add new save
    const newSaves = [
      ...streak.saves,
      {
        userId: args.userId,
        timestamp: Date.now(),
        encrypted: args.encrypted,
      },
    ];

    await ctx.db.patch(args.streakId, {
      saves: newSaves,
      updatedAt: Date.now(),
    });
  },
});

// React to a streak
export const reactToStreak = mutation({
  args: {
    streakId: v.id("streaks"),
    userId: v.id("users"),
    emoji: v.string(),
  },
  handler: async (ctx, args) => {
    const streak = await ctx.db.get(args.streakId);
    if (!streak) {
      throw new Error("Streak not found");
    }

    // Remove existing reaction from this user
    const filteredReactions = streak.reactions.filter(
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

    await ctx.db.patch(args.streakId, {
      reactions: newReactions,
      updatedAt: Date.now(),
    });
  },
});

// Update streak settings
export const updateStreakSettings = mutation({
  args: {
    streakId: v.id("streaks"),
    settings: v.object({
      allowSave: v.boolean(),
      allowView: v.boolean(),
      allowScreenshot: v.boolean(),
      timeoutMinutes: v.number(),
      isEncrypted: v.boolean(),
      requirePassword: v.boolean(),
      password: v.optional(v.string()),
    }),
  },
  handler: async (ctx, args) => {
    const streak = await ctx.db.get(args.streakId);
    if (!streak) {
      throw new Error("Streak not found");
    }

    // Only creator can update settings
    // This would need to be checked in the calling code

    await ctx.db.patch(args.streakId, {
      settings: args.settings,
      updatedAt: Date.now(),
    });
  },
});

// Delete streak
export const deleteStreak = mutation({
  args: { streakId: v.id("streaks") },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.streakId, {
      isActive: false,
      updatedAt: Date.now(),
    });
  },
});

// Get streak history for a chat
export const getStreakHistory = query({
  args: { chatId: v.id("chats") },
  handler: async (ctx, args) => {
    const streaks = await ctx.db
      .query("streaks")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .collect();

    return streaks.sort((a, b) => b.createdAt - a.createdAt);
  },
});

// Clean up expired streaks
export const cleanupExpiredStreaks = mutation({
  handler: async (ctx) => {
    const now = Date.now();
    const expiredStreaks = await ctx.db
      .query("streaks")
      .withIndex("by_expires", (q) => q.lt("expiresAt", now))
      .collect();

    for (const streak of expiredStreaks) {
      await ctx.db.patch(streak._id, {
        isActive: false,
        updatedAt: Date.now(),
      });
    }

    return expiredStreaks.length;
  },
});
