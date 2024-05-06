import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class ASMRApp extends StatefulWidget {
  const ASMRApp({super.key});

  @override
  _ASMRAppState createState() => _ASMRAppState();
}

class _ASMRAppState extends State<ASMRApp> {
  int selectedSoundIndex = 0;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  // Replace these with your own sounds and images
  List<String> sounds = [
    'assets/asmr/rec/rec1.mp3',
    'assets/asmr/rec/rec2.mp3',
    'assets/asmr/rec/rec3.mp3',
    'assets/asmr/rec/rec4.mp3',
    'assets/asmr/rec/rec5.mp3',
    'assets/asmr/rec/rec6.mp3',
    'assets/asmr/rec/rec7.mp3',
    'assets/asmr/rec/rec8.mp3',
    'assets/asmr/rec/rec9.mp3'
  ];
  List<String> images = [
    'assets/asmr/pic/sound1.png',
    'assets/asmr/pic/sound2.png',
    'assets/asmr/pic/sound3.png',
    'assets/asmr/pic/sound4.png',
    'assets/asmr/pic/sound5.png',
    'assets/asmr/pic/sound6.png',
    'assets/asmr/pic/sound7.png',
    'assets/asmr/pic/sound8.png',
    'assets/asmr/pic/sound9.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Sound Player
          SizedBox(
            height: 200, // Adjust this value to control the height of the image
            width: 200, // Adjust this value to control the width of the image
            child: Image.asset(images[selectedSoundIndex]),
          ),
          IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: () async {
              _assetsAudioPlayer.open(
                Audio(sounds[selectedSoundIndex]),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.pause),
            onPressed: () async {
              _assetsAudioPlayer.pause();
            },
          ),

          // Selection Panel
          SizedBox(
            height:
                300, // Adjust this value to control the height of the selection panel
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: sounds.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSoundIndex = index;
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: 0.8, // Control the aspect ratio of your images
                    child: Image.asset(images[index]),
                  ),
                );
              },
            ),
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
