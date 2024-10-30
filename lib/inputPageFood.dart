import 'package:flutter/material.dart';
import 'package:gd6_a_1679/database/sql_helper.dart';

class FoodInputPage extends StatefulWidget {
  const FoodInputPage({
    super.key,
    required this.title,
    required this.id,
    required this.name,
    required this.ingredients,
  });

  final String? title, name, ingredients;
  final int? id;

  @override
  State<FoodInputPage> createState() => _FoodInputPageState();
}

class _FoodInputPageState extends State<FoodInputPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerIngredients = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      // Populate the text fields with existing data if editing
      controllerName.text = widget.name ?? '';
      controllerIngredients.text = widget.ingredients ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "INPUT FOOD"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Food Name',
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerIngredients,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ingredients',
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () async {
              if (widget.id == null) {
                await addFood();
              } else {
                await editFood(widget.id!);
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  Future<void> addFood() async {
    await SQLHelper.addFood(controllerName.text, controllerIngredients.text);
  }

  Future<void> editFood(int id) async {
    await SQLHelper.editFood(id, controllerName.text, controllerIngredients.text);
  }
}
