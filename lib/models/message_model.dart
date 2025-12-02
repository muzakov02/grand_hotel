import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

// ❌ part directive ni o'chiring
// part 'message_model.g.dart';

class Message extends Equatable {
  final String id;
  final String name;
  final String time;
  final String imageUrl;
  final String description;
  final int? unreadCount;
  final bool isOnline;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.description,
    this.unreadCount,
    this.isOnline = false,
    required this.timestamp,
  });

  Message copyWith({
    String? id,
    String? name,
    String? time,
    String? imageUrl,
    String? description,
    int? unreadCount,
    bool? isOnline,
    DateTime? timestamp,
  }) {
    return Message(
      id: id ?? this.id,
      name: name ?? this.name,
      time: time ?? this.time,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      unreadCount: unreadCount ?? this.unreadCount,
      isOnline: isOnline ?? this.isOnline,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  // JSON serialization (Hive uchun)
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      name: json['name'] as String,
      time: json['time'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      unreadCount: json['unreadCount'] as int?,
      isOnline: json['isOnline'] as bool? ?? false,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'imageUrl': imageUrl,
      'description': description,
      'unreadCount': unreadCount,
      'isOnline': isOnline,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    time,
    imageUrl,
    description,
    unreadCount,
    isOnline,
    timestamp,
  ];
}

// ✅ Manual Hive Adapter
class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return Message(
      id: fields[0] as String,
      name: fields[1] as String,
      time: fields[2] as String,
      imageUrl: fields[3] as String,
      description: fields[4] as String,
      unreadCount: fields[5] as int?,
      isOnline: fields[6] as bool? ?? false,
      timestamp: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(8) // number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.unreadCount)
      ..writeByte(6)
      ..write(obj.isOnline)
      ..writeByte(7)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MessageAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}