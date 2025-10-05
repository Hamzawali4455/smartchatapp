# SmartChat - Advanced Chat Application

A comprehensive smart chat application built with Flutter featuring advanced messaging, AI-powered features, connection suite, and robust security.

## 🚀 Features

### Core Messaging
- **One-to-one & Group Chat** - Secure messaging with real-time delivery
- **HD Media Sharing** - Photos, videos, documents with encryption
- **Encrypted Voice & Video Calls** - Secure communication channels
- **Animated Emoji with Sounds** - Enhanced emotional expression
- **Message Reactions** - React to messages with custom emojis
- **Stickers, GIFs, Custom Packs** - Rich media content library
- **24-hour Status/Stories** - Share moments with privacy controls

### Connection Suite
- **Shared Breathing Exercises** - Synchronized wellness activities
- **Mood-linked Music Loops** - Shared musical experiences
- **Mini 3D Shared Rooms** - Virtual meeting spaces
- **Relationship Journal** - Weekly scrapbook and memories
- **Doodle Replies** - Collaborative drawing sessions
- **Mood Roulette** - Discover emotions together
- **Voice Masks** - Anonymous voice communication
- **Heartbeat Replay** - Share physiological connections
- **Silent Hug Feature** - Virtual emotional support
- **Memory Triggers** - Relive beautiful moments

### Play & Shared Experiences
- **Watch Together** - YouTube, Spotify, video synchronization
- **Collaborative Drawing Canvas** - Real-time artistic collaboration
- **Mini Games** - Word Blitz, Emoji Guess, Tic-Tac-Toe
- **Voice Moods** - Ambient presence sharing

### AI Features
- **AI Relationship Assistant** - On-device insights and suggestions
- **Smart Reply Suggestions** - Context-aware responses
- **Message Summaries** - Automatic conversation summaries
- **Smart Search** - Advanced message and content search
- **AI Status Ideas** - Intelligent status suggestions
- **Voice-to-Text & Text-to-Voice** - Seamless voice integration
- **Voice Note Transcription** - Automatic speech recognition

### Security & Privacy
- **End-to-End Encryption** - Default AES-256-GCM encryption
- **Double Encryption "Secret Seal"** - Additional security layer
- **Self-Destruct Messages** - Time-limited content
- **Disappearing Attachments** - Auto-delete media
- **Screenshot/Screen Record Alerts** - Privacy protection
- **Login Alerts** - New device notifications
- **Session Control** - Active session management
- **Two-Factor Authentication** - Enhanced account security
- **App Lock & Chat Lock** - Biometric and PIN protection
- **Stealth Mode** - Hide activity and fake screen
- **Zero-Knowledge Cloud Backup** - Encrypted data storage
- **Metadata Minimization** - Reduced data footprint
- **Encrypted Shared Vault** - Secure file sharing
- **Device Integrity Checks** - Security validation
- **Decentralized Identity Option** - Blockchain-based identity

### Smart Streak System
- **Extended 3-minute Streaks** - Time-limited content sharing
- **Creator Authority Controls**:
  - Allow save / view only / timed save / encrypted save
  - Screenshot/screen record alerts
  - Streak lock (password/biometric)
- **Smart Editing Tools** - Advanced content creation
- **Dual-Streak Collaboration Mode** - Joint content creation
- **Interactive Streaks** - Polls and reactions
- **Reward Levels** - Bronze to Diamond progression
- **Smart Timer & Loop Options** - Flexible timing controls
- **Encrypted Storage Options** - Secure content preservation

## 🏗️ Architecture

### Clean Architecture
The application follows Clean Architecture principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── config/             # App configuration
│   ├── di/                 # Dependency injection
│   ├── error/              # Error handling
│   ├── security/           # Encryption services
│   ├── theme/              # UI theming
│   └── utils/              # Utilities
├── features/               # Feature modules
│   ├── auth/               # Authentication
│   ├── messaging/          # Core messaging
│   ├── chat/               # Chat functionality
│   ├── connection/         # Connection suite
│   ├── smart_streaks/      # Smart streaks
│   ├── profile/            # User profile
│   └── settings/           # App settings
└── main.dart               # App entry point
```

### State Management
- **BLoC Pattern** - Predictable state management
- **Repository Pattern** - Data abstraction layer
- **Use Cases** - Business logic encapsulation

### Security Architecture
- **AES-256-GCM Encryption** - Industry-standard encryption
- **Key Management** - Secure key generation and storage
- **Biometric Authentication** - Fingerprint and face unlock
- **Session Management** - Secure token handling

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **BLoC** - State management
- **Go Router** - Navigation
- **Injectable** - Dependency injection

### Backend (Planned)
- **NestJS** - Node.js backend framework
- **PostgreSQL** - Primary database
- **Redis** - Caching and sessions
- **WebSockets** - Real-time communication

### Security
- **AES-256-GCM** - Encryption algorithm
- **SHA-256** - Hashing algorithm
- **Biometric Authentication** - Device security
- **Certificate Pinning** - Network security

## 📱 Installation

### Prerequisites
- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- Git

### Setup
1. Clone the repository:
```bash
git clone https://github.com/your-username/smart-chat-app.git
cd smart-chat-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code:
```bash
flutter packages pub run build_runner build
```

4. Run the application:
```bash
flutter run
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:

```env
API_BASE_URL=https://api.smartchat.app
WS_URL=wss://ws.smartchat.app
ENCRYPTION_KEY=your_encryption_key
```

### Firebase Setup (Optional)
1. Create a Firebase project
2. Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Enable Authentication, Firestore, and Storage

## 🚀 Getting Started

### First Run
1. Launch the application
2. Create an account or sign in
3. Grant necessary permissions (camera, microphone, storage)
4. Set up biometric authentication (optional)
5. Start chatting!

### Key Features Walkthrough

#### Creating a Chat
1. Tap the floating action button
2. Select "New Chat" or "New Group"
3. Add participants
4. Start messaging

#### Smart Streaks
1. In any chat, tap the streak icon
2. Create content (photo, video, text)
3. Set privacy and timing options
4. Share with participants

#### Connection Suite
1. Navigate to the Connection tab
2. Choose an activity (breathing, music, rooms)
3. Invite your partner
4. Enjoy shared experiences

## 🔒 Security Features

### Encryption
- All messages are encrypted using AES-256-GCM
- Keys are generated per chat
- Forward secrecy implemented
- Double encryption for sensitive content

### Privacy
- Screenshot detection and alerts
- Screen recording protection
- Stealth mode for private browsing
- Metadata minimization

### Authentication
- Biometric authentication
- Two-factor authentication
- Session management
- Device trust verification

## 🤖 AI Features

### Relationship Assistant
- On-device AI processing
- Conversation analysis
- Relationship insights
- Smart suggestions

### Smart Features
- Auto-reply suggestions
- Message summarization
- Content search
- Voice processing

## 🎨 Customization

### Themes
- Light and dark themes
- Custom color schemes
- Font size adjustment
- Accessibility options

### UI Components
- Customizable message bubbles
- Animated reactions
- Gesture controls
- Accessibility support

## 📊 Performance

### Optimization
- Lazy loading for messages
- Image compression
- Efficient state management
- Memory optimization

### Monitoring
- Performance metrics
- Crash reporting
- User analytics
- Error tracking

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

## 📦 Building

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

### Code Style
- Follow Dart/Flutter conventions
- Use meaningful variable names
- Add comments for complex logic
- Maintain test coverage

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

### Documentation
- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Documentation](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

### Community
- [Discord Server](https://discord.gg/smartchat)
- [GitHub Discussions](https://github.com/your-username/smart-chat-app/discussions)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/smartchat)

### Bug Reports
Please use GitHub Issues to report bugs or request features.

## 🔮 Roadmap

### Phase 1 (Current)
- ✅ Core messaging functionality
- ✅ Authentication system
- ✅ Basic security features
- ✅ UI/UX foundation

### Phase 2 (Next)
- 🔄 Smart streaks implementation
- 🔄 AI features integration
- 🔄 Voice/video calling
- 🔄 Advanced security

### Phase 3 (Future)
- ⏳ Web application
- ⏳ Desktop clients
- ⏳ Advanced AI features
- ⏳ Blockchain integration

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- BLoC library contributors
- Security researchers and cryptographers
- Open source community

---

**SmartChat** - Connecting hearts through smart conversations 💙

Built with ❤️ using Flutter
