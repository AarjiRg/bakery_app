import 'package:bakery_app/view/home_screen.dart';

import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int sindex = 0;
  final List<Widget> screens = [
    HomeScreen(),
    Container(color: Colors.pink),
    Container(color: Colors.pink),
    Container(color: Colors.blue),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[sindex],
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                currentIndex: sindex,
                backgroundColor: Colors.black,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  setState(() {
                    sindex = value;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.map_outlined),
                    label: "Map",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "search",
                  ),
                  BottomNavigationBarItem(
                    
                    icon: Icon(Icons.history),
                    label: "History",
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
