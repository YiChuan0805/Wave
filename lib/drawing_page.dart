import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

import 'drawn_line.dart';
import 'sketcher.dart';

class DrawingPage extends StatefulWidget {
  const DrawingPage({super.key});

  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  final GlobalKey _globalKey = GlobalKey();
  List<DrawnLine> lines = <DrawnLine>[];
  DrawnLine? line;
  Color selectedColor = Colors.black;
  double selectedWidth = 5.0;
  bool isEraser = false;
  bool showStrokeWidthSlider = false;
  ui.Picture? picture;
  ui.PictureRecorder? recorder;
  Canvas? canvas;

  void clear() {
    setState(() {
      lines.clear();
      picture = null;
      line = null;
      recorder = null;
      canvas = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          buildAllPaths(context),
          buildCurrentPath(context),
          buildTopToolbar(),
          buildColorToolbar(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: RepaintBoundary(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(4.0),
          color: Colors.transparent,
          alignment: Alignment.topLeft,
          child: CustomPaint(
            painter: Sketcher(
              lines: line != null ? [line!] : [],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAllPaths(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.transparent,
        padding: const EdgeInsets.all(4.0),
        alignment: Alignment.topLeft,
        child: CustomPaint(
          painter: CachedPainter(picture),
        ),
      ),
    );
  }

  void onPanStart(DragStartDetails details) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    Offset point = box?.globalToLocal(details.globalPosition) ?? Offset.zero;
    line = DrawnLine([point], isEraser ? Colors.white : selectedColor, selectedWidth);
    HapticFeedback.lightImpact();
  }

  void onPanUpdate(DragUpdateDetails details) {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    Offset point = box?.globalToLocal(details.globalPosition) ?? Offset.zero;

    List<Offset> path = List.from(line?.path ?? [])..add(point);
    line = DrawnLine(path, isEraser ? Colors.white : selectedColor, selectedWidth);
    setState(() {});
    HapticFeedback.lightImpact();
  }

  void onPanEnd(DragEndDetails details) {
    lines = List.from(lines)..add(line!);

    recorder ??= ui.PictureRecorder();
    canvas ??= Canvas(recorder!);

    Sketcher sketcher = Sketcher(lines: lines);
    sketcher.paint(canvas!, Size.infinite);

    picture = recorder!.endRecording();
    recorder = null;
    canvas = null;

    setState(() {
      line = null;
    });

    HapticFeedback.lightImpact();
  }

  Widget buildTopToolbar() {
    return Positioned(
      top: 10.0,
      left: 10.0,
      right: 10.0,
      child: Column(
        children: [
          if (showStrokeWidthSlider) buildStrokeWidthSlider(),
        ],
      ),
    );
  }

  Widget buildStrokeWidthSlider() {
    return Container(
      width: 150.0, // 调整宽度
      color: Colors.transparent,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 中心对齐
        children: [
          Center(
            child: Text(
              'Adjust Stroke Width',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          Slider(
            value: selectedWidth,
            min: 1.0,
            max: 20.0,
            onChanged: (value) {
              setState(() {
                selectedWidth = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildColorToolbar(double screenWidth, double screenHeight) {
    return Positioned(
      top: screenHeight * 0.05, // 调整位置以向上移动
      right: screenWidth * 0.025,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildStrokeButton(),
          SizedBox(height: screenHeight * 0.01),
          buildClearButton(),
          SizedBox(height: screenHeight * 0.01),
          buildEraserButton(),
          Divider(height: screenHeight * 0.02),
          buildColorButton(Colors.red),
          buildColorButton(Colors.orange),
          buildColorButton(Colors.yellow),
          buildColorButton(Colors.green),
          buildColorButton(Colors.blue),
          buildColorButton(Colors.purple),
          buildColorButton(Colors.black),
        ],
      ),
    );
  }

  Widget buildStrokeButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showStrokeWidthSlider = !showStrokeWidthSlider;
        });
      },
      child: const CircleAvatar(
        backgroundColor: ui.Color.fromARGB(255, 68, 160, 32),
        child: Icon(
          FontAwesomeIcons.paintBrush,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildEraserButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEraser = !isEraser;
        });
      },
      child: CircleAvatar(
        backgroundColor: isEraser ? Colors.blue : Colors.grey,
        child: Icon(
          FontAwesomeIcons.eraser,
          size: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildColorButton(Color color) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: FloatingActionButton(
        mini: true,
        backgroundColor: color,
        child: Container(),
        onPressed: () {
          setState(() {
            selectedColor = color;
            isEraser = false;
          });
        },
      ),
    );
  }

  Widget buildClearButton() {
    return GestureDetector(
      onTap: clear,
      child: const CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.delete_forever,
          size: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CachedPainter extends CustomPainter {
  final ui.Picture? picture;

  CachedPainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    if (picture != null) {
      canvas.drawPicture(picture!);
    }
  }

  @override
  bool shouldRepaint(CachedPainter oldDelegate) {
    return oldDelegate.picture != picture;
  }
}
