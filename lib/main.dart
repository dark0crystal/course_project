import 'package:flutter/material.dart';


// In Flutter, MaterialApp() is a widget that serves as the root of a Flutter application and provides essential configurations for a Material Design-based app.
// It's on the top near the widget tree , 


// we are adding const in front of the MaterialApp() to improve performance , 
// because if we tell fultter that sth is a constant , it knows then the value will not change
void main() {
  runApp(MaterialApp(
    home: Text("Hello World , Hello Ninjas!!"),
  ));
}
