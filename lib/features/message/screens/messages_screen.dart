import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grand_hotel/main_screen.dart';

import '../../../bloc/message/message_bloc.dart';
import '../../../bloc/message/message_event.dart';
import '../../../bloc/message/message_state.dart';
import '../../../models/message_model.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list, color: Colors.black),
          ),
        ],
      ),
      body: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state is MessageError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is MessageOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MessageLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF2853AF),
              ),
            );
          }

          if (state is MessageError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MessageBloc>().add(LoadMessages());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2853AF),
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is MessageLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                _searchController.clear();
                                context.read<MessageBloc>().add(ClearSearch());
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {}); // For suffixIcon visibility
                      if (value.isEmpty) {
                        context.read<MessageBloc>().add(ClearSearch());
                      } else {
                        context.read<MessageBloc>().add(SearchMessages(value));
                      }
                    },
                  ),
                ),

                // Messages list
                Expanded(
                  child: state.messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.isSearching
                                    ? 'No messages found'
                                    : 'No messages yet',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            context.read<MessageBloc>().add(RefreshMessages());
                            await Future.delayed(const Duration(seconds: 1));
                          },
                          color: const Color(0xFF2853AF),
                          child: ListView.separated(
                            padding: const EdgeInsets.only(bottom: 80),
                            itemCount: state.messages.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey.shade300,
                              indent: 80,
                            ),
                            itemBuilder: (context, index) {
                              final message = state.messages[index];
                              return _buildMessageTile(context, message);
                            },
                          ),
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => _showAddMessageDialog(context),
        backgroundColor: const Color(0xFF2853AF),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMessageTile(BuildContext context, Message message) {
    return Dismissible(
      key: Key(message.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Delete Message'),
              content:
                  const Text('Are you sure you want to delete this message?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        context.read<MessageBloc>().add(DeleteMessage(message.id));
      },
      child: InkWell(
        onTap: () {
          if (message.unreadCount != null && message.unreadCount! > 0) {
            context.read<MessageBloc>().add(MarkMessageAsRead(message.id));
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(message: message),
            ),
          );
          // Navigate to chat screen
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(message.imageUrl),
                    backgroundColor: Colors.grey[300],
                    onBackgroundImageError: (_, __) {},
                    child: message.imageUrl.isEmpty
                        ? Text(
                            message.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  if (message.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: message.unreadCount != null &&
                                message.unreadCount! > 0
                            ? FontWeight.bold
                            : FontWeight.w600,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: message.unreadCount != null &&
                                message.unreadCount! > 0
                            ? Colors.black87
                            : Colors.grey[600],
                        fontWeight: message.unreadCount != null &&
                                message.unreadCount! > 0
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: message.unreadCount != null &&
                              message.unreadCount! > 0
                          ? const Color(0xFF2853AF)
                          : Colors.grey[500],
                      fontWeight: message.unreadCount != null &&
                              message.unreadCount! > 0
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                  if (message.unreadCount != null &&
                      message.unreadCount! > 0) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        shape: BoxShape.circle,
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Center(
                        child: Text(
                          '${message.unreadCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddMessageDialog(BuildContext blocContext) {
    final nameController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.add_comment, color: Color(0xFF2853AF)),
              SizedBox(width: 8),
              Text('New Message'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Enter message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.message),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                FocusScope.of(dialogContext).unfocus();
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(dialogContext);
                });
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final message = messageController.text.trim();

                if (name.isEmpty || message.isEmpty) {
                  ScaffoldMessenger.of(blocContext).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return;
                }

                FocusScope.of(dialogContext).unfocus();

                blocContext.read<MessageBloc>().add(
                      AddMessage(
                        name: name,
                        description: message,
                        imageUrl: 'https://i.pravatar.cc/150?img=7',
                      ),
                    );

                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(dialogContext);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2853AF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    ).then((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        nameController.dispose();
        messageController.dispose();
      });
    });
  }
}
