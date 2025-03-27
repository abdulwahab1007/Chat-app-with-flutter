// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget{
   RegisterPage({
    super.key,
    required this.onTap
    });

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  final void Function()? onTap;

  final AuthService authService=AuthService();

  register(BuildContext context){
    if(passwordController.text==confirmPasswordController.text){
      try{
        authService.createUserWithEmailAndPassword(emailController.text, passwordController.text);
      }
      catch(e){
        showDialog(
          context: context, 
          builder: (context)=>AlertDialog(
            content: Text(e.toString(),
             style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold),),
          )
          );
      }
    }
    else{
      showDialog(
        context: context, 
        builder: (context)=>AlertDialog(
          content: Text('Password didn\'t matched ',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold), ),
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
                SizedBox(height: 20.0,),
                 MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
                focusNode: null
                ),

              //sign up buttons 
              SizedBox(height: 40,),
              MyButton(
                text: 'Register',
                onTap: ()=>register(context),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account !  ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16
                    ),),
                    GestureDetector(
                      onTap: onTap,
                      child: Text('Login',
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