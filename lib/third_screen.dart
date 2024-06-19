import 'package:employee_registry/fifth_screen.dart';
import 'package:employee_registry/forth_screen.dart';
import 'package:employee_registry/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'second_screen.dart';
import 'database_helper.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> with TickerProviderStateMixin {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  String? selectedGender;

  final DateTime today = DateTime.now();

  // Animation controllers
  late AnimationController idControllerAnimation;
  late AnimationController nameControllerAnimation;
  late AnimationController emailControllerAnimation;
  late AnimationController mobileControllerAnimation;
  late Animation<double> idAnimation;
  late Animation<double> nameAnimation;
  late Animation<double> emailAnimation;
  late Animation<double> mobileAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controllers
    idControllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    nameControllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    emailControllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    mobileControllerAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Initialize animations
    idAnimation = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(idControllerAnimation);
    nameAnimation = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(nameControllerAnimation);
    emailAnimation = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(emailControllerAnimation);
    mobileAnimation = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticIn)).animate(mobileControllerAnimation);
  }

  @override
  void dispose() {
    idControllerAnimation.dispose();
    nameControllerAnimation.dispose();
    emailControllerAnimation.dispose();
    mobileControllerAnimation.dispose();
    super.dispose();
  }

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
                  'REGISTER',
                  style: TextStyle(
                    fontFamily: 'PTSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  height: 600,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: idAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(idAnimation.value, 0),
                              child: TextField(
                                controller: idController,
                                decoration: const InputDecoration(
                                  labelText: 'ID',
                                  hintText: 'Enter your ID',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: nameAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(nameAnimation.value, 0),
                              child: TextField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  hintText: 'Enter Your Name',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                 keyboardType: TextInputType.text,
                                  inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            labelStyle: TextStyle(
                              fontFamily: 'PTSans',
                            ),
                          ),
                          value: selectedGender,
                          items: ['Male', 'Female', 'Others']
                              .map((gender) => DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: emailAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(emailAnimation.value, 0),
                              child: TextField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Enter your Email',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        AnimatedBuilder(
                          animation: mobileAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(mobileAnimation.value, 0),
                              child: TextField(
                                controller: mobileController,
                                decoration: const InputDecoration(
                                  labelText: 'Mobile',
                                  hintText: 'Enter Your Mobile No.',
                                  labelStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'PTSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (validateFields(context)) {
                                    Map<String, dynamic> employee = {
                                      'id': int.parse(idController.text),
                                      'name': nameController.text,
                                      'gender': selectedGender,
                                      'email': emailController.text,
                                      'mobile': mobileController.text,
                                      'attendanceDate': today.toIso8601String(),
                                    };
                                    await DatabaseHelper().saveEmployee(employee);
                                    _showDialog(context, 'Saved Successfully');
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  idController.clear();
                                  nameController.clear();
                                  emailController.clear();
                                  mobileController.clear();
                                  setState(() {
                                    selectedGender = null;
                                  });
                                  _showDialog(context, 'Reset Successfully');
                                },
                                child: const Text(
                                  'Reset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Homescreen(),
                        ),
                      );
                      print('Home icon pressed');
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('User data tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SecondScreen(),
                        ),
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
                    },
                    child: Image.asset(
                      'assets/3.png',
                      color: Colors.pink.shade200,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('User data tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ForthScreen(),
                        ),
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
                          builder: (context) => const FifthScreen(),
                        ),
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

  bool validateFields(BuildContext context) {
    bool valid = true;

    if (idController.text.isEmpty) {
      idControllerAnimation.forward(from: 0);
      valid = false;
    }
    if (nameController.text.isEmpty) {
      nameControllerAnimation.forward(from: 0);
      valid = false;
    }
    if (selectedGender == null) {
      _showDialog(context, 'Gender is required');
      valid = false;
    }
    if (emailController.text.isEmpty) {
      emailControllerAnimation.forward(from: 0);
      valid = false;
    }
    if (mobileController.text.isEmpty) {
      mobileControllerAnimation.forward(from: 0);
      valid = false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      _showDialog(context, 'Invalid email format');
      valid = false;
    }

    if (!valid) {
      _showDialog(context, 'All fields are required');
    }

    return valid;
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
