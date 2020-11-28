import 'package:flutter/material.dart';
import 'package:mew_chat/screens/chat_screen.dart';
import 'package:mew_chat/screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}
class FlashChat extends StatelessWidget {
  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        RegistrationScreen.id : (context)=> RegistrationScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        ChatScreen.id : (context)=> ChatScreen(),
      },
    );
  }
}
