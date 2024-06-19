import 'package:employee_registry/fifth_screen.dart';
import 'package:employee_registry/home.dart';
import 'package:employee_registry/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'database_helper.dart';
import 'second_screen.dart';

class ForthScreen extends StatefulWidget {
  const ForthScreen({super.key});

  @override
  _ForthScreenState createState() => _ForthScreenState();
}

class _ForthScreenState extends State<ForthScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _employeeDetails = [];
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

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _searchEmployee() async {
    final String fromDate = _fromDateController.text.trim();
    final String toDate = _toDateController.text.trim();
    final String searchText = _searchController.text.trim();

    if (fromDate.isNotEmpty && toDate.isNotEmpty) {
      // Search by date range
      final employees = await DatabaseHelper().getEmployeesByDateRange(fromDate, toDate);
      setState(() {
        _employeeDetails = employees;
        _animationController.forward(from: 0.0);
      });
      if (employees.isEmpty) {
        _showNoEmployeeFoundDialog();
      }
    } else if (searchText.isNotEmpty) {
      // Search by other criteria
      final employee = await DatabaseHelper().getEmployeeByCriteria(searchText);
      setState(() {
        _employeeDetails = employee != null ? [employee] : [];
        _animationController.forward(from: 0.0);
      });
      if (employee == null) {
        _showNoEmployeeFoundDialog();
      }
    }
  }

  void _clearSearch() {
    setState(() {
      _fromDateController.clear();
      _toDateController.clear();
      _searchController.clear();
      _employeeDetails = [];
    });
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
        child: SingleChildScrollView(
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
                    'ATTENDANCE',
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
                            labelText: 'Enter Employee details',
                            labelStyle: const TextStyle(fontFamily: 'PTSans'),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _fromDateController,
                          decoration: InputDecoration(
                            labelText: 'From Date',
                            labelStyle: const TextStyle(fontFamily: 'PTSans'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context, _fromDateController);
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          controller: _toDateController,
                          decoration: InputDecoration(
                            labelText: 'To Date',
                            labelStyle: const TextStyle(fontFamily: 'PTSans'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context, _toDateController);
                              },
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _searchEmployee,
                        child: const Text('Search'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _clearSearch,
                        child: const Text('Clear'),
                      ),
                    ),
                  ],
                ), 
              ),
              if (_employeeDetails.isNotEmpty)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: 400,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _employeeDetails.map((employee) {
                          return Container(
                            width: 400,
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink.shade200),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${employee['name']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ID: ${employee['id']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Gender: ${employee['gender']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Email: ${employee['email']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Mobile: ${employee['mobile']}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Attendance Date: ${employee['attendanceDate'] != null ? DateTime.parse(employee['attendanceDate']).toLocal().toString().split(' ')[0] : 'N/A'}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 110), // To push the bottom container to the bottom
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const ForthScreen()),
                // );
              },
              child: Image.asset(
                'assets/4.png',
                color: Colors.pink.shade200,
                width: 50,
                height: 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Read Tag tapped');
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const FifthScreen()),
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
    );
  }
}
