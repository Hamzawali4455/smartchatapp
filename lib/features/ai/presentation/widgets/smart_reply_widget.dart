import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/ai_bloc.dart';

class SmartReplyWidget extends StatefulWidget {
  final String message;
  final List<Map<String, String>>? conversationHistory;
  final Function(String) onReplySelected;

  const SmartReplyWidget({
    super.key,
    required this.message,
    this.conversationHistory,
    required this.onReplySelected,
  });

  @override
  State<SmartReplyWidget> createState() => _SmartReplyWidgetState();
}

class _SmartReplyWidgetState extends State<SmartReplyWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AiBloc>().add(GetSmartReplies(
      message: widget.message,
      conversationHistory: widget.conversationHistory,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiBloc, AiState>(
      builder: (context, state) {
        if (state is SmartRepliesLoaded) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Smart Replies',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.replies.map((reply) {
                    return GestureDetector(
                      onTap: () => widget.onReplySelected(reply),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          reply,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        } else if (state is AiLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is AiError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Unable to generate smart replies',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontSize: 14,
              ),
            ),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
