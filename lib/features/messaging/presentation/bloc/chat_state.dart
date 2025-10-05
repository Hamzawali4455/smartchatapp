part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatsLoaded extends ChatState {
  final List<ChatEntity> chats;
  final List<MessageEntity>? currentChatMessages;
  final bool isLoadingMessages;
  final String? selectedChatId;

  const ChatsLoaded({
    required this.chats,
    this.currentChatMessages,
    this.isLoadingMessages = false,
    this.selectedChatId,
  });

  @override
  List<Object?> get props => [
        chats,
        currentChatMessages,
        isLoadingMessages,
        selectedChatId,
      ];

  ChatsLoaded copyWith({
    List<ChatEntity>? chats,
    List<MessageEntity>? currentChatMessages,
    bool? isLoadingMessages,
    String? selectedChatId,
  }) {
    return ChatsLoaded(
      chats: chats ?? this.chats,
      currentChatMessages: currentChatMessages ?? this.currentChatMessages,
      isLoadingMessages: isLoadingMessages ?? this.isLoadingMessages,
      selectedChatId: selectedChatId ?? this.selectedChatId,
    );
  }
}

class ChatFailure extends ChatState {
  final String message;

  const ChatFailure(this.message);

  @override
  List<Object> get props => [message];
}
