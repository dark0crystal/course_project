import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/navbar.dart';
import 'widgets/hero_section.dart';
import 'widgets/action_section.dart';
import 'widgets/footer.dart';

// In Flutter, MaterialApp() is a widget that serves as the root of a Flutter application and provides essential configurations for a Material Design-based app.
// It's on the top near the widget tree , 


// we are adding const in front of the MaterialApp() to improve performance , 
// because if we tell fultter that sth is a constant , it knows then the value will not change
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Almlah',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Navbar(),
            SizedBox(height: 40),
            HeroSection(),
            SizedBox(height: 40),
            ActionSection(),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Footer(),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
