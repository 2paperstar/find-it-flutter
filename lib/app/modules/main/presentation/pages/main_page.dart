import 'package:auto_route/auto_route.dart';
import 'package:find_it/app/values/palette.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('find-it'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ]),
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: const Center(child: Text('Map')),
          ),
          DraggableScrollableSheet(
            builder: (context, scrollController) => Container(
              color: Palette.white,
              child: SingleChildScrollView(
                controller: scrollController,
                child: const Column(
                  children: [
                    ListTile(title: Text('test1')),
                    ListTile(title: Text('test1')),
                    ListTile(title: Text('test1')),
                    ListTile(title: Text('test1')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
