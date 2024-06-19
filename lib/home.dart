import 'package:employee_registry/fifth_screen.dart';
import 'package:employee_registry/forth_screen.dart';
import 'package:employee_registry/third_screen.dart';
import 'package:flutter/material.dart';

import 'second_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(18),
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(114, 0, 87, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'EMPLOYEE ATTENDENCE REGISTRY',
                  style: TextStyle(
                    fontFamily: 'PTSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'WELCOME BACK',
              style: TextStyle(
                fontFamily: 'PTSans',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(114, 0, 87, 1),
              ),
            ),
            Expanded(
                child:
                    Container()), // To push the bottom container to the bottom
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 110,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(114, 0, 87, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home),
                    color: Colors.pink.shade200,
                    iconSize: 70,
                    onPressed: () async {
                      print('Home icon pressed');
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('User data tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SecondScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/2.png',
                      color: Colors.white,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Register tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ThirdScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/3.png',
                      color: Colors.white,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Attendence tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ForthScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/4.png',
                      color: Colors.white,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Read Tag tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const FifthScreen()),
                      );
                    },
                    child: Image.asset(
                      'assets/5.png',
                      color: Colors.white,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
