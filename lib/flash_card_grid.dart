import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:anxietynomore/contacts_page.dart';
import 'package:anxietynomore/music_page.dart';

class FlashCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Anxiety No More'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.contacts), // choose an appropriate icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.music_note), // choose an appropriate icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MusicPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomFlipCard(
                    frontText: 'Front Card 1',
                    backText: 'Back Card 1',
                    frontColor: Colors.orange,
                    backColor: Colors.blue,
                  ),
                  CustomFlipCard(
                    frontText: 'Front Card 2',
                    backText: 'Back Card 2',
                    frontColor: Colors.green,
                    backColor: Colors.purple,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomFlipCard(
                    frontText: 'Front Card 3',
                    backText: 'Back Card 3',
                    frontColor: Colors.teal,
                    backColor: Colors.indigo,
                  ),
                  CustomFlipCard(
                    frontText: 'Front Card 4',
                    backText: 'Back Card 4',
                    frontColor: Colors.red,
                    backColor: Colors.yellow,
                  ),
                ],
              ),
              // Add more CustomFlipCard widgets as needed
            ],
          ),
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

  const CustomFlipCard({
    required this.frontText,
    required this.backText,
    required this.frontColor,
    required this.backColor,
  });

  @override
  _CustomFlipCardState createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomFlipCard> {
  bool isFlipped = false;

  void _toggleCard() {
    setState(() {
      isFlipped = !isFlipped;
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
      ),
    );
  }

  Widget _buildCard(String text, Color color) {
    return Card(
      color: color,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 200,
        height: 300,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
