import 'package:flutter/material.dart';
import 'package:ui_clone_whatsapp/widgets/loading_indicator.dart';

class CallScreen extends StatefulWidget {
  final String name;
  final String profileImage;
  final bool isVideoCall;

  const CallScreen({
    super.key,
    required this.name,
    required this.profileImage,
    required this.isVideoCall,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  bool _isVideoOff = false;
  bool _isConnecting = true;

  @override
  void initState() {
    super.initState();
    _simulateConnection();
  }

  void _simulateConnection() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video/Profile Background
          widget.isVideoCall
              ? _isVideoOff
                  ? _buildProfileView()
                  : _buildVideoView()
              : _buildProfileView(),

          // Call Status and Controls
          SafeArea(
            child: Column(
              children: [
                // Top Section - User Info
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isConnecting ? 'Connecting...' : 'On call',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                if (_isConnecting) ...[
                  const Expanded(
                    child: Center(
                      child: LoadingIndicator(),
                    ),
                  ),
                ],

                // Bottom Section - Call Controls
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCallControl(
                        icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                        label: 'Speaker',
                        onPressed: () {
                          setState(() => _isSpeakerOn = !_isSpeakerOn);
                        },
                      ),
                      _buildCallControl(
                        icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                        label: 'Video',
                        onPressed: widget.isVideoCall
                            ? () {
                                setState(() => _isVideoOff = !_isVideoOff);
                              }
                            : null,
                      ),
                      _buildCallControl(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: 'Mute',
                        onPressed: () {
                          setState(() => _isMuted = !_isMuted);
                        },
                      ),
                      _buildCallControl(
                        icon: Icons.call_end,
                        backgroundColor: Colors.red,
                        label: 'End',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(widget.profileImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }

  Widget _buildVideoView() {
    // TODO: Implement actual video view
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Text(
          'Video Feed',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCallControl({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    Color? backgroundColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? Colors.white.withOpacity(0.1),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
            color: Colors.white,
            iconSize: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
