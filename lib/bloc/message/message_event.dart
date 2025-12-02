import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object?> get props => [];
}

class LoadMessages extends MessageEvent {}

class RefreshMessages extends MessageEvent {}

class MarkMessageAsRead extends MessageEvent {
  final String messageId;

  const MarkMessageAsRead(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class DeleteMessage extends MessageEvent {
  final String messageId;

  const DeleteMessage(this.messageId);

  @override
  List<Object?> get props => [messageId];
}

class SearchMessages extends MessageEvent {
  final String query;

  const SearchMessages(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends MessageEvent {}

class AddMessage extends MessageEvent {
  final String name;
  final String description;
  final String imageUrl;

  const AddMessage({
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, description, imageUrl];
}