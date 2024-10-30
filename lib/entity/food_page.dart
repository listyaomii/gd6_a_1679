import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  final int? id;
  final String? name;
  final String? bahan;

  const FoodPage({Key? key, this.id, this.name, this.bahan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name ?? 'Food Name'),
            SizedBox(height: 8),
            Text(bahan ?? 'Ingredients'),
          ],
        ),
      ),
    );
  }
}
