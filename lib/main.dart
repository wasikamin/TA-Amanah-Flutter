import 'package:amanah/screens/Borrower/borrower_homepage_screen.dart';
import 'package:amanah/screens/Landing/landing_screen.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:amanah/providers/authentication_provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, child) {
          return MaterialApp(
            title: 'P2P Lending App',
            theme: ThemeData(fontFamily: 'Inter'
                // Your app's theme configurations
                ),
            home: authProvider.isLoggedIn
                ? authProvider.role == "lender"
                    ? const HomePage()
                    : const BorrowerHomePage()
                : const LandingScreen(),
          );
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authenticationProvider = Provider.of<AuthenticationProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('P2P Lending App'),
//       ),
//       body: Center(
//         child: Consumer<AuthenticationProvider>(
//           builder: (context, provider, child) {
//             return Text(provider.isLoggedIn ? 'Logged In' : 'Not Logged In');
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           authenticationProvider.login('testing8021@yopmail.com', 'Test@123');
//         },
//         child: Icon(Icons.login),
//       ),
//     );
//   }
// }
