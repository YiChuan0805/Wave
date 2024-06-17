import 'package:anxietynomore/drawing_page.dart';
import 'package:anxietynomore/sos.dart';
import 'package:anxietynomore/splash_page.dart';
import 'package:flutter/material.dart';
import 'contacts_page.dart';
import 'music_page.dart';
import 'fidget_button.dart';
import 'treehole_page.dart';
import 'circle_page.dart';
import 'asmr_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(95, 37, 37, 37),
        canvasColor: const Color.fromARGB(95, 37, 37, 37),
      ),
      home: const SplashScreen(), // Set the splash screen as the initial screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Page3(),
    FidgetPage(),
    const ASMRApp(), // Assuming Page3 is renamed to CirclePage
    const TreeHolePage(),
    const DrawingPage()
  ];

Future<bool> _onWillPop() async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: Color.fromARGB(255, 37, 37, 37),
      title: Center(
        child: Text(
        'Exit Wave',
        style: TextStyle(
          color: Colors.white, // 设置标题颜色
          fontSize: 24, // 设置标题字体大小
          fontWeight: FontWeight.bold, // 设置标题字体粗细
          )
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Looks like you want to exit the app. Are you feeling better?',
            style: TextStyle(
              color: Colors.white, // 设置内容文字颜色
              fontSize: 16, // 设置内容文字大小
            ),
          ),
          SizedBox(height: 8), // 添加垂直间距
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white, // 设置取消按钮文字颜色
              fontSize: 16, // 设置取消按钮文字大小
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // 设置确认按钮背景色
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 24,
            ),
          ),
          child: Text(
            'Yes, Exit',
            style: TextStyle(
              color: Colors.white, // 设置确认按钮文字颜色
              fontSize: 16, // 设置确认按钮文字大小
            ),
          ),
        ),
      ],
    ),
  ) ??
  false;
}



  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = _currentIndex == 0
        ? 'Breathe'
        : _currentIndex == 1
            ? 'Fidgets'
            : _currentIndex == 2
                ? 'Sound'
                : _currentIndex == 3
                    ? 'Tree Hole'
                    : _currentIndex == 4
                        ? 'Drawing'
                        : 'Wave';

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Inter',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(95, 37, 37, 37),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.healing),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SosPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.contacts),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsPage()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.music_note),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MusicPage()),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: Colors.white,
              height: 0.5,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _children[_currentIndex],
                  if (_currentIndex == 2) // Only show text for Breathe
                    Positioned(
                      left: 0,
                      right: 0,
                      top: AppBar().preferredSize.height + 36,
                      child: const Center(
                        // Add any additional content here
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 0.5),
            ),
          ),
          height: 60,
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(95, 37, 37, 37),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.circle),
                label: 'Breathe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.touch_app),
                label: 'Fidgets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.headphones),
                label: 'Sounds',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Tree Hole',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.palette),
                label: 'Drawing',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
