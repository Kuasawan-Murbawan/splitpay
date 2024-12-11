import 'package:flutter/material.dart';

class AddRowExample extends StatefulWidget {
  @override
  _AddRowExampleState createState() => _AddRowExampleState();
}

class _AddRowExampleState extends State<AddRowExample> {
  // List to store dynamically added rows
  List<Widget> rows = [];

  // Controllers for the text fields
  final itemNameController = TextEditingController();
  final totalPaidController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    itemNameController.dispose();
    totalPaidController.dispose();
    super.dispose();
  }

  void addRow() {
    setState(() {
      rows.add(
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Item Name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: itemNameController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter item\'s name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Paid:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: totalPaidController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'RM ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Rows Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: addRow,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [
                    Icon(Icons.add_circle),
                    SizedBox(width: 10),
                    Text('Add Item'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: rows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
