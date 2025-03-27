import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  const SettingsPage({super.key});
    // So now in here I need a tile , to convert the light mode to dark and dark to light 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20.0,),
          Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Theme.of(context).colorScheme.tertiary)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dark Mode',
                style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                //for this First of all build the Theme Provicer 
                //Cupertino Switch 
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode, 
                  onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme()
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

}