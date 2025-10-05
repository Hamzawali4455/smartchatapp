import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/connection_bloc.dart';

class MoodMusicWidget extends StatefulWidget {
  const MoodMusicWidget({super.key});

  @override
  State<MoodMusicWidget> createState() => _MoodMusicWidgetState();
}

class _MoodMusicWidgetState extends State<MoodMusicWidget> {
  String _selectedMood = 'Happy';
  List<String> _playlist = [];

  final List<String> _moods = [
    'Happy',
    'Sad',
    'Calm',
    'Energetic',
    'Romantic',
    'Nostalgic',
    'Peaceful',
    'Excited',
  ];

  final Map<String, List<String>> _moodPlaylists = {
    'Happy': [
      'Sunshine - John Mayer',
      'Good Day - Nappy Roots',
      'Walking on Sunshine - Katrina and the Waves',
    ],
    'Sad': [
      'Hurt - Johnny Cash',
      'Mad World - Gary Jules',
      'The Sound of Silence - Simon & Garfunkel',
    ],
    'Calm': [
      'Weightless - Marconi Union',
      'Clair de Lune - Claude Debussy',
      'River Flows in You - Yiruma',
    ],
    'Energetic': [
      'Eye of the Tiger - Survivor',
      'Don\'t Stop Me Now - Queen',
      'Stronger - Kanye West',
    ],
    'Romantic': [
      'Perfect - Ed Sheeran',
      'All of Me - John Legend',
      'Thinking Out Loud - Ed Sheeran',
    ],
    'Nostalgic': [
      'Time After Time - Cyndi Lauper',
      'Yesterday - The Beatles',
      'Wonderwall - Oasis',
    ],
    'Peaceful': [
      'Meditation - Enya',
      'Spiritual - Santana',
      'Om - Deva Premal',
    ],
    'Excited': [
      'Happy - Pharrell Williams',
      'Uptown Funk - Bruno Mars',
      'Can\'t Stop the Feeling - Justin Timberlake',
    ],
  };

  @override
  void initState() {
    super.initState();
    _updatePlaylist();
  }

  void _updatePlaylist() {
    setState(() {
      _playlist = _moodPlaylists[_selectedMood] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mood Music',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Mood Selector
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Your Mood',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _moods.map((mood) {
                    final isSelected = mood == _selectedMood;
                    return FilterChip(
                      label: Text(mood),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _selectedMood = mood;
                          });
                          _updatePlaylist();
                        }
                      },
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Playlist
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested Playlist',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _playlist.length,
                      itemBuilder: (context, index) {
                        final song = _playlist[index];
                        return ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.music_note,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          title: Text(song),
                          subtitle: Text('Shared mood: $_selectedMood'),
                          trailing: IconButton(
                            icon: const Icon(Icons.play_arrow),
                            onPressed: () {
                              // TODO: Implement play song
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // TODO: Implement share mood
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Share Mood'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement sync playlist
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Sync Playlist'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
