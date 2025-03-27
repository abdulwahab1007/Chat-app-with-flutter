import 'package:flutter/material.dart';

class UserItem extends StatelessWidget{
  const UserItem({
    super.key,
    required this.onTap,
    required this.title
    });

  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Theme.of(context).colorScheme.tertiary), 
          
        ),
        child: Row( 
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 5,),
            Text(title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary
            ),),
          ],
        )
      ),
    );
  }
}