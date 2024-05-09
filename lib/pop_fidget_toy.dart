import 'package:flutter/material.dart';
import 'package:anxietynomore/contacts_page.dart';
import 'package:anxietynomore/music_page.dart';

class PopFidgetToy extends StatefulWidget {
  @override
  _PopFidgetToyState createState() => _PopFidgetToyState();
}

class _PopFidgetToyState extends State<PopFidgetToy> {
  List<bool> isPopped = List.generate(35, (index) => false);

  void togglePop(int index) {
    setState(() {
      isPopped[index] = !isPopped[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemCount: 35,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => togglePop(index),
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isPopped[index] ? Colors.grey : Colors.purple,
                  shape: BoxShape.circle, // Make the button circular
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}