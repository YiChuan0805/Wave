import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PopFidgetToy extends StatefulWidget {
  @override
  _PopFidgetToyState createState() => _PopFidgetToyState();
}

class _PopFidgetToyState extends State<PopFidgetToy> {
  List<bool> isPopped = List.generate(45, (index) => false);
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  void togglePop(int index) {
    setState(() {
      isPopped[index] = !isPopped[index];
      HapticFeedback.heavyImpact();
      _assetsAudioPlayer.open(
        Audio("assets/effects/pop.mp3"),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the circle size based on the smaller dimension to ensure it fits the grid
    double circleSize = screenWidth / 5;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(95, 70, 70, 70), // Set background color to black
        appBar: AppBar(
          title: Text(
            'Bubble Pop',
            style: TextStyle(
              color: Colors.white, // Set title text color to white
              fontFamily: 'Inter', // Set font family to Inter
              fontWeight: FontWeight.bold, // Set font weight to bold
              fontSize: 30, // Set font size to 30
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(95, 37, 37, 37), // Set app bar color to black
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.5), // Set the height of the bottom widget
            child: Container(
              height: 1.0,
              color: Colors.white, // Set color to white
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white), // Set back button icon color to white
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 5.0, // Add main axis spacing
            crossAxisSpacing: 5.0, // Add cross axis spacing
            childAspectRatio: 1.0, // Ensures the grid items are square
          ),
          itemCount: 45,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => togglePop(index),
              child: Container(
                width: circleSize,
                height: circleSize,
                margin: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: isPopped[index] ? Colors.grey : Colors.purple,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -2, // Set to negative value for inward shadow
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() => runApp(PopFidgetToy());
