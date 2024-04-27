import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class ASMRApp extends StatefulWidget {
  @override
  _ASMRAppState createState() => _ASMRAppState();
}

class _ASMRAppState extends State<ASMRApp> {
  int selectedSoundIndex = 0;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  // Replace these with your own sounds and images
  List<String> sounds = [
    'sounds/S0.mp3',
    'sounds/S1.mp3',
    'sounds/S2.mp3',
    'sounds/S3.mp3',
    'sounds/S4.mp3',
    'sounds/S5.mp3',
    'sounds/S6.mp3',
    'sounds/S7.mp3',
    'sounds/S8.mp3'
  ];
  List<String> images = [
    'S0.jpg',
    'S1.jpg',
    'S2.jpg',
    'S3.jpg',
    'S4.jpg',
    'S5.jpg',
    'S6.jpg',
    'S7.jpg',
    'S8.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ASMR Sounds')),
      body: Column(
        children: <Widget>[
          // Sound Player
          Image.asset(images[selectedSoundIndex]),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () async {
              _assetsAudioPlayer.open(
                Audio(sounds[selectedSoundIndex]),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: () async {
              _assetsAudioPlayer.pause();
            },
          ),

          // Selection Panel
          GridView.builder(
            shrinkWrap: true,
            itemCount: sounds.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedSoundIndex = index;
                  });
                },
                child: Image.asset(images[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    super.dispose();
  }
}
