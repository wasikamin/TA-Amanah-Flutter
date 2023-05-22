import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amanah/providers/authentication__provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: MaterialApp(
        title: 'P2P Lending App',
        theme: ThemeData(
            // Your app's theme configurations
            ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('P2P Lending App'),
      ),
      body: Center(
        child: Consumer<AuthenticationProvider>(
          builder: (context, provider, child) {
            return Text(provider.isLoggedIn ? 'Logged In' : 'Not Logged In');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authenticationProvider.login('testing8021@yopmail.com', 'Test@123');
        },
        child: Icon(Icons.login),
      ),
    );
  }
}
