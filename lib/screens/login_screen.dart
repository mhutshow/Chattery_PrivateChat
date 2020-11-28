import 'package:flutter/material.dart';
import 'package:mew_chat/constants.dart';
import 'package:mew_chat/components/roundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mew_chat/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id='login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                 onChanged: (value) {
                  email=value;

              },
              decoration: kRegistrationBoxStyle),
            SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true ,
                textAlign: TextAlign.center,
                onChanged: (value) {
                password=value;
              },
              decoration: kRegistrationBoxStyle.copyWith(hintText: 'Enter Password')
            ),
            SizedBox(
              height: 24.0,
            ),
            CircleButton(
              text: 'Log In',
              color: Color(0xFFF3B139),
              pressed: ()async{
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if(user!=null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                }
                catch(e){}
              },
            ),
          ],
        ),
      ),
    );
  }
}
