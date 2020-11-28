import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mew_chat/screens/login_screen.dart';
import 'package:mew_chat/screens/registration_screen.dart';
import 'package:mew_chat/components/roundedButton.dart';

class WelcomeScreen extends StatefulWidget {
  static String id='welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation animation ;

  @override
  void initState() {
    super.initState();
    controller= AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    // animation= CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    animation=ColorTween(begin: Colors.grey[300], end :Colors.white).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    });
  }
 @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                    child: Image.asset('assets/images/logo.png'),
                height: 300,
                width: 300,
                  ),
            ),
        FadeAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: [
              "Do IT!",
              "Do it RIGHT!!",
              "Do it RIGHT NOW!!!"
            ],
            textStyle: TextStyle(

                color: Colors.red,
                fontSize: 32.0,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
            alignment: AlignmentDirectional.topStart // or Alignment.topLeft
        ),
            SizedBox(
              height: 20.0,
            ),
            CircleButton(
              color: Color(0xFFF3B139),
              pressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
              text: 'Log In',
            ),

            CircleButton(
              color: Color(0xFF1DA658),
              pressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}

