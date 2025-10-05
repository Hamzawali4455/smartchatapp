import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String chatId;
  final VoidCallback onBack;
  final VoidCallback onCall;
  final VoidCallback onVideoCall;
  final VoidCallback onInfo;

  const ChatAppBar({
    super.key,
    required this.chatId,
    required this.onBack,
    required this.onCall,
    required this.onVideoCall,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack,
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: null, // TODO: Get chat avatar
            child: Text(
              'C', // TODO: Get chat name initial
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat Name', // TODO: Get actual chat name
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Online', // TODO: Get actual status
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call),
          onPressed: onCall,
          tooltip: 'Voice Call',
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: onVideoCall,
          tooltip: 'Video Call',
        ),
        IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: onInfo,
          tooltip: 'Chat Info',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
