import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Song {
  final String title;
  final String imageUrl;
  final String audioUrl;

  Song({required this.title, required this.imageUrl, required this.audioUrl});
}

class MusicPage extends StatefulWidget {
  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final List<Song> songs = [
    Song(title: 'Song 1', imageUrl: 'S0.jpg', audioUrl: 'sounds/S0.mp3'),
    Song(title: 'Song 2', imageUrl: 'S1.jpg', audioUrl: 'sounds/S1.mp3'),
    Song(title: 'Song 3', imageUrl: 'S2.jpg', audioUrl: 'sounds/S2.mp3'),
    Song(title: 'Song 4', imageUrl: 'S3.jpg', audioUrl: 'sounds/S3.mp3'),
    Song(title: 'Song 5', imageUrl: 'S4.jpg', audioUrl: 'sounds/S4.mp3'),
    Song(title: 'Song 6', imageUrl: 'S5.jpg', audioUrl: 'sounds/S5.mp3'),
    Song(title: 'Song 7', imageUrl: 'S6.jpg', audioUrl: 'sounds/S6.mp3'),
    Song(title: 'Song 8', imageUrl: 'S7.jpg', audioUrl: 'sounds/S7.mp3'),
    // Add more songs here
  ];

  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  String currentSong = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music'),
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
