import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final Message message;

  const ChatScreen({super.key, required this.message});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    // Demo messages
    _chatMessages.addAll([
      ChatMessage(
        text: widget.message.description,
        isMe: false,
        time: widget.message.time,
      ),
      ChatMessage(
        text: 'Hi Ahmir',
        isMe: false,
        time: '10:30 AM',
      ),
      ChatMessage(
        text: 'hi for this hotel with a king sweet room are there still any vacancies?',
        isMe: true,
        time: '10:15 AM',
      ),
    ]);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _chatMessages.add(ChatMessage(
          text: text,
          isMe: true,
          time: _getCurrentTime(),
        ));
      });
      _messageController.clear();
    }
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // ✅ User info section (AppBar dan keyin)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                // BoxShadow(
                //   color: Colors.grey.withValues(alpha: 0.1),
                //   blurRadius: 4,
                //   offset: const Offset(0, 2),
                // ),
              ],
            ),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(widget.message.imageUrl),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 12),

                // Name and status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.message.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.message.isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontSize: 13,
                          color: widget.message.isOnline
                              ? Colors.blue
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Video call button
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/video.svg',
                    width: 16,
                    height: 16,
                  ),
                ),

                // Audio call button
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/audio.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),

          // Hotel card (if needed)
          if (widget.message.description.toLowerCase().contains('hotel'))
            _buildHotelCard(),

          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final reversedIndex = _chatMessages.length - 1 - index;
                final chat = _chatMessages[reversedIndex];
                return _buildChatBubble(chat);
              },
            ),
          ),

          // Message input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFFE8F2FF),
                borderRadius: BorderRadius.circular(32),

              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Attach file
                    },
                    icon:SvgPicture.asset(
                      'assets/icons/paperclip.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Write a reply...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2853AF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // ✅ Hotel card widget (rasmga mos)
  Widget _buildHotelCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hotel image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.message.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Hotel info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'The Aston Vill Hotel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 2),
                    const Text(
                      '4.7',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Veum Point, Michikoton',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Row(
                  children: [
                    Text(
                      '\$120',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2853AF),
                      ),
                    ),
                    Text(
                      ' /night',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage chat) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
        chat.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!chat.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(widget.message.imageUrl),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
              chat.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color:
                    chat.isMe ? const Color(0xFF2853AF) : Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(chat.isMe ? 16 : 4),
                      bottomRight: Radius.circular(chat.isMe ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    chat.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: chat.isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.time,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chat message model
class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}