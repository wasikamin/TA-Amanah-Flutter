import 'package:amanah/screens/Lenders/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/authentication_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    Dashboard(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Page 3',
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Center(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32))),
      onPressed: () async {
        await authenticationProvider.logout(context);
      },
      child: Text(
        'Keluar',
      ),
    ));
  }
}
