import 'package:flutter/material.dart';

class SosPage extends StatelessWidget {
  const SosPage({Key? key}) : super(key: key);

  void _showBottomSheet(BuildContext context, String imagePath) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Image.asset(
                      imagePath,
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwipeText(String text) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, String imagePath, String description, String swipeText) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                height: MediaQuery.of(context).size.height * 0.5,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => _showBottomSheet(
                context,
                imagePath == 'assets/sos/butterflyhug.png'
                    ? 'assets/sos/desc1.png'
                    : 'assets/sos/desc2.png'),
            child: const Icon(
              Icons.info,
              color: Colors.black,
            ),
          ),
        ),
        _buildSwipeText(swipeText),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(177, 37, 37, 37),
      appBar: AppBar(
        title: const Text(
          'HEALING',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(95, 37, 37, 37),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: PageView(
        children: [
          _buildPage(
            context,
            'assets/sos/butterflyhug.png',
            'Now, cross your arms around your chest and gently tap each shoulder like a butterfly. Breathe slowly and deeply. Your eyes can be closed, or partially closed. Stop when you feel in your body that it has had enough.',
            'Swipe right for more >>>',
          ),
          _buildPage(
            context,
            'assets/sos/grounding.png',
            'Now, walk barefoot on grass, sand, or even mud, allowing your skin to touch the natural ground. You can increase your skin-to-earth contact by lying on the ground. You can do it in the grass or on the sand.',
            '<<< Swipe left for more',
          ),
        ],
      ),
    );
  }
}
