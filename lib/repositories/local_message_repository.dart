import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/message_model.dart';

class LocalMessageRepository {
  static const String _boxName = 'messages';
  Box<Message>? _messageBox;

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    _messageBox = await Hive.openBox<Message>(_boxName);

    // Agar box bo'sh bo'lsa, demo data qo'shamiz
    if (_messageBox!.isEmpty) {
      await _addDemoData();
    }
  }

  // Demo data (birinchi marta ochilganda)
  Future<void> _addDemoData() async {
    final demoMessages = [
      Message(
        id: '1',
        name: 'Miss Rita Schowalter',
        time: _formatTime(DateTime.now().subtract(const Duration(minutes: 12))),
        imageUrl: 'https://i.pravatar.cc/150?img=1',
        description: 'Thank you 😊',
        unreadCount: 3,
        isOnline: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      Message(
        id: '2',
        name: 'Lorena Farrell',
        time: _formatTime(DateTime.now().subtract(const Duration(hours: 2))),
        imageUrl: 'https://i.pravatar.cc/150?img=2',
        description: 'Yes! please take a order',
        unreadCount: null,
        isOnline: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Message(
        id: '3',
        name: 'Amos Hessel',
        time: _formatTime(DateTime.now().subtract(const Duration(hours: 5))),
        imageUrl: 'https://i.pravatar.cc/150?img=3',
        description: 'I think this one is good',
        unreadCount: null,
        isOnline: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      Message(
        id: '4',
        name: 'Ollie Haley',
        time: _formatTime(DateTime.now().subtract(const Duration(hours: 8))),
        imageUrl: 'https://i.pravatar.cc/150?img=4',
        description: 'Wow, this is really epic',
        unreadCount: null,
        isOnline: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      ),
      Message(
        id: '5',
        name: 'Traci Maggio',
        time: _formatTime(DateTime.now().subtract(const Duration(hours: 10))),
        imageUrl: 'https://i.pravatar.cc/150?img=5',
        description: 'omg, this is amazing',
        unreadCount: 1,
        isOnline: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 10)),
      ),
      Message(
        id: '6',
        name: 'Mathew Konopelski',
        time: 'yesterday',
        imageUrl: 'https://i.pravatar.cc/150?img=6',
        description: 'wooboooo',
        unreadCount: null,
        isOnline: false,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    for (var message in demoMessages) {
      await _messageBox!.put(message.id, message);
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return DateFormat('h:mm a').format(dateTime);
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM dd').format(dateTime);
    }
  }

  // Get all messages
  Future<List<Message>> getMessages() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate loading

    final messages = _messageBox!.values.toList();
    // Sort by timestamp (newest first)
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return messages;
  }

  // Add new message
  Future<void> addMessage(Message message) async {
    await _messageBox!.put(message.id, message);
  }

  // Update message
  Future<void> updateMessage(Message message) async {
    await _messageBox!.put(message.id, message);
  }

  // Mark as read
  Future<void> markAsRead(String messageId) async {
    final message = _messageBox!.get(messageId);
    if (message != null) {
      final updatedMessage = message.copyWith(unreadCount: 0);
      await _messageBox!.put(messageId, updatedMessage);
    }
  }

  // Delete message
  Future<void> deleteMessage(String messageId) async {
    await _messageBox!.delete(messageId);
  }

  // Search messages
  Future<List<Message>> searchMessages(String query) async {
    final messages = await getMessages();

    if (query.isEmpty) return messages;

    return messages.where((msg) {
      final nameLower = msg.name.toLowerCase();
      final descLower = msg.description.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower) || descLower.contains(queryLower);
    }).toList();
  }

  // Get total unread count
  Future<int> getUnreadCount() async {
    final messages = await getMessages();
    return messages
        .where((msg) => msg.unreadCount != null && msg.unreadCount! > 0)
        .fold<int>(0, (sum, msg) => sum + msg.unreadCount!);
  }

  // Clear all messages (for testing)
  Future<void> clearAllMessages() async {
    await _messageBox!.clear();
  }

  // Close box
  Future<void> close() async {
    await _messageBox?.close();
  }
}