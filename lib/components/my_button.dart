import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  const MyButton({
    super.key,
    required this.text,
    required this.onTap
    });

  final String? text; 
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        padding: const EdgeInsets.all(25.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary)
        ),
        child:  Center(child: Text(text!,
        style:  const TextStyle(),),),
      ),
    );
  }
}