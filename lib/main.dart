import 'package:amanah/providers/kyc_provider.dart';
import 'package:amanah/providers/loan_provider.dart';
import 'package:amanah/providers/pengajuan_loan_provider.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:amanah/screens/Borrower/Home/borrower_homepage_screen.dart';
import 'package:amanah/screens/Landing/landing_screen.dart';
import 'package:amanah/screens/Lenders/home/homepage_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:amanah/providers/authentication_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => KycProvider()),
        ChangeNotifierProvider(create: (_) => LoanProvider()),
        ChangeNotifierProvider(create: (_) => PengajuanLoanProvider()),
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
