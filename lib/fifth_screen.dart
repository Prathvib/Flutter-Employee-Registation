import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'home.dart';
import 'second_screen.dart';
import 'third_screen.dart';
import 'forth_screen.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({super.key});

  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? _employeeDetails;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Future<void> _searchEmployee() async {
    final int id = int.tryParse(_searchController.text) ?? -1;
    if (id != -1) {
      final employee = await DatabaseHelper().getEmployeeById(id);
      setState(() {
        _employeeDetails = employee;
        _animationController.forward(from: 0.0);
      });
      if (employee == null) { 
        // Show dialog when no employee is found
        _showNoEmployeeFoundDialog();
      }
    }
  }

  void _showNoEmployeeFoundDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Employee Found'),
          content: const Text('No employee found with the given details.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
                  'READ TAG',
                  style: TextStyle(
                    fontFamily: 'PTSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          labelText: 'Enter Search Item here',
                          hintText: 'Enter the search details',
                          hintStyle: const TextStyle(fontFamily: 'PTSans'),
                          labelStyle:const TextStyle(fontFamily: 'PTSans'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _searchEmployee,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_employeeDetails != null)
            FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: 
              Container(
                width:400,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${_employeeDetails!['name']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'ID: ${_employeeDetails!['id']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Gender: ${_employeeDetails!['gender']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Email: ${_employeeDetails!['email']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Mobile: ${_employeeDetails!['mobile']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                      ],
                    ),
                  ),
                ),
              ),
            Expanded(child: Container()), // To push the bottom container to the bottom
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
                        MaterialPageRoute(builder: (context) => const Homescreen()),
                      );
                      print('Home icon pressed');
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('User data tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const SecondScreen()),
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
                      print('User data tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ForthScreen()),
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
                    },
                    child: Image.asset(
                      'assets/5.png',
                      color: Colors.pink.shade200,
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
