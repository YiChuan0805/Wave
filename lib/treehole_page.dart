// tree_hole_page.dart
// tree_hole_page.dart
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart'; // import the package

class TreeHolePage extends StatefulWidget {
  const TreeHolePage({super.key});

  @override
  _TreeHolePageState createState() => _TreeHolePageState();
}

class _TreeHolePageState extends State<TreeHolePage>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<_MessageBubbleAnimation> _messages = [];

  void _handleSubmitted(String text) {
  _textController.clear();
  var messageBubble = _MessageBubbleAnimation(
    message: text,
    controller: AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward(),
  );
  setState(() {
    _messages.insert(0, messageBubble);
  });
  // Remove the message after a delay
  Future.delayed(const Duration(seconds: 5), () {
    if (mounted) {
      setState(() {
        _messages.remove(messageBubble);
      });
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                    hintText: "Send a message to the tree"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubbleAnimation extends StatefulWidget {
  final String message;
  final AnimationController controller;

  const _MessageBubbleAnimation({
    required this.message,
    required this.controller,
  });

  @override
  _MessageBubbleAnimationState createState() => _MessageBubbleAnimationState();
}

class _MessageBubbleAnimationState extends State<_MessageBubbleAnimation>
    with TickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -15.0),
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeIn,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(
        0.7,  // Start fading out at 70% of the animation
        1.0,  // Completely faded out at 100% of the animation
        curve: Curves.easeOut,
      ),
    ));

    // Delay the start of the animation by 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        widget.controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: BubbleSpecialOne(
          text: widget.message,
          color: Colors.green,
          isSender: true,
          textStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
