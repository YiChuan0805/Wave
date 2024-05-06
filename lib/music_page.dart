import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Song {
  final String title;
  final String imageUrl;
  final String audioUrl;

  Song({required this.title, required this.imageUrl, required this.audioUrl});
}

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final List<Song> songs = [
    Song(title: 'Song 1', imageUrl: 'assets/music/thumbnail/ms1.png', audioUrl: 'assets/music/audio/Music1.mp3'),
    Song(title: 'Song 2', imageUrl: 'assets/music/thumbnail/ms2.png', audioUrl: 'assets/music/audio/Music2.mp3'),
    Song(title: 'Song 3', imageUrl: 'assets/music/thumbnail/ms3.png', audioUrl: 'assets/music/audio/Music3.mp3'),
    Song(title: 'Song 4', imageUrl: 'assets/music/thumbnail/ms4.png', audioUrl: 'assets/music/audio/Music4.mp3'),
    Song(title: 'Song 5', imageUrl: 'assets/music/thumbnail/ms5.png', audioUrl: 'assets/music/audio/Music5.mp3'),
    Song(title: 'Song 6', imageUrl: 'assets/music/thumbnail/ms6.png', audioUrl: 'assets/music/audio/Music6.mp3'),
    Song(title: 'Song 7', imageUrl: 'assets/music/thumbnail/ms7.png', audioUrl: 'assets/music/audio/Music7.mp3'),
    Song(title: 'Song 8', imageUrl: 'assets/music/thumbnail/ms8.png', audioUrl: 'assets/music/audio/Music1.mp3'),
    // Add more songs here
  ];

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  String currentSong = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(songs[index].imageUrl),
            title: Text(songs[index].title),
            trailing: StreamBuilder(
              stream: _assetsAudioPlayer.realtimePlayingInfos,
              builder: (context, AsyncSnapshot<RealtimePlayingInfos?> snapshot) {
                return IconButton(
                  icon: Icon(currentSong == songs[index].audioUrl && snapshot.hasData && snapshot.data!.isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (currentSong == songs[index].audioUrl && snapshot.hasData && snapshot.data!.isPlaying) {
                      _assetsAudioPlayer.pause();
                    } else {
                      _assetsAudioPlayer.open(
                        Audio(songs[index].audioUrl),
                        autoStart: true,
                        showNotification: true,
                      );
                      currentSong = songs[index].audioUrl;
                    }
                    setState(() {});
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
