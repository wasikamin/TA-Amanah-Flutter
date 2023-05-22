import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/authentication__provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32))),
              onPressed: () async {
                await authenticationProvider.logout();
              },
              child: Text(
                'Keluar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
