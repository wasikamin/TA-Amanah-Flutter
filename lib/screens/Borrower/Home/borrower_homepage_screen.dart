import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/screens/Borrower/Home/dashboard_screen.dart';
import 'package:amanah/screens/Borrower/Home/riwayat_pinjaman_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/authentication_provider.dart';

class BorrowerHomePage extends StatefulWidget {
  const BorrowerHomePage({super.key});
  @override
  _BorrowerHomePage createState() => _BorrowerHomePage();
}

class _BorrowerHomePage extends State<BorrowerHomePage> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    const Dashboard(),
    RiwayatPinjamanScreen(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          // If the current page is the first page of the PageView,
          // prevent going back by returning false
          return false;
        } else {
          // Go to the previous page in the PageView
          setState(() {
            _currentIndex--;
          });
          return false;
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: primaryColor, size: 30),
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
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
