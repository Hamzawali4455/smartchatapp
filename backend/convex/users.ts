import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

// Create a new user
export const createUser = mutation({
  args: {
    email: v.string(),
    username: v.string(),
    profilePicture: v.optional(v.string()),
    bio: v.optional(v.string()),
  },
  handler: async (ctx, args) => {
    // Check if user already exists
    const existingUser = await ctx.db
      .query("users")
      .withIndex("by_email", (q) => q.eq("email", args.email))
      .first();

    if (existingUser) {
      throw new Error("User with this email already exists");
    }

    const userId = await ctx.db.insert("users", {
      email: args.email,
      username: args.username,
      profilePicture: args.profilePicture,
      bio: args.bio,
      isOnline: false,
      createdAt: Date.now(),
      updatedAt: Date.now(),
      settings: {
        notificationsEnabled: true,
        theme: "light",
        language: "en",
        privacy: {
          showOnlineStatus: true,
          showLastSeen: true,
          allowReadReceipts: true,
        },
      },
    });

    return userId;
  },
});

// Get user by ID
export const getUserById = query({
  args: { userId: v.id("users") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.userId);
  },
});

// Get user by email
export const getUserByEmail = query({
  args: { email: v.string() },
  handler: async (ctx, args) => {
    return await ctx.db
      .query("users")
      .withIndex("by_email", (q) => q.eq("email", args.email))
      .first();
  },
});

// Get all users
export const getUsers = query({
  handler: async (ctx) => {
    return await ctx.db.query("users").collect();
  },
});

// Search users by username
export const searchUsers = query({
  args: { query: v.string() },
  handler: async (ctx, args) => {
    const users = await ctx.db.query("users").collect();
    return users.filter(user => 
      user.username.toLowerCase().includes(args.query.toLowerCase())
    );
  },
});

// Update user profile
export const updateUser = mutation({
  args: {
    userId: v.id("users"),
    username: v.optional(v.string()),
    profilePicture: v.optional(v.string()),
    bio: v.optional(v.string()),
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
  },
  handler: async (ctx, args) => {
    const { userId, ...updates } = args;
    
    await ctx.db.patch(userId, {
      ...updates,
      updatedAt: Date.now(),
    });

    return await ctx.db.get(userId);
  },
});

// Update online status
export const updateOnlineStatus = mutation({
  args: {
    userId: v.id("users"),
    isOnline: v.boolean(),
  },
  handler: async (ctx, args) => {
    await ctx.db.patch(args.userId, {
      isOnline: args.isOnline,
      lastSeen: args.isOnline ? Date.now() : Date.now(),
      updatedAt: Date.now(),
    });
  },
});

// Delete user
export const deleteUser = mutation({
  args: { userId: v.id("users") },
  handler: async (ctx, args) => {
    // Delete user's messages
    const messages = await ctx.db
      .query("messages")
      .withIndex("by_sender", (q) => q.eq("senderId", args.userId))
      .collect();

    for (const message of messages) {
      await ctx.db.delete(message._id);
    }

    // Delete user's chats
    const chats = await ctx.db
      .query("chats")
      .withIndex("by_participant", (q) => q.eq("participants", args.userId))
      .collect();

    for (const chat of chats) {
      await ctx.db.delete(chat._id);
    }

    // Delete user
    await ctx.db.delete(args.userId);
  },
});
