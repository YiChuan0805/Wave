import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FidgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fidget Page'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(9, (index) {
          return FidgetButton(videoPath: 'assets/videos/fidget${index + 1}.mp4');
        }),
      ),
    );
  }
}

class FidgetButton extends StatefulWidget {
  final String videoPath;

  FidgetButton({required this.videoPath});

  @override
  _FidgetButtonState createState() => _FidgetButtonState();
}

class _FidgetButtonState extends State<FidgetButton> {
  late VideoPlayerController _controller;
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: VideoPlayer(_controller),
    );
  }

  void _handleTap() {
    setState(() {
      _isToggled = !_isToggled;
      if (_isToggled) {
        _controller.play();
      } else {
        _controller.play();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
