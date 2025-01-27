import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:ui_clone_whatsapp/widgets/message_bubble.dart';
import 'package:ui_clone_whatsapp/models/message.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String profileImage;

  const ChatScreen({
    super.key,
    required this.name,
    required this.profileImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _showEmoji = false;
  bool _isAttachmentOpen = false;

  // Mock messages for UI demonstration
  final List<Message> _messages = [
    Message(
      id: '1',
      senderId: 'user1',
      content: 'Hey there!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      type: 'text',
    ),
    Message(
      id: '2',
      senderId: 'user2',
      content: 'Hi! How are you?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      type: 'text',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _toggleEmojiPicker() {
    setState(() {
      _showEmoji = !_showEmoji;
      _isAttachmentOpen = false;
    });
  }

  void _toggleAttachment() {
    setState(() {
      _isAttachmentOpen = !_isAttachmentOpen;
      _showEmoji = false;
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(Message(
        id: DateTime.now().toString(),
        senderId: 'user1',
        content: _messageController.text,
        timestamp: DateTime.now(),
        type: 'text',
      ));
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
              radius: 20,
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name),
            const Text(
              'online',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // TODO: Implement video call
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // TODO: Implement voice call
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // TODO: Implement menu actions
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view_contact',
                child: Text('View contact'),
              ),
              const PopupMenuItem(
                value: 'media',
                child: Text('Media, links, and docs'),
              ),
              const PopupMenuItem(
                value: 'search',
                child: Text('Search'),
              ),
              const PopupMenuItem(
                value: 'mute',
                child: Text('Mute notifications'),
              ),
              const PopupMenuItem(
                value: 'wallpaper',
                child: Text('Wallpaper'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[_messages.length - 1 - index];
                    return MessageBubble(
                      message: message,
                      isMe: message.senderId == 'user1',
                    );
                  },
                ),
              ),
              if (_isAttachmentOpen) _buildAttachmentPicker(),
              _buildMessageInput(),
              if (_showEmoji) _buildEmojiPicker(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _showEmoji ? Icons.keyboard : Icons.emoji_emotions_outlined,
            ),
            onPressed: _toggleEmojiPicker,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _toggleAttachment,
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              // TODO: Implement camera
            },
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: 250,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {
          _messageController.text += emoji.emoji;
        },
      ),
    );
  }

  Widget _buildAttachmentPicker() {
    return Container(
      height: 280,
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 3,
        children: [
          _attachmentOption(Icons.insert_drive_file, 'Document', Colors.indigo),
          _attachmentOption(Icons.camera_alt, 'Camera', Colors.pink),
          _attachmentOption(Icons.insert_photo, 'Gallery', Colors.purple),
          _attachmentOption(Icons.headphones, 'Audio', Colors.orange),
          _attachmentOption(Icons.location_on, 'Location', Colors.teal),
          _attachmentOption(Icons.person, 'Contact', Colors.blue),
        ],
      ),
    );
  }

  Widget _attachmentOption(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
