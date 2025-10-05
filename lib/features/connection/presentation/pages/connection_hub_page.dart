import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/connection_bloc.dart' as connection_bloc;
import '../widgets/connection_card.dart';
import '../widgets/breathing_exercise_widget.dart';
import '../widgets/mood_music_widget.dart';
import '../widgets/shared_room_widget.dart';

class ConnectionHubPage extends StatefulWidget {
  const ConnectionHubPage({super.key});

  @override
  State<ConnectionHubPage> createState() => _ConnectionHubPageState();
}

class _ConnectionHubPageState extends State<ConnectionHubPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<connection_bloc.ConnectionBloc>().add(const connection_bloc.LoadConnectionHub());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Hub'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.favorite), text: 'Connect'),
            Tab(icon: Icon(Icons.psychology), text: 'Mind'),
            Tab(icon: Icon(Icons.people), text: 'Together'),
          ],
        ),
      ),
      body: BlocBuilder<connection_bloc.ConnectionBloc, connection_bloc.ConnectionState>(
        builder: (context, state) {
          if (state is connection_bloc.ConnectionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is connection_bloc.ConnectionFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load connection hub',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<connection_bloc.ConnectionBloc>().add(const connection_bloc.LoadConnectionHub());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildConnectTab(context),
              _buildMindTab(context),
              _buildTogetherTab(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildConnectTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deep Connections',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Breathing Exercises
          ConnectionCard(
            title: 'Shared Breathing',
            subtitle: 'Synchronize your breath with your partner',
            icon: Icons.air,
            color: Colors.blue,
            onTap: () {
              _showBreathingExercise();
            },
          ),
          const SizedBox(height: 16),
          // Heartbeat Sharing
          ConnectionCard(
            title: 'Heartbeat Replay',
            subtitle: 'Share your heartbeat in real-time',
            icon: Icons.favorite,
            color: Colors.red,
            onTap: () {
              _showHeartbeatSharing();
            },
          ),
          const SizedBox(height: 16),
          // Silent Hug
          ConnectionCard(
            title: 'Silent Hug',
            subtitle: 'Send a warm virtual embrace',
            icon: Icons.sentiment_very_satisfied,
            color: Colors.pink,
            onTap: () {
              _showSilentHug();
            },
          ),
          const SizedBox(height: 16),
          // Memory Triggers
          ConnectionCard(
            title: 'Memory Triggers',
            subtitle: 'Relive beautiful moments together',
            icon: Icons.auto_awesome,
            color: Colors.purple,
            onTap: () {
              _showMemoryTriggers();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMindTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mental Wellness',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Mood Music
          ConnectionCard(
            title: 'Mood Music',
            subtitle: 'Share music that matches your feelings',
            icon: Icons.music_note,
            color: Colors.green,
            onTap: () {
              _showMoodMusic();
            },
          ),
          const SizedBox(height: 16),
          // Mood Roulette
          ConnectionCard(
            title: 'Mood Roulette',
            subtitle: 'Discover new emotions together',
            icon: Icons.casino,
            color: Colors.orange,
            onTap: () {
              _showMoodRoulette();
            },
          ),
          const SizedBox(height: 16),
          // Voice Moods
          ConnectionCard(
            title: 'Voice Moods',
            subtitle: 'Express feelings through voice',
            icon: Icons.record_voice_over,
            color: Colors.teal,
            onTap: () {
              _showVoiceMoods();
            },
          ),
          const SizedBox(height: 16),
          // AI Relationship Assistant
          ConnectionCard(
            title: 'AI Assistant',
            subtitle: 'Get insights about your relationship',
            icon: Icons.psychology,
            color: Colors.indigo,
            onTap: () {
              _showAIAssistant();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTogetherTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shared Experiences',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // 3D Shared Rooms
          ConnectionCard(
            title: '3D Shared Rooms',
            subtitle: 'Meet in virtual spaces',
            icon: Icons.home,
            color: Colors.brown,
            onTap: () {
              _showSharedRooms();
            },
          ),
          const SizedBox(height: 16),
          // Collaborative Drawing
          ConnectionCard(
            title: 'Doodle Together',
            subtitle: 'Create art collaboratively',
            icon: Icons.brush,
            color: Colors.cyan,
            onTap: () {
              _showDoodleSession();
            },
          ),
          const SizedBox(height: 16),
          // Watch Together
          ConnectionCard(
            title: 'Watch Together',
            subtitle: 'Enjoy videos and music together',
            icon: Icons.play_circle,
            color: Colors.deepOrange,
            onTap: () {
              _showWatchTogether();
            },
          ),
          const SizedBox(height: 16),
          // Mini Games
          ConnectionCard(
            title: 'Mini Games',
            subtitle: 'Play fun games together',
            icon: Icons.games,
            color: Colors.lime,
            onTap: () {
              _showMiniGames();
            },
          ),
          const SizedBox(height: 16),
          // Relationship Journal
          ConnectionCard(
            title: 'Relationship Journal',
            subtitle: 'Document your journey together',
            icon: Icons.book,
            color: Colors.amber,
            onTap: () {
              _showRelationshipJournal();
            },
          ),
        ],
      ),
    );
  }

  void _showBreathingExercise() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const BreathingExerciseWidget(),
    );
  }

  void _showHeartbeatSharing() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Heartbeat Sharing'),
        content: const Text('This feature allows you to share your heartbeat in real-time with your partner.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement heartbeat sharing
            },
            child: const Text('Start Sharing'),
          ),
        ],
      ),
    );
  }

  void _showSilentHug() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Silent Hug'),
        content: const Text('Send a warm virtual embrace to your partner.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement silent hug
            },
            child: const Text('Send Hug'),
          ),
        ],
      ),
    );
  }

  void _showMemoryTriggers() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Memory Triggers'),
        content: const Text('Share and relive beautiful moments together.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement memory triggers
            },
            child: const Text('Browse Memories'),
          ),
        ],
      ),
    );
  }

  void _showMoodMusic() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const MoodMusicWidget(),
    );
  }

  void _showMoodRoulette() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mood Roulette'),
        content: const Text('Discover new emotions and moods together.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement mood roulette
            },
            child: const Text('Start Roulette'),
          ),
        ],
      ),
    );
  }

  void _showVoiceMoods() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Moods'),
        content: const Text('Express your feelings through voice and ambient sounds.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement voice moods
            },
            child: const Text('Start Voice Mood'),
          ),
        ],
      ),
    );
  }

  void _showAIAssistant() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('AI Relationship Assistant'),
        content: const Text('Get insights and suggestions about your relationship.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement AI assistant
            },
            child: const Text('Open Assistant'),
          ),
        ],
      ),
    );
  }

  void _showSharedRooms() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const SharedRoomWidget(),
    );
  }

  void _showDoodleSession() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start Doodle Session'),
        content: const Text('Create art collaboratively with your partner.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement doodle session
            },
            child: const Text('Start Drawing'),
          ),
        ],
      ),
    );
  }

  void _showWatchTogether() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Watch Together'),
        content: const Text('Enjoy videos and music together in sync.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement watch together
            },
            child: const Text('Start Watching'),
          ),
        ],
      ),
    );
  }

  void _showMiniGames() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mini Games'),
        content: const Text('Play fun games together.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement mini games
            },
            child: const Text('Play Games'),
          ),
        ],
      ),
    );
  }

  void _showRelationshipJournal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Relationship Journal'),
        content: const Text('Document your journey together.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement relationship journal
            },
            child: const Text('Open Journal'),
          ),
        ],
      ),
    );
  }
}
