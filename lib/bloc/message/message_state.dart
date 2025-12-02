import 'package:equatable/equatable.dart';
import '../../models/message_model.dart';

abstract class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;
  final bool isSearching;
  final String searchQuery;

  const MessageLoaded({
    required this.messages,
    this.isSearching = false,
    this.searchQuery = '',
  });

  int get totalUnreadCount {
    return messages
        .where((msg) => msg.unreadCount != null && msg.unreadCount! > 0)
        .fold(0, (sum, msg) => sum + msg.unreadCount!);
  }

  MessageLoaded copyWith({
    List<Message>? messages,
    bool? isSearching,
    String? searchQuery,
  }) {
    return MessageLoaded(
      messages: messages ?? this.messages,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [messages, isSearching, searchQuery];
}

class MessageError extends MessageState {
  final String message;

  const MessageError(this.message);

  @override
  List<Object?> get props => [message];
}

class MessageOperationSuccess extends MessageState {
  final String message;

  const MessageOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}