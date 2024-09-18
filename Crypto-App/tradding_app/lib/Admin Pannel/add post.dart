import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Post {
  final String image;
  final String videoUrl;
  final String voiceMessage;
  final List<String> fileUrls;

  Post({
    required this.image,
    required this.videoUrl,
    required this.voiceMessage,
    required this.fileUrls,
  });
}

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController _imageController = TextEditingController();
  TextEditingController _videoUrlController = TextEditingController();
  TextEditingController _voiceMessageController = TextEditingController();
  TextEditingController _fileUrlController = TextEditingController();

  List<String> fileUrls = [];

  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Trading App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Post:'),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _videoUrlController,
              decoration: InputDecoration(labelText: 'Video URL'),
            ),
            TextField(
              controller: _voiceMessageController,
              decoration: InputDecoration(labelText: 'Voice Message'),
            ),
            TextField(
              controller: _fileUrlController,
              decoration: InputDecoration(labelText: 'File URL'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  fileUrls.add(_fileUrlController.text);
                  _fileUrlController.clear();
                });
              },
              child: Center(child: Container(child: Text('Add File URL'))),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  posts.add(Post(
                    image: _imageController.text,
                    videoUrl: _videoUrlController.text,
                    voiceMessage: _voiceMessageController.text,
                    fileUrls: List.from(fileUrls),
                  ));
                  _imageController.clear();
                  _videoUrlController.clear();
                  _voiceMessageController.clear();
                  fileUrls.clear();
                });
              },
              child: Center(
                child: Container(
                  width: 70,
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Text('Add Post')),
              ),
            ),
            SizedBox(height: 16),
            Text('Posts:',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: posts.map((post) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (post.image.isNotEmpty) Image.network(post.image),
                      if (post.videoUrl.isNotEmpty)
                        ElevatedButton(
                          onPressed: () {
                            // Open YouTube video in InAppWebView
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoWebView(videoUrl: post.videoUrl),
                              ),
                            );
                          },
                          child: Text('Play Video'),
                        ),
                      if (post.voiceMessage.isNotEmpty)
                        Text('Voice Message: ${post.voiceMessage}'),
                      if (post.fileUrls.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('File URLs:'),
                            for (var fileUrl in post.fileUrls) Text(fileUrl),
                          ],
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoWebView extends StatelessWidget {
  final String videoUrl;

  VideoWebView({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video WebView'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(videoUrl)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true,
          ),
        ),
      ),
    );
  }
}
