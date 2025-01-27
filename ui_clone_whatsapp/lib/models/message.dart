class Message {
  final String id;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final String type; // text, image, video, document
  final String? mediaUrl;
  final bool isRead;

  Message({
    required this.id,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.type,
    this.mediaUrl,
    this.isRead = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      type: json['type'],
      mediaUrl: json['mediaUrl'],
      isRead: json['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'mediaUrl': mediaUrl,
      'isRead': isRead,
    };
  }
}
