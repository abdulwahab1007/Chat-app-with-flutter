// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
   LoginPage({
    super.key,
    required this.onTap
    });

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final void Function()? onTap;

  login(BuildContext context) async{
    //get the instance of the authService class 
    final authService=AuthService();
    try{
      await authService.signInWithEmailAndPassword(
        emailController.text, passwordController.text);
    }
    catch(e){
      showDialog(
        context: context, 
        builder: (context)=>AlertDialog(
          content: Text(e.toString(),
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 16,
          fontWeight: FontWeight.bold),),
        )
        );
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:  SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo 
              Icon(Icons.message,
              size: 62,
              color: Theme.of(context).colorScheme.primary,),
              //text(let's create an account for you)
              const SizedBox(height: 40,),
              Text('Let\'s create an account for you ',
              style: TextStyle(color: Theme.of(context).colorScheme.primary,
              fontSize: 16),),
              
              //text Fields 
              SizedBox(height: 20,),
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
                focusNode: null,
                
                ),
                SizedBox(height: 20.0,),
                 MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                focusNode: null,
                ),

              //sign up buttons 
              SizedBox(height: 40,),
              MyButton(
                text: 'Login',
                onTap: ()=>login(context),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16
                    ),),
                    GestureDetector(
                      onTap: onTap,
                      child: Text('Register now ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                    )
                  ],
                )

              // Register now button 
            ],
          ),
          ),
      ),
    );
  }
}