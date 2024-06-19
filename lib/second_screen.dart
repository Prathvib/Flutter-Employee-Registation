import 'package:employee_registry/fifth_screen.dart';
import 'package:employee_registry/forth_screen.dart';
import 'package:employee_registry/home.dart';
import 'package:employee_registry/third_screen.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';

class SecondScreen extends StatefulWidget {
  final Map<String, dynamic>? employeeDetails;

  const SecondScreen({super.key, this.employeeDetails});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> with TickerProviderStateMixin {
  List<Map<String, dynamic>> _employees = [];
  List<Map<String, dynamic>> _allEmployees = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.employeeDetails == null) {
      _fetchEmployees();
    } else {
      _employees = [widget.employeeDetails!];
    }
  }

  Future<void> _fetchEmployees() async {
    List<Map<String, dynamic>> employees = await DatabaseHelper().getEmployees("");
    setState(() {
      _employees = employees;
      _allEmployees = employees;  // Store a copy of the original employee list
    });
  }

  Future<void> _searchEmployee() async {
    final String searchText = _searchController.text.trim().toLowerCase();
    if (searchText.isNotEmpty) {
      List<Map<String, dynamic>> filteredEmployees = _allEmployees.where((employee) {
        return employee['name'].toString().toLowerCase().contains(searchText) ||
               employee['id'].toString().contains(searchText) ||
               employee['gender'].toString().toLowerCase().contains(searchText) ||
               employee['email'].toString().toLowerCase().contains(searchText) ||
               employee['mobile'].toString().contains(searchText);
      }).toList();
      setState(() {
        _employees = filteredEmployees;
      });
    } else {
      setState(() {
        _employees = _allEmployees;
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _employees = _allEmployees;
    });
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
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(114, 0, 87, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'USERDATA',
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
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _searchEmployee,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _clearSearch,
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _employees.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> employee = _employees[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${employee['name']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ID: ${employee['id']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Gender: ${employee['gender']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email: ${employee['email']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Mobile: ${employee['mobile']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _showEditDialog(employee);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _showDeleteDialog(employee['id']);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
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
                            builder: (context) => const Homescreen()),
                      );
                      print('Home icon pressed');
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      print('User data tapped');
                    },
                    child: Image.asset(
                      'assets/2.png',
                      color: Colors.pink.shade200,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Register tapped');
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ThirdScreen()),
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

  void _showDeleteDialog(int employeeId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this employee?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                await DatabaseHelper().deleteEmployee(employeeId);
                await _fetchEmployees();
                _showDeleteAnimation();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAnimation() {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Positioned(
                  top: 200,
                  child: Icon(Icons.delete, size: 100,  color:  Color.fromRGBO(114, 0, 87, 1),),
                ),
                Positioned(
                  top: 300,
                  child: Icon(Icons.delete_outline, size: 200,  color: Colors.pink.shade50),
                ),
              ],
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  void _showEditDialog(Map<String, dynamic> employee) {
    TextEditingController nameController =
        TextEditingController(text: employee['name']);
    TextEditingController emailController =
        TextEditingController(text: employee['email']);
    TextEditingController mobileController =
        TextEditingController(text: employee['mobile']);
    String? selectedGender = employee['gender'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Employee'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(fontFamily: 'PTSans'),
                  ),
                  value: selectedGender,
                  items: ['Male', 'Female', 'Others']
                      .map((gender) => DropdownMenuItem(
                            value: gender,
                            child: Text(gender),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedGender = value;
                  },
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "Email"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: mobileController,
                  decoration: const InputDecoration(hintText: "Mobile"),
                ),
                const SizedBox(height: 20),
                // Removed the attendance date picker from the edit dialog
                Text(
                  'Attendance Date: ${employee['attendanceDate'] != null ? DateTime.parse(employee['attendanceDate']).toLocal().toString().split(' ')[0] : 'N/A'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                Map<String, dynamic> updatedEmployee = {
                  'id': employee['id'],
                  'name': nameController.text,
                  'gender': selectedGender,
                  'email': emailController.text,
                  'mobile': mobileController.text,
                  'attendanceDate': employee[
                      'attendanceDate'], // Keep the original attendance date
                };
                await DatabaseHelper().updateEmployee(updatedEmployee);
                _fetchEmployees();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
