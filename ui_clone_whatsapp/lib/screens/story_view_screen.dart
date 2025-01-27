import 'package:flutter/material.dart';
import 'package:ui_clone_whatsapp/widgets/story_progress_bar.dart';

class StoryViewScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final List<StoryItem> stories;

  const StoryViewScreen({
    super.key,
    required this.userName,
    required this.userImage,
    required this.stories,
  });

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);
    _loadStory(animateToPage: false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadStory({bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = const Duration(seconds: 5);
    _animationController.forward().whenComplete(_nextStory);

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() {
        _currentIndex++;
        _loadStory();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _loadStory();
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    setState(() {
      _isPressed = true;
      _animationController.stop();
      
      if (dx < screenWidth / 3) {
        _previousStory();
      } else if (dx > 2 * screenWidth / 3) {
        _nextStory();
      }
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(story.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    if (story.caption != null)
                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,
                        child: Text(
                          story.caption!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Row(
                    children: widget.stories.asMap().map((i, e) {
                      return MapEntry(
                        i,
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: StoryProgressBar(
                              controller: _animationController,
                              isActive: i == _currentIndex,
                              isPaused: _isPressed,
                              isCompleted: i < _currentIndex,
                            ),
                          ),
                        ),
                      );
                    }).values.toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.userImage),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {
                          // Show story options
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryItem {
  final String imageUrl;
  final String? caption;
  final DateTime timestamp;

  StoryItem({
    required this.imageUrl,
    this.caption,
    required this.timestamp,
  });
}
