import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gd6_a_1679/database/sql_helper.dart';
import 'inputPage.dart'; // Import InputPage for employees
import 'inputPageFood.dart'; // Import FoodInputPage


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'SQFLITE'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> employees = [];
  List<Map<String, dynamic>> foodItems = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    refreshEmployeeList();
    refreshFoodList();
  }

  void refreshEmployeeList() async {
    final data = await SQLHelper.getEmployee();
    setState(() {
      employees = data;
    });
  }

  void refreshFoodList() async {
    final data = await SQLHelper.getFood();
    setState(() {
      foodItems = data;
    });
  }

  Future<void> deleteEmployee(int id) async {
    await SQLHelper.deleteEmployee(id);
    refreshEmployeeList();
  }

  Future<void> deleteFood(int id) async {
    await SQLHelper.deleteFood(id);
    refreshFoodList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? "Employee List" : "Food List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (_selectedIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputPage(
                      title: 'Add Employee',
                      id: null,
                      name: null,
                      email: null,
                    ),
                  ),
                ).then((_) => refreshEmployeeList());
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodInputPage(
                      title: 'Add Food',
                      id: null,
                      name: null,
                      ingredients: null,
                    ),
                  ),
                ).then((_) => refreshFoodList());
              }
            },
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(employees[index]['id']),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputPage(
                                title: 'Edit Employee',
                                id: employees[index]['id'],
                                name: employees[index]['name'],
                                email: employees[index]['email'],
                              ),
                            ),
                          ).then((_) => refreshEmployeeList());
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                        label: 'Update',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          await deleteEmployee(employees[index]['id']);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(employees[index]['name']),
                    subtitle: Text(employees[index]['email']),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: ValueKey(foodItems[index]['id']),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodInputPage(
                                title: 'Edit Food',
                                id: foodItems[index]['id'],
                                name: foodItems[index]['name'],
                                ingredients: foodItems[index]['ingredients'],
                              ),
                            ),
                          ).then((_) => refreshFoodList());
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.update,
                        label: 'Update',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          await deleteFood(foodItems[index]['id']);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(foodItems[index]['name']),
                    subtitle: Text(foodItems[index]['ingredients']),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Employee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Food',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
