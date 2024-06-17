import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class ASMRApp extends StatefulWidget {
  const ASMRApp({Key? key}) : super(key: key);

  @override
  _ASMRAppState createState() => _ASMRAppState();
}

class _ASMRAppState extends State<ASMRApp> {
  int selectedSoundIndex = 0;
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  bool _isPlaying = false;
  bool _isFirstPlay = true;

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
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Image.asset(images[selectedSoundIndex]),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          // Tap and Play
          IconButton(
            icon: _isPlaying
                ? const Icon(
                    Icons.pause,
                    color: Colors.white, // Set play button color to white
                  )
                : const Icon(
                    Icons.play_arrow,
                    color: Colors.white, // Set play button color to white
                  ),
            onPressed: () {
              if (_isFirstPlay) {
                _playSound();
                _isFirstPlay = false;
              } else {
                _togglePlayPause();
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tap and Play',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Divider(),
          // Selection Panel
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: sounds.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0, // Control the aspect ratio of your images
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _stopSound(); // Stop the current sound
                        selectedSoundIndex = index;
                        _isPlaying = false;
                        _isFirstPlay = true;
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: 1.0, // Control the aspect ratio of your images
                      child: Image.asset(images[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _playSound() async {
    setState(() {
      _isPlaying = true;
    });

    await _assetsAudioPlayer.open(
      Audio(sounds[selectedSoundIndex]),
      loopMode: LoopMode.single,
    );
  }

  void _stopSound() async {
    await _assetsAudioPlayer.stop();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _assetsAudioPlayer.pause();
    } else {
      await _assetsAudioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    super.dispose();
  }
}
