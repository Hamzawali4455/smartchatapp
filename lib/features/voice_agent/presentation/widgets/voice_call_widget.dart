import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/voice_agent_bloc.dart';

class VoiceCallWidget extends StatefulWidget {
  final String? phoneNumber;
  final String? userId;
  final Map<String, dynamic>? customData;

  const VoiceCallWidget({
    super.key,
    this.phoneNumber,
    this.userId,
    this.customData,
  });

  @override
  State<VoiceCallWidget> createState() => _VoiceCallWidgetState();
}

class _VoiceCallWidgetState extends State<VoiceCallWidget> {
  String? _currentCallId;
  bool _isCallActive = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceAgentBloc, VoiceAgentState>(
      listener: (context, state) {
        if (state is VoiceCallStarted) {
          setState(() {
            _currentCallId = state.callData['id'];
            _isCallActive = true;
          });
          _showCallStartedDialog(context, state.callData);
        } else if (state is VoiceCallEnded) {
          setState(() {
            _isCallActive = false;
            _currentCallId = null;
          });
          _showCallEndedDialog(context, state.callData);
        } else if (state is VoiceAgentError) {
          _showErrorDialog(context, state.message);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Voice Call Button
            GestureDetector(
              onTap: _isCallActive ? _endCall : _startCall,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isCallActive 
                      ? Colors.red 
                      : Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: (_isCallActive ? Colors.red : Theme.of(context).primaryColor)
                          .withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  _isCallActive ? Icons.call_end : Icons.call,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Call Status
            Text(
              _isCallActive ? 'Call Active' : 'Start Voice Call',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _isCallActive ? Colors.red : Theme.of(context).primaryColor,
              ),
            ),
            
            if (_isCallActive) ...[
              const SizedBox(height: 8),
              Text(
                'Tap to end call',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _startCall() {
    context.read<VoiceAgentBloc>().add(StartVoiceCall(
      phoneNumber: widget.phoneNumber,
      userId: widget.userId,
      customData: widget.customData,
    ));
  }

  void _endCall() {
    if (_currentCallId != null) {
      context.read<VoiceAgentBloc>().add(EndVoiceCall(_currentCallId!));
    }
  }

  void _showCallStartedDialog(BuildContext context, Map<String, dynamic> callData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Call Started'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.call,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('Call ID: ${callData['id']}'),
            if (callData['phoneNumber'] != null)
              Text('Phone: ${callData['phoneNumber']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showCallEndedDialog(BuildContext context, Map<String, dynamic> callData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Call Ended'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.call_end,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('Call ID: ${callData['id']}'),
            if (callData['duration'] != null)
              Text('Duration: ${callData['duration']} seconds'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Voice Call Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
