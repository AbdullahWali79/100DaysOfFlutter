import 'package:flutter/material.dart';
import 'package:cached_network_image.dart';
import 'package:ui_clone_whatsapp/screens/call_screen.dart';

class CallsList extends StatelessWidget {
  const CallsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _CallTile(
          name: 'John Doe',
          time: 'Today, 10:30 AM',
          imageUrl: 'https://placekitten.com/200/200',
          isVideoCall: true,
          isMissed: false,
          isIncoming: true,
        ),
        _CallTile(
          name: 'Jane Smith',
          time: 'Yesterday, 8:45 PM',
          imageUrl: 'https://placekitten.com/201/201',
          isVideoCall: false,
          isMissed: true,
          isIncoming: false,
        ),
      ],
    );
  }
}

class _CallTile extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;
  final bool isVideoCall;
  final bool isMissed;
  final bool isIncoming;

  const _CallTile({
    required this.name,
    required this.time,
    required this.imageUrl,
    required this.isVideoCall,
    required this.isMissed,
    required this.isIncoming,
  });

  void _startCall(BuildContext context, bool isVideo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallScreen(
          name: name,
          profileImage: imageUrl,
          isVideoCall: isVideo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(imageUrl),
      ),
      title: Text(name),
      subtitle: Row(
        children: [
          Icon(
            isIncoming ? Icons.call_received : Icons.call_made,
            size: 15,
            color: isMissed ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 4),
          Text(time),
        ],
      ),
      trailing: IconButton(
        icon: Icon(isVideoCall ? Icons.videocam : Icons.call),
        color: Theme.of(context).primaryColor,
        onPressed: () => _startCall(context, isVideoCall),
      ),
      onTap: () => _startCall(context, isVideoCall),
    );
  }
}
