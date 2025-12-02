import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../models/message_model.dart';
import '../../repositories/local_message_repository.dart';
import 'message_event.dart';
import 'message_state.dart';


class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final LocalMessageRepository repository;
  final _uuid = const Uuid();

  MessageBloc({required this.repository}) : super(MessageInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<RefreshMessages>(_onRefreshMessages);
    on<MarkMessageAsRead>(_onMarkAsRead);
    on<DeleteMessage>(_onDeleteMessage);
    on<SearchMessages>(_onSearchMessages);
    on<ClearSearch>(_onClearSearch);
    on<AddMessage>(_onAddMessage);
  }

  Future<void> _onLoadMessages(
      LoadMessages event,
      Emitter<MessageState> emit,
      ) async {
    emit(MessageLoading());

    try {
      final messages = await repository.getMessages();
      emit(MessageLoaded(messages: messages));
    } catch (e) {
      emit(MessageError('Failed to load messages: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshMessages(
      RefreshMessages event,
      Emitter<MessageState> emit,
      ) async {
    try {
      final messages = await repository.getMessages();
      emit(MessageLoaded(messages: messages));
    } catch (e) {
      if (state is MessageLoaded) {
        return;
      }
      emit(MessageError('Failed to refresh messages: ${e.toString()}'));
    }
  }

  Future<void> _onMarkAsRead(
      MarkMessageAsRead event,
      Emitter<MessageState> emit,
      ) async {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      try {
        await repository.markAsRead(event.messageId);
        final messages = await repository.getMessages();
        emit(currentState.copyWith(messages: messages));
      } catch (e) {
        emit(MessageError('Failed to mark as read: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onDeleteMessage(
      DeleteMessage event,
      Emitter<MessageState> emit,
      ) async {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      try {
        await repository.deleteMessage(event.messageId);
        final messages = await repository.getMessages();

        emit(currentState.copyWith(messages: messages));
        emit(const MessageOperationSuccess('Message deleted'));
        emit(currentState.copyWith(messages: messages));
      } catch (e) {
        emit(MessageError('Failed to delete message: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onSearchMessages(
      SearchMessages event,
      Emitter<MessageState> emit,
      ) async {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      try {
        final messages = await repository.searchMessages(event.query);
        emit(currentState.copyWith(
          messages: messages,
          isSearching: true,
          searchQuery: event.query,
        ));
      } catch (e) {
        emit(MessageError('Search failed: ${e.toString()}'));
        emit(currentState);
      }
    }
  }

  Future<void> _onClearSearch(
      ClearSearch event,
      Emitter<MessageState> emit,
      ) async {
    try {
      final messages = await repository.getMessages();
      emit(MessageLoaded(
        messages: messages,
        isSearching: false,
        searchQuery: '',
      ));
    } catch (e) {
      emit(MessageError('Failed to clear search: ${e.toString()}'));
    }
  }

  Future<void> _onAddMessage(
      AddMessage event,
      Emitter<MessageState> emit,
      ) async {
    if (state is MessageLoaded) {
      final currentState = state as MessageLoaded;

      try {
        final newMessage = Message(
          id: _uuid.v4(),
          name: event.name,
          time: 'Just now',
          imageUrl: event.imageUrl,
          description: event.description,
          unreadCount: 1,
          isOnline: false,
          timestamp: DateTime.now(),
        );

        await repository.addMessage(newMessage);
        final messages = await repository.getMessages();

        emit(currentState.copyWith(messages: messages));
        emit(const MessageOperationSuccess('Message added'));
        emit(currentState.copyWith(messages: messages));
      } catch (e) {
        emit(MessageError('Failed to add message: ${e.toString()}'));
        emit(currentState);
      }
    }
  }
}