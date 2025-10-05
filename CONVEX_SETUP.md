# 🚀 Convex Setup Guide for SmartChat

## Why Convex is Perfect for SmartChat

✅ **Real-time subscriptions** - Perfect for instant messaging  
✅ **Built-in authentication** - No separate auth service needed  
✅ **File storage** - Handle media uploads seamlessly  
✅ **TypeScript support** - Type-safe database operations  
✅ **Free tier** - Generous limits for development  
✅ **No database setup** - Everything managed for you  

## 📋 Prerequisites

1. **Node.js** (Required for Convex CLI)
   - Download: https://nodejs.org/
   - Install LTS version
   - Restart terminal after installation

2. **Convex Account**
   - Sign up: https://convex.dev/
   - Create new project

## 🚀 Step-by-Step Setup

### Step 1: Install Convex CLI

```bash
# Install Convex CLI globally
npm install -g convex

# Verify installation
convex --version
```

### Step 2: Create Convex Project

1. **Go to Convex Dashboard**: https://convex.dev/
2. **Click "New Project"**
3. **Fill in details**:
   - Project name: `smartchat-app`
   - Choose free tier
4. **Copy your deployment URL** (looks like: `https://your-project-name.convex.cloud`)

### Step 3: Initialize Convex in Your Project

```bash
# Navigate to your project directory
cd "C:\Users\Hamza Wali\Desktop\Chat ap"

# Initialize Convex
convex init

# This will create:
# - convex/ folder with functions
# - convex.json configuration
# - .env.local with your keys
```

### Step 4: Configure Environment

```bash
# Copy the Convex environment template
copy convex-env.example .env

# Update .env with your Convex details
# Get these from your Convex dashboard:
CONVEX_DEPLOYMENT_URL=https://your-project-name.convex.cloud
CONVEX_DEPLOY_KEY=your_convex_deploy_key_here
```

### Step 5: Create Database Schema

Create `convex/schema.ts`:

```typescript
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
  }).index("by_email", ["email"]),

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
  }),

  // Messages table
  messages: defineTable({
    chatId: v.id("chats"),
    senderId: v.id("users"),
    content: v.string(),
    type: v.string(), // "text", "image", "video", etc.
    status: v.string(), // "sending", "sent", "delivered", "read"
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
    })),
    isEdited: v.boolean(),
    isDeleted: v.boolean(),
    deletedAt: v.optional(v.number()),
  }).index("by_chat", ["chatId"]),

  // Smart Streaks table
  streaks: defineTable({
    chatId: v.id("chats"),
    creatorId: v.id("users"),
    content: v.string(),
    type: v.string(), // "photo", "video", "text"
    settings: v.object({
      allowSave: v.boolean(),
      allowView: v.boolean(),
      allowScreenshot: v.boolean(),
      timeoutMinutes: v.number(),
      isEncrypted: v.boolean(),
    }),
    views: v.array(v.id("users")),
    saves: v.array(v.id("users")),
    reactions: v.array(v.object({
      emoji: v.string(),
      userId: v.id("users"),
      timestamp: v.number(),
    })),
    expiresAt: v.number(),
    createdAt: v.number(),
    updatedAt: v.number(),
  }).index("by_chat", ["chatId"]),
});
```

### Step 6: Create Convex Functions

Create `convex/users.ts`:

```typescript
import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

export const createUser = mutation({
  args: {
    email: v.string(),
    username: v.string(),
    profilePicture: v.optional(v.string()),
  },
  handler: async (ctx, args) => {
    const userId = await ctx.db.insert("users", {
      email: args.email,
      username: args.username,
      profilePicture: args.profilePicture,
      isOnline: false,
      createdAt: Date.now(),
      updatedAt: Date.now(),
    });
    return userId;
  },
});

export const getUsers = query({
  handler: async (ctx) => {
    return await ctx.db.query("users").collect();
  },
});

export const getUserById = query({
  args: { userId: v.id("users") },
  handler: async (ctx, args) => {
    return await ctx.db.get(args.userId);
  },
});
```

Create `convex/messages.ts`:

```typescript
import { mutation, query } from "./_generated/server";
import { v } from "convex/values";

export const sendMessage = mutation({
  args: {
    chatId: v.id("chats"),
    senderId: v.id("users"),
    content: v.string(),
    type: v.string(),
  },
  handler: async (ctx, args) => {
    const messageId = await ctx.db.insert("messages", {
      chatId: args.chatId,
      senderId: args.senderId,
      content: args.content,
      type: args.type,
      status: "sent",
      timestamp: Date.now(),
      reactions: [],
      attachments: [],
      isEdited: false,
      isDeleted: false,
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

export const getMessages = query({
  args: { chatId: v.id("chats") },
  handler: async (ctx, args) => {
    return await ctx.db
      .query("messages")
      .withIndex("by_chat", (q) => q.eq("chatId", args.chatId))
      .order("desc")
      .collect();
  },
});
```

### Step 7: Deploy to Convex

```bash
# Deploy your functions to Convex
convex deploy

# This will:
# - Create your database tables
# - Deploy your functions
# - Give you the deployment URL
```

### Step 8: Update Flutter App

Add Convex to your Flutter app:

1. **Add to pubspec.yaml**:
```yaml
dependencies:
  convex_flutter: ^0.0.4
```

2. **Initialize in main.dart**:
```dart
import 'package:convex_flutter/convex_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Convex
  Convex.initialize(
    deploymentUrl: 'https://your-project-name.convex.cloud',
  );
  
  runApp(const SmartChatApp());
}
```

## 🎯 **What You Get with Convex**

### ✅ **Real-time Features**
- Instant message delivery
- Live typing indicators
- Online status updates
- Real-time reactions

### ✅ **Built-in Authentication**
- User registration/login
- Session management
- Secure token handling

### ✅ **File Storage**
- Image/video uploads
- Document sharing
- Automatic optimization

### ✅ **Database Operations**
- Type-safe queries
- Automatic indexing
- Real-time subscriptions

## 🔧 **Environment Variables for Convex**

```env
# Required
CONVEX_DEPLOYMENT_URL=https://your-project-name.convex.cloud
CONVEX_DEPLOY_KEY=your_convex_deploy_key_here

# Optional (for additional features)
JWT_SECRET=your_jwt_secret_for_extra_security
ENCRYPTION_KEY=your_encryption_key_for_messages
OPENAI_API_KEY=your_openai_key_for_ai_features
```

## 🚀 **Next Steps**

1. **Install Node.js** (if not already installed)
2. **Create Convex account** and project
3. **Run the setup commands** above
4. **Update your .env** file
5. **Deploy to Convex**
6. **Test your app** with real-time features!

## 💡 **Benefits of Convex for SmartChat**

- **No database setup** - Everything managed
- **Real-time by default** - Perfect for chat
- **Type safety** - Fewer bugs
- **Free tier** - Great for development
- **Scalable** - Grows with your app

Would you like me to help you with any specific step, or shall we start with installing Node.js?
