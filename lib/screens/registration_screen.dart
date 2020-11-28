import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mew_chat/components/roundedButton.dart';
import 'package:mew_chat/constants.dart';
import 'package:mew_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

String userName;
class RegistrationScreen extends StatefulWidget {
  static String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _saving = false;
  final _auth= FirebaseAuth.instance;
  String email,password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
          inAsyncCall: _saving,
        child: Padding(
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
              TextField(
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    userName=value;
                  },
                  decoration: kRegistrationBoxStyle
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                  //Do something with the user input.
                },
                decoration: kRegistrationBoxStyle
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true ,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kRegistrationBoxStyle.copyWith(
                    hintText: 'Enter Your Password'),
                ),
              SizedBox(
                height: 24.0,
              ),
              CircleButton(
                  color: Color(0xFF1DA658),
                  text: 'Register',
                  pressed: ()async{
                    setState(() {
                      _saving=true;
                    });
                    try{
                      final newUser =await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser!=null){
                       Navigator.pushNamed(context, ChatScreen.id );
                     }
                      setState(() {
                        _saving=false;
                      });
                    }
                    catch (e){}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
