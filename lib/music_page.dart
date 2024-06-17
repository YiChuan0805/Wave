import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'audio_manager.dart';

// 定义歌曲类
class Song {
  final String title;
  final String imageUrl;
  final String audioUrl;
  final String artist;

  Song({
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
    required this.artist,
  });
}

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage>
    with AutomaticKeepAliveClientMixin {
  // 歌曲列表
  final List<Song> songs = [
    Song(
      title: 'Calm Lake',
      imageUrl: 'assets/music/thumbnail/ms1.png',
      audioUrl: 'assets/music/audio/Music1.mp3',
      artist: 'AShamaluevMusic',
    ),
    Song(
      title: 'Pleasant Relaxation',
      imageUrl: 'assets/music/thumbnail/ms2.png',
      audioUrl: 'assets/music/audio/Music2.mp3',
      artist: 'AShamaluevMusic',
    ),
    Song(
      title: 'Peaceful',
      imageUrl: 'assets/music/thumbnail/ms3.png',
      audioUrl: 'assets/music/audio/Music3.mp3',
      artist: 'AShamaluevMusic',
    ),
    Song(
      title: 'Aura',
      imageUrl: 'assets/music/thumbnail/ms4.png',
      audioUrl: 'assets/music/audio/Music4.mp3',
      artist: 'AShamaluevMusic',
    ),
    Song(
      title: 'Soothing',
      imageUrl: 'assets/music/thumbnail/ms5.png',
      audioUrl: 'assets/music/audio/Music5.mp3',
      artist: 'AShamaluevMusic',
    ),
    Song(
      title: 'Sky High',
      imageUrl: 'assets/music/thumbnail/ms6.png',
      audioUrl: 'assets/music/audio/Music6.mp3',
      artist: 'AK',
    ),
    Song(
      title: 'Gently Does It',
      imageUrl: 'assets/music/thumbnail/ms7.png',
      audioUrl: 'assets/music/audio/Music7.mp3',
      artist: 'Justin Lee',
    ),
    Song(
      title: 'Boundless',
      imageUrl: 'assets/music/thumbnail/ms8.png',
      audioUrl: 'assets/music/audio/Music8.mp3',
      artist: 'Tranquilium',
    ),
    // 添加更多歌曲
  ];

  // 音频播放器实例
  final AssetsAudioPlayer _assetsAudioPlayer =
      AudioManager().assetsAudioPlayer;

  // 当前播放的歌曲、播放状态、当前播放位置、歌曲总时长
  Song? _currentSong;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _songDuration = Duration.zero;

  bool _isPageActive = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _isPageActive = true;
    _initPlayer();
  }

  // 初始化音频播放器
  void _initPlayer() async {
    // 监听当前播放位置的变化
    _assetsAudioPlayer.currentPosition.listen((event) {
      if (_isPageActive) {
        setState(() {
          _currentPosition = event;
        });
      }
    });

    // 监听当前播放歌曲的变化
    _assetsAudioPlayer.current.listen((event) {
      if (_isPageActive) {
        setState(() {
          _songDuration = event!.audio.duration;
        });
      }
    });

    // 监听播放器状态的变化
    _assetsAudioPlayer.playerState.listen((event) {
      if (_isPageActive && event == PlayerState.stop) {
        _playNextSong(); // 当前歌曲播放完毕时自动切换到下一首
      }
    });

    // 加载播放器状态
    _loadPlayerState();
  }

  @override
  void dispose() {
    _isPageActive = false; // 页面销毁时，停止监听
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // 确保在重写的 build 方法中调用 super.build(context)

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(95, 37, 37, 37),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color.fromARGB(160, 37, 37, 37),
      body: PageStorage(
        bucket: PageStorageBucket(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                key: PageStorageKey('songList'),
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  bool isCurrentSong = _currentSong == songs[index];
                  return Column(
                    children: [
                      Container(
                        color: Color.fromARGB(95, 37, 37, 37),
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 60,
                              height: 60,
                              child: Image.asset(
                                songs[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            songs[index].title,
                            style: TextStyle(
                              color: isCurrentSong ? Colors.green : Colors.white,
                              fontFamily: 'Inter',
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            songs[index].artist,
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            _playSong(index); // 点击歌曲列表项播放歌曲
                          },
                        ),
                      ),
                      Divider(height: 0, thickness: 0.5),
                    ],
                  );
                },
              ),
            ),
            if (_currentSong != null)
              Column(
                children: [
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Container(
                    color: Color.fromARGB(0, 37, 37, 37),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              _currentSong!.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _currentSong!.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                _currentSong!.artist,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_previous,
                              color: Colors.white, size: 30),
                          onPressed: _playPreviousSong, // 播放上一首歌曲
                        ),
                        IconButton(
                          icon: _isPlaying
                              ? Icon(Icons.pause,
                                  color: Colors.white, size: 30)
                              : Icon(Icons.play_arrow,
                                  color: Colors.white, size: 30),
                          onPressed: () {
                            if (_isPlaying) {
                              _assetsAudioPlayer.pause(); // 暂停播放
                            } else {
                              _assetsAudioPlayer.play(); // 开始播放
                            }
                            setState(() {
                              _isPlaying = !_isPlaying; // 切换播放状态
                            });
                            _savePlayerState(); // 保存播放状态
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next,
                              color: Colors.white, size: 30),
                          onPressed: _playNextSong, // 播放下一首歌曲
                                                 ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
                        thumbColor: Colors.white,
                        overlayShape: SliderComponentShape.noOverlay,
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.grey[400],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            Slider(
                              value: _currentPosition.inMilliseconds.toDouble(),
                              min: 0.0,
                              max: _songDuration.inMilliseconds.toDouble(),
                              onChanged: (double value) {
                                _assetsAudioPlayer.seek(Duration(milliseconds: value.toInt()));
                              },
                              divisions: _songDuration.inMilliseconds.toInt(),
                              label: '${_printDuration(_currentPosition)} / ${_printDuration(_songDuration)}',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _printDuration(_currentPosition),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  _printDuration(_songDuration),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
        ),
      );
  }


  // 格式化时长为字符串显示
  String _printDuration(Duration? duration) {
    if (duration == null) return '--:--';

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inMinutes)}:$twoDigitSeconds';
  }

  // 播放指定索引的歌曲
  void _playSong(int index) {
    setState(() {
      _currentSong = songs[index];
      _isPlaying = true; // 设置为播放状态
    });
    // 打开指定歌曲的音频
    _assetsAudioPlayer.open(
      Audio(songs[index].audioUrl),
      showNotification: true,
    );

    _savePlayerState(index); // 保存播放器状态
  }

  // 播放下一首歌曲
  void _playNextSong() {
    int currentIndex = songs.indexOf(_currentSong!);
    int nextIndex = (currentIndex + 1) % songs.length;
    _playSong(nextIndex);
  }

  // 播放上一首歌曲
  void _playPreviousSong() {
    int currentIndex = songs.indexOf(_currentSong!);
    int previousIndex = currentIndex - 1;
    if (previousIndex < 0) {
      previousIndex = songs.length - 1;
    }
    _playSong(previousIndex);
  }

  // 保存播放器状态到SharedPreferences
  void _savePlayerState([int? index]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (index != null) {
      await prefs.setInt('currentSongIndex', index);
    }
    await prefs.setBool('isPlaying', _isPlaying);
    await prefs.setInt('currentPosition', _currentPosition.inMilliseconds);
  }

  // 加载播放器状态
  void _loadPlayerState() async {
    if (_isPageActive) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? index = prefs.getInt('currentSongIndex');
      bool? isPlaying = prefs.getBool('isPlaying');
      int? currentPosition = prefs.getInt('currentPosition');

      if (index != null) {
        setState(() {
          _currentSong = songs[index];
          _isPlaying = isPlaying ?? false; // 如果没有保存状态，默认为 false
        });

        _assetsAudioPlayer.open(
          Audio(songs[index].audioUrl),
          autoStart: _isPlaying,
          showNotification: true,
        ).then((_) {
          if (currentPosition != null) {
            _assetsAudioPlayer.seek(Duration(milliseconds: currentPosition));
          }
        });
      } else {
        setState(() {
          _isPlaying = false; // 如果没有保存状态，默认为 false
        });
      }
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MusicPage(),
  ));
}
