import 'package:flutter/material.dart';

class StoryProgressBar extends StatelessWidget {
  final AnimationController controller;
  final bool isActive;
  final bool isPaused;
  final bool isCompleted;

  const StoryProgressBar({
    super.key,
    required this.controller,
    required this.isActive,
    required this.isPaused,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 2,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        if (isCompleted)
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          )
        else if (isActive && !isPaused)
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return FractionallySizedBox(
                widthFactor: controller.value,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
