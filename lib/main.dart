import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anxiety No More',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 87)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 38, 38, 38),
        canvasColor: Colors.black38,
      ),
      home: const MyHomePage(title: 'Anxiety No More'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  static const List<Widget> _pages = <Widget>[
    Text('A random AWESOME idea:'),
    Icon(
      Icons.touch_app,
      size: 150,
    ),
    Icon(
      Icons.circle,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
    Icon(
      Icons.palette,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black38,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
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
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
