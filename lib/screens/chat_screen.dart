import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mew_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mew_chat/screens/registration_screen.dart';

class ChatScreen extends StatefulWidget {
  static String id='chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller=TextEditingController();
  final _firestore=FirebaseFirestore.instance;
  final _auth= FirebaseAuth.instance;
  String message;
  User currentUser;


  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  void getCurrentUser(){
    final user= _auth.currentUser;
    if(user!=null){
      currentUser=user;
      print(currentUser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    String uName = userName;
    print(uName);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
               Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            StreamBuilder<QuerySnapshot>(
              stream : _firestore.collection('Message').snapshots(),
              // ignore: missing_return
              builder: (context , snapshot){
                if(snapshot.hasData){
                  final messages= snapshot.data.docs;
                  List<Widget> widgetMessage=[];
                  for (var message in messages){
                    final messageName= message.data()['name'];
                    final messageText= message.data()['message'];

                    final messageView= MessageBubble(

                      senderName: messageName,
                      mText: messageText,
                      isMe: messageName==uName,
                    );

                    widgetMessage.add(messageView);

                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsets.only(left: 5 , right: 5),
                      children: widgetMessage,
                    ),
                  );
                }
                  else{
                    return CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    );
                }
              },
            ),


            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        message =value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      controller.clear();
                     _firestore.collection('Message').add({
                       'name' : uName,
                       'message' : message,
                     });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.mText,this.senderName,this.isMe});
  final String mText ;
  final String senderName;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(9),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(senderName, style: TextStyle( color: Colors.grey,fontSize: 16),),
          Material(
            color: isMe ? Colors.blue : Colors.white,
            borderRadius: isMe? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
            ):BorderRadius.only(
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                child: Text(mText, style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                  fontSize: 16
                ),)),
          ),
        ],
      ),
    );
  }
}

