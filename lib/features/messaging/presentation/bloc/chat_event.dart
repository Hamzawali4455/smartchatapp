part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChats extends ChatEvent {
  const LoadChats();
}

class LoadMessages extends ChatEvent {
  final String chatId;

  const LoadMessages({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendMessage extends ChatEvent {
  final MessageEntity message;

  const SendMessage({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateChat extends ChatEvent {
  final List<String> participants;

  const CreateChat({required this.participants});

  @override
  List<Object> get props => [participants];
}

class MessageReceived extends ChatEvent {
  final MessageEntity message;

  const MessageReceived({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageStatusUpdated extends ChatEvent {
  final String messageId;
  final MessageStatus status;

  const MessageStatusUpdated({
    required this.messageId,
    required this.status,
  });

  @override
  List<Object> get props => [messageId, status];
}

class ChatUpdated extends ChatEvent {
  final ChatEntity chat;

  const ChatUpdated({required this.chat});

  @override
  List<Object> get props => [chat];
}
