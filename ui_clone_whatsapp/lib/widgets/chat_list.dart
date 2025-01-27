import 'package:flutter/material.dart';
import 'package:ui_clone_whatsapp/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual chat data from Firebase
    final List<Map<String, dynamic>> mockChats = [
      {
        'name': 'John Doe',
        'lastMessage': 'Hey, how are you?',
        'time': '10:30 AM',
        'unreadCount': 2,
        'profileImage': 'https://placekitten.com/200/200',
      },
      {
        'name': 'Jane Smith',
        'lastMessage': 'Meeting at 3 PM',
        'time': '9:45 AM',
        'unreadCount': 0,
        'profileImage': 'https://placekitten.com/201/201',
      },
    ];

    return ListView.separated(
      itemCount: mockChats.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final chat = mockChats[index];
        return ChatTile(
          name: chat['name'],
          lastMessage: chat['lastMessage'],
          time: chat['time'],
          unreadCount: chat['unreadCount'],
          profileImage: chat['profileImage'],
          onTap: () {
            // TODO: Navigate to chat screen
          },
        );
      },
    );
  }
}
