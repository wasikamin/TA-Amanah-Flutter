import 'package:amanah/models/user.dart';

class AuthenticationService {
  Future<User> login(String email, String password) async {
    // Simulating an asynchronous login process
    await Future.delayed(Duration(seconds: 2));

    // Check if the login credentials are valid
    if (email == 'example@gmail.com' && password == 'password') {
      // Return the logged-in user
      return User(id: 1, name: 'John Doe', email: email);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> logout() async {
    // Simulating an asynchronous logout process
    await Future.delayed(Duration(seconds: 1));
    // Perform logout logic here
  }
}
