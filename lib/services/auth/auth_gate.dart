import 'package:chat_app/services/auth/login_or_register_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget{
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    // now here we'll check that if the User is logged in or not 
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context,snapshot){
          //check if the User is logged in or not 
          if(snapshot.hasData){
            return  HomePage();
          }
          else{
            return const LoginOrRegisterPage();
          }
        }
        ),
    );
  }
}