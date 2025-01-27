import 'package:flutter/material.dart';

class SwipeableMessage extends StatefulWidget {
  final Widget child;
  final Function() onReply;
  final Function()? onDelete;

  const SwipeableMessage({
    super.key,
    required this.child,
    required this.onReply,
    this.onDelete,
  });

  @override
  State<SwipeableMessage> createState() => _SwipeableMessageState();
}

class _SwipeableMessageState extends State<SwipeableMessage> {
  double _dragExtent = 0;
  bool _isDragging = false;
  final double _actionThreshold = 60.0;

  void _handleDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragExtent = 0;
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragExtent += details.delta.dx;
      if (_dragExtent < 0) _dragExtent = 0;
      if (_dragExtent > _actionThreshold * 2) _dragExtent = _actionThreshold * 2;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dragExtent >= _actionThreshold) {
      widget.onReply();
    }
    setState(() {
      _isDragging = false;
      _dragExtent = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        children: [
          if (_isDragging && _dragExtent > 0)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: _dragExtent,
                color: Colors.blue.withOpacity(0.2),
                child: Row(
                  children: [
                    if (_dragExtent >= _actionThreshold)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.reply,
                          color: Colors.blue,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          Transform.translate(
            offset: Offset(_dragExtent, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
