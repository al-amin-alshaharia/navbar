import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaterDropNavigationBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WaterDropNavigationBar extends StatefulWidget {
  @override
  _WaterDropNavigationBarState createState() => _WaterDropNavigationBarState();
}

class _WaterDropNavigationBarState extends State<WaterDropNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6EBF9),
      body: Center(
        child: Text(
          'Selected Page: ${['Home', 'History', 'Profile'][_selectedIndex]}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipPath(
            clipper: NavBarClipper(selectedIndex: _selectedIndex),
            child: ClipRRect(
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              // ),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 80,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.home, 'Home', 0),
                    _buildNavItem(Icons.bar_chart, 'History', 1),
                    _buildNavItem(Icons.person, 'Profile', 2),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -25,
            left: MediaQuery.of(context).size.width / 3 * _selectedIndex +
                MediaQuery.of(context).size.width / 6 -
                25,
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Icon(
                _selectedIndex == 0
                    ? Icons.home
                    : _selectedIndex == 1
                        ? Icons.bar_chart
                        : Icons.person,
                color: Colors.purple,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: _selectedIndex == index
                ? Colors.transparent
                : Colors.grey.shade400,
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index
                  ? Colors.purple
                  : Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}

class NavBarClipper extends CustomClipper<Path> {
  final int selectedIndex;

  NavBarClipper({required this.selectedIndex});

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final curveWidth = 85.0;
    final curveHeight = 82.0;

    double startX = width / 3 * selectedIndex + width / 5.7 - curveWidth / 2;

    path.moveTo(0, 0);
    path.lineTo(startX, 0);
    path.quadraticBezierTo(
      startX + curveWidth / 2.1,
      curveHeight,
      startX + curveWidth,
      0,
    );
    path.lineTo(width, 0);
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
