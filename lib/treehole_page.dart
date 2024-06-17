import 'package:flutter/material.dart';
import 'dart:async';

class TreeHolePage extends StatefulWidget {
  const TreeHolePage({Key? key}) : super(key: key);

  @override
  _TreeHolePageState createState() => _TreeHolePageState();
}

class _TreeHolePageState extends State<TreeHolePage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<_MessageBubble> _messages = [];
  int _messageCount = 0;
  Timer? _clearTimer;

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();

    var messageBubble = _MessageBubble(
      message: text,
      isMe: true,
    );
    setState(() {
      _messages.insert(0, messageBubble);
      _messageCount++;

      if (_messageCount >= 12) {
        _messages.removeLast();
        _messageCount--;
      }
    });

    _resetTimer();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _clearTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _clearTimer = Timer(const Duration(seconds: 20), () {
      setState(() {
        _messages.clear();
        _messageCount = 0;
      });
    });
  }

  void _resetTimer() {
    _clearTimer?.cancel();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(95, 37, 37, 37),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Express your thoughts and feelings freely',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            const Divider(height: 1.0),
            _buildTextComposerContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposerContainer() {
    return Container(
      color: Color.fromARGB(95, 37, 37, 37),
      child: _buildTextComposer(),
    );
  }

  Widget _buildTextComposer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              onChanged: (_) => _resetTimer(),
              decoration: InputDecoration(
                hintText: "Type your thought",
                hintStyle: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
                filled: true,
                fillColor: const Color.fromARGB(255, 110, 110, 110),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 8.0),
          GestureDetector(
            onTap: () => _handleSubmitted(_textController.text),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal,
              ),
              padding: const EdgeInsets.all(10),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const _MessageBubble({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isMe ? Colors.teal : Colors.grey[700],
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(0.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(20.0),
                ),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: isMe
                  ? const EdgeInsets.only(right: 6.0)
                  : const EdgeInsets.only(left: 6.0),
              child: CustomPaint(
                painter: _MessageBubbleArrowPainter(isMe: isMe),
              ),
            ),
            Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubbleArrowPainter extends CustomPainter {
  final bool isMe;

  _MessageBubbleArrowPainter({required this.isMe});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = isMe ? Colors.teal : Colors.grey[700]!;
    final path = Path();

    if (isMe) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width - 6, 6);
      path.lineTo(size.width, 12);
      path.close();
    } else {
      path.moveTo(0, 0);
      path.lineTo(6, 6);
      path.lineTo(0, 12);
      path.close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
