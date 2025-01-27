import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedFabMenu extends StatefulWidget {
  final List<FabMenuItem> items;
  final Color backgroundColor;
  final Color foregroundColor;

  const AnimatedFabMenu({
    super.key,
    required this.items,
    this.backgroundColor = Colors.green,
    this.foregroundColor = Colors.white,
  });

  @override
  State<AnimatedFabMenu> createState() => _AnimatedFabMenuState();
}

class _AnimatedFabMenuState extends State<AnimatedFabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _FlowMenuDelegate(
        controller: _controller,
        itemCount: widget.items.length,
      ),
      children: [
        // Main FAB
        FloatingActionButton(
          onPressed: _toggleMenu,
          backgroundColor: widget.backgroundColor,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
            color: widget.foregroundColor,
          ),
        ),
        // Menu Items
        ...widget.items.map((item) => _buildMenuItem(item)).toList(),
      ],
    );
  }

  Widget _buildMenuItem(FabMenuItem item) {
    final double buttonSize = 56;
    
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Center(
        child: ScaleTransition(
          scale: _controller,
          child: FloatingActionButton(
            heroTag: item.label,
            onPressed: () {
              _toggleMenu();
              item.onPressed();
            },
            backgroundColor: widget.backgroundColor,
            mini: true,
            child: Icon(
              item.icon,
              color: widget.foregroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _FlowMenuDelegate extends FlowDelegate {
  final AnimationController controller;
  final int itemCount;

  _FlowMenuDelegate({
    required this.controller,
    required this.itemCount,
  }) : super(repaint: controller);

  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final xStart = size.width / 2;
    final yStart = size.height / 2;

    final buttonRadius = 28.0;
    final radius = 100.0;

    for (int i = 0; i < context.childCount; i++) {
      final childSize = context.getChildSize(i)!;
      final centerX = childSize.width / 2;
      final centerY = childSize.height / 2;

      if (i == 0) {
        // Main FAB
        context.paintChild(
          i,
          transform: Matrix4.translationValues(
            xStart - centerX,
            yStart - centerY,
            0.0,
          ),
        );
      } else {
        // Menu items
        final angle = (i - 1) * math.pi / (itemCount - 2);
        final rotation = controller.value * angle;
        final x = xStart - centerX + radius * math.cos(rotation - math.pi / 2);
        final y = yStart - centerY + radius * math.sin(rotation - math.pi / 2);

        context.paintChild(
          i,
          transform: Matrix4.translationValues(x, y, 0.0),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FlowMenuDelegate oldDelegate) {
    return controller != oldDelegate.controller ||
        itemCount != oldDelegate.itemCount;
  }
}

class FabMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  FabMenuItem({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}
