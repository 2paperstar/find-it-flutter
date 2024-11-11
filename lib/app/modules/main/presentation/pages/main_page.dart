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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          BottomNavigationBar(items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blue,
            child: const Center(child: Text('Map')),
          ),
          DraggableScrollableSheet(
            builder: (context, scrollController) => Column(
              children: [
                Container(
                  height: 10,
                  color: Colors.black,
                  child: Center(
                    child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Palette.white,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: const Column(
                        children: [
                          ListTile(
                            title: Text('Wallet'),
                            subtitle: Text('2학생회관'),
                            trailing: Text('0.2km'),
                          ),
                          ListTile(
                            title: Text('Wallet'),
                            subtitle: Text('대학 A동'),
                            trailing: Text('0.4km'),
                          ),
                          ListTile(
                            title: Text('Card'),
                            subtitle: Text('대학 A동'),
                            trailing: Text('0.5km'),
                          ),
                          ListTile(
                            title: Text('Phone'),
                            subtitle: Text('대학 B동'),
                            trailing: Text('0.5km'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
