import 'package:flutter/material.dart';
import 'package:cached_network_image.dart';

class StatusList extends StatelessWidget {
  const StatusList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // My Status
        ListTile(
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          title: const Text('My Status'),
          subtitle: const Text('Tap to add status update'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Recent updates',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Mock Status Updates
        _StatusTile(
          name: 'John Doe',
          time: '10 minutes ago',
          imageUrl: 'https://placekitten.com/200/200',
        ),
        _StatusTile(
          name: 'Jane Smith',
          time: '35 minutes ago',
          imageUrl: 'https://placekitten.com/201/201',
        ),
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  final String name;
  final String time;
  final String imageUrl;

  const _StatusTile({
    required this.name,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.green,
            width: 2,
          ),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        ),
      ),
      title: Text(name),
      subtitle: Text(time),
      onTap: () {
        // TODO: View status
      },
    );
  }
}
