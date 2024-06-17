import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FlashCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(95, 70, 70, 70),
      appBar: AppBar(
        title: Text(
          'Flash Card',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(95, 37, 37, 37),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Tap for more surprises',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomFlipCard(
                    frontText: 'Every day is a new chance to rewrite your story.',
                    backText: 'You are not responsible for the versions of you that exist in other people’s minds.',
                    frontColor: Colors.red,
                    backColor: Colors.orange,
                    cardWidth: screenWidth * 0.4,
                    cardHeight: screenHeight * 0.3,
                  ),
                  CustomFlipCard(
                    frontText: 'You are capable, strong and moving forward with courage.',
                    backText: 'Saying how you feel will never ruin a real connection.',
                    frontColor: const Color.fromARGB(255, 202, 182, 0),
                    backColor: Colors.green,
                    cardWidth: screenWidth * 0.4,
                    cardHeight: screenHeight * 0.3,
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomFlipCard(
                    frontText: 'Your potential is limitless; do not underestimate the power within you.',
                    backText: 'Strive for progress, not perfection. Each step forward is a victory in itself.',
                    frontColor: Colors.blue,
                    backColor: Colors.indigo,
                    cardWidth: screenWidth * 0.4,
                    cardHeight: screenHeight * 0.3,
                  ),
                  CustomFlipCard(
                    frontText: 'Believe that you deserve better; you really do.',
                    backText: 'You don’t have to rebuild a relationship with everyone you have forgiven.',
                    frontColor: Color.fromARGB(255, 95, 0, 139),
                    backColor: Color.fromARGB(255, 84, 9, 114),
                    cardWidth: screenWidth * 0.4,
                    cardHeight: screenHeight * 0.3,
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

class CustomFlipCard extends StatefulWidget {
  final String frontText;
  final String backText;
  final Color frontColor;
  final Color backColor;
  final double cardWidth;
  final double cardHeight;

  const CustomFlipCard({
    required this.frontText,
    required this.backText,
    required this.frontColor,
    required this.backColor,
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  _CustomFlipCardState createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomFlipCard> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void _toggleCard() {
    setState(() {
      _assetsAudioPlayer.open(
        Audio("assets/effects/flip.mp3"),
      ); // Play flipping sound
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        front: _buildCard(widget.frontText, widget.frontColor),
        back: _buildCard(widget.backText, widget.backColor),
        onFlip: _toggleCard,
      ),
    );
  }

  Widget _buildCard(String text, Color color) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(-0.1),
      alignment: Alignment.center,
      child: Card(
        color: color,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: widget.cardWidth,
          height: widget.cardHeight,
          alignment: Alignment.center,
          padding: EdgeInsets.all(16), // 添加内边距
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
