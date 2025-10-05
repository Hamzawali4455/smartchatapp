import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final VoidCallback onAttachment;
  final VoidCallback onCamera;
  final VoidCallback onVoice;
  final VoidCallback onEmoji;

  const MessageInput({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onAttachment,
    required this.onCamera,
    required this.onVoice,
    required this.onEmoji,
  });

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool _isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Attachment Button
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: widget.onAttachment,
              tooltip: 'Attach File',
            ),
            // Camera Button
            IconButton(
              icon: const Icon(Icons.camera_alt),
              onPressed: widget.onCamera,
              tooltip: 'Camera',
            ),
            // Text Input
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    // Emoji Button
                    IconButton(
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      onPressed: widget.onEmoji,
                      tooltip: 'Emoji',
                    ),
                    // Text Field
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                        ),
                        maxLines: 5,
                        minLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            widget.onSend(value.trim());
                          }
                        },
                      ),
                    ),
                    // Send/Voice Button
                    if (widget.controller.text.trim().isEmpty)
                      GestureDetector(
                        onTapDown: (_) => _startRecording(),
                        onTapUp: (_) => _stopRecording(),
                        onTapCancel: _cancelRecording,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            _isRecording ? Icons.stop : Icons.mic,
                            color: _isRecording 
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      )
                    else
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          widget.onSend(widget.controller.text.trim());
                        },
                        tooltip: 'Send',
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    widget.onVoice();
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
  }

  void _cancelRecording() {
    setState(() {
      _isRecording = false;
    });
  }
}
