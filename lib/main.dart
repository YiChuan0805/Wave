import 'package:anxietynomore/contacts_page.dart';
import 'package:anxietynomore/drawing_page.dart';
import 'package:anxietynomore/fidget_button.dart';
import 'package:anxietynomore/treehole_page.dart';
import 'package:flutter/material.dart';
import 'package:anxietynomore/circle_page.dart';
import 'package:anxietynomore/asmr_page.dart';
import 'package:anxietynomore/music_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anxiety No More',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 38, 38, 38),
        canvasColor: Colors.black38,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 2;
  final List<Widget> _children = [
    const ASMRApp(),
    FidgetPage(),
    const Page3(),
    const TreeHolePage(),
    const DrawingPage()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.headphones),
            label: 'Sounds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'Fidgets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            label: 'Breathe',
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
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  const PlaceholderWidget(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

