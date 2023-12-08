import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Photo Gallery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Photo Gallery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedImageIndex = 0;
  List<String> images = [
    'assets/png/m175/1.jpg',
    'assets/png/m175/2.jpg',
    'assets/png/m175/3.jpg',
    'assets/png/m175/4.jpg',
    'assets/png/m175/5.jpg',
    'assets/png/m175/6.jpg',
    'assets/png/m175/7.jpg',
    'assets/png/m175/8.jpg',
    'assets/png/m175/9.jpg',
    'assets/png/m175/10.jpg',
    'assets/png/m175/11.jpg',
    'assets/png/m175/12.jpg',
  ];

  CarouselController _carouselController = CarouselController();

  void _selectImage(int index) {
    setState(() {
      _selectedImageIndex = index;
    });
  }

  void _goToFirst() {
    _carouselController.jumpToPage(0);
  }

  void _goToPrevious() {
    if (_selectedImageIndex > 0) {
      _carouselController.previousPage();
    }
  }

  void _goToNext() {
    if (_selectedImageIndex < images.length - 1) {
      _carouselController.nextPage();
    }
  }

  void _goToLast() {
    _carouselController.jumpToPage(images.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              // Handle navigation or other action
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body: Column(
        children: [
          // Large selected image
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: images.length,
                  options: CarouselOptions(
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    onPageChanged: (index, _) {
                      _selectImage(index);
                    },
                  ),
                  carouselController: _carouselController,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                // Carousel of small selectable images
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavigationButton(Icons.first_page, _goToFirst),
                        _buildNavigationButton(Icons.navigate_before, _goToPrevious),
                        _buildNavigationButton(Icons.navigate_next, _goToNext),
                        _buildNavigationButton(Icons.last_page, _goToLast),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Gallery',
          ),
        ],
        selectedItemColor: Colors.deepPurple,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GalleryPage(images: images),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(16),
        ),
        child: Icon(icon),
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  final List<String> images;

  const GalleryPage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ),
        ],
      ),
    );
  }
}
