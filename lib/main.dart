
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:qr_reader/providers/ui_provider.dart';


import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      //varios providers
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider(),),
      ],

      
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,

        title: 'Material App',

        initialRoute: 'home',
        
        routes: {
          'home' : (_) => HomePage(),
          'map' :  (_) => MapPage(),
        },
        theme:ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData (
            backgroundColor: Colors.deepPurple
          )
          
        ) ,
        
      ),
    );
  }
}