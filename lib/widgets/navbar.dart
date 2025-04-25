import 'package:course_project/pages/AddNewPostPage.dart';
import 'package:course_project/shared/auth_state.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../pages/About.dart';
import '../pages/Signup.dart';
import '../pages/Login.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  bool _showMenu = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _showMenu = !_showMenu;
      if (_showMenu) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'lib/assets/logo.png',
                        width: 70,
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: _toggleMenu,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE17F),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _animation.value * 0.5,
                                      child: Column(
                                        children: [
                                          Container(width: 20, height: 2, color: Colors.black),
                                          const SizedBox(height: 4),
                                          Container(width: 20, height: 2, color: Colors.black),
                                          const SizedBox(height: 4),
                                          Container(width: 20, height: 2, color: Colors.black),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var image in [
                        'lib/assets/oman1.jpeg',
                        'lib/assets/oman2.webp',
                        'lib/assets/oman3.jpeg',
                        'lib/assets/oman4.webp'
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              image,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (_showMenu)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _animation,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: const Color(0xFFFEE17F),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54)),
                                GestureDetector(
                                  onTap: _toggleMenu,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEE17F),
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Icon(Icons.close, size: 32),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const AboutPage()),
                                    );
                                    _toggleMenu(); // Close the menu
                                  },
                                  child: const Text(
                                    'About',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                
                                const SizedBox(height: 32),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AddNewPostPage(),
                                        ),
                                      );
                                    },
                                    child: const Text("Add New Post"),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                ValueListenableBuilder(
                                  valueListenable: AuthState.isLoggedIn,
                                  builder: (context, isLoggedIn, child) {
                                    return !isLoggedIn
                                        ? Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Signup()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 40, vertical: 16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                            ],
                                          )
                                        : const SizedBox.shrink();
                                  },
                                ),
                                const SizedBox(height: 20),
                                ValueListenableBuilder(
                                  valueListenable: AuthState.isLoggedIn,
                                  builder: (context, isLoggedIn, child) {
                                    return isLoggedIn
                                        ? ElevatedButton(
                                            onPressed: () {
                                              AuthState.isLoggedIn.value = false;
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                    content:
                                                        Text("You have signed out.")),
                                              );
                                              _toggleMenu();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: const Text(
                                              'Sign Out',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          )
                                        : ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Login()),
                                              );
                                              _toggleMenu();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 40, vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                            ),
                                            child: const Text(
                                              'Log In',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
