import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../chat/domain/entities/chat_entity.dart';
import '../../../chat/domain/entities/message_entity.dart';
import '../../../chat/domain/usecases/get_chats_usecase.dart';
import '../../../chat/domain/usecases/get_messages_usecase.dart';
import '../../../chat/domain/usecases/send_message_usecase.dart';
import '../../../chat/domain/usecases/create_chat_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final CreateChatUseCase createChatUseCase;

  ChatBloc({
    required this.getChatsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.createChatUseCase,
  }) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<CreateChat>(_onCreateChat);
    on<MessageReceived>(_onMessageReceived);
    on<MessageStatusUpdated>(_onMessageStatusUpdated);
    on<ChatUpdated>(_onChatUpdated);
  }

  Future<void> _onLoadChats(
    LoadChats event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    
    try {
      final result = await getChatsUseCase();
      
      result.fold(
        (failure) => emit(ChatFailure(failure.message)),
        (chats) => emit(ChatsLoaded(chats: chats)),
      );
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatsLoaded) {
      emit((state as ChatsLoaded).copyWith(isLoadingMessages: true));
    }
    
    try {
      final result = await getMessagesUseCase(event.chatId);
      
      result.fold(
        (failure) => emit(ChatFailure(failure.message)),
        (messages) {
          if (state is ChatsLoaded) {
            emit((state as ChatsLoaded).copyWith(
              isLoadingMessages: false,
              currentChatMessages: messages,
            ));
          }
        },
      );
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final result = await sendMessageUseCase(event.message);
      
      result.fold(
        (failure) => emit(ChatFailure(failure.message)),
        (message) {
          if (state is ChatsLoaded) {
            final currentState = state as ChatsLoaded;
            final updatedMessages = <MessageEntity>[...(currentState.currentChatMessages ?? []), message];
            
            emit(currentState.copyWith(
              currentChatMessages: updatedMessages,
            ));
          }
        },
      );
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onCreateChat(
    CreateChat event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final result = await createChatUseCase(event.participants);
      
      result.fold(
        (failure) => emit(ChatFailure(failure.message)),
        (chat) {
          if (state is ChatsLoaded) {
            final currentState = state as ChatsLoaded;
            final updatedChats = <ChatEntity>[chat, ...currentState.chats];
            
            emit(currentState.copyWith(chats: updatedChats));
          }
        },
      );
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onMessageReceived(
    MessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatsLoaded) {
      final currentState = state as ChatsLoaded;
      final updatedMessages = <MessageEntity>[...(currentState.currentChatMessages ?? []), event.message];
      
      emit(currentState.copyWith(
        currentChatMessages: updatedMessages,
      ));
    }
  }

  Future<void> _onMessageStatusUpdated(
    MessageStatusUpdated event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatsLoaded) {
      final currentState = state as ChatsLoaded;
      final updatedMessages = currentState.currentChatMessages?.map((message) {
        if (message.id == event.messageId) {
          return message.copyWith(status: event.status);
        }
        return message;
      }).toList();
      
      emit(currentState.copyWith(
        currentChatMessages: updatedMessages,
      ));
    }
  }

  Future<void> _onChatUpdated(
    ChatUpdated event,
    Emitter<ChatState> emit,
  ) async {
    if (state is ChatsLoaded) {
      final currentState = state as ChatsLoaded;
      final updatedChats = currentState.chats.map((chat) {
        if (chat.id == event.chat.id) {
          return event.chat;
        }
        return chat;
      }).toList();
      
      emit(currentState.copyWith(chats: updatedChats));
    }
  }
}
