import 'package:flutter/material.dart';

class FloatingActionButtonMenu extends StatefulWidget {
  final VoidCallback onNewChat;
  final VoidCallback onNewGroup;
  final VoidCallback onScanQR;

  const FloatingActionButtonMenu({
    super.key,
    required this.onNewChat,
    required this.onNewGroup,
    required this.onScanQR,
  });

  @override
  State<FloatingActionButtonMenu> createState() => _FloatingActionButtonMenuState();
}

class _FloatingActionButtonMenuState extends State<FloatingActionButtonMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
    });

    if (_isOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Opacity(
                opacity: _animation.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Scan QR Code
                    FloatingActionButton(
                      heroTag: 'scan_qr',
                      mini: true,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        _toggleMenu();
                        widget.onScanQR();
                      },
                      child: const Icon(Icons.qr_code_scanner),
                    ),
                    const SizedBox(height: 8),
                    // New Group
                    FloatingActionButton(
                      heroTag: 'new_group',
                      mini: true,
                      backgroundColor: Theme.of(context).colorScheme.tertiary,
                      onPressed: () {
                        _toggleMenu();
                        widget.onNewGroup();
                      },
                      child: const Icon(Icons.group_add),
                    ),
                    const SizedBox(height: 8),
                    // New Chat
                    FloatingActionButton(
                      heroTag: 'new_chat',
                      mini: true,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        _toggleMenu();
                        widget.onNewChat();
                      },
                      child: const Icon(Icons.chat),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
        // Main FAB
        FloatingActionButton(
          heroTag: 'main_fab',
          onPressed: _toggleMenu,
          child: AnimatedRotation(
            turns: _isOpen ? 0.125 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(_isOpen ? Icons.close : Icons.add),
          ),
        ),
      ],
    );
  }
}
