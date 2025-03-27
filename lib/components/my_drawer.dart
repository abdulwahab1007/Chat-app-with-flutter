import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({
    super.key,
    required this.onTap
    });
  final void Function()? onTap;
  
  @override
  Widget build(BuildContext context) {
     return  Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
              Column(
                children: [
                DrawerHeader(
            child: Icon(Icons.message,
            color: Theme.of(context).colorScheme.primary,
            size: 45,) 
            ),
            const SizedBox(height: 30,),
             Padding(
              padding: const  EdgeInsets.only(left: 20),
              child: ListTile(
                onTap: () => Navigator.pop(context),
                title: Text('   H O M E ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold
                ),),
                leading: const Icon(Icons.home),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
              )  ,
               Padding(
              padding: const  EdgeInsets.only(left: 20),
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>const SettingsPage()
                    ));
                },
                title: Text('   S E T T I N G S  ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold
                ),),
                leading: const Icon(Icons.settings),
                iconColor: Theme.of(context).colorScheme.primary,
              ),
              ),  
                ],
              ),
               Padding(
              padding: const  EdgeInsets.only(left: 20,bottom: 15),
              child: ListTile(
                title: Text('   L O G O U T',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold
                ),),
                leading: const Icon(Icons.logout),
                iconColor: Theme.of(context).colorScheme.primary,
                onTap: onTap,
              ),
              )    
        ],
      ),
     );
  }
}