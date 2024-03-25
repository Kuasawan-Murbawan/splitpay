import 'package:flutter/material.dart';
import 'results_page.dart'; // Import the results page

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Map<String, dynamic>> expenses = [];

  String memberName = '';
  String itemName = '';
  double totalPaid = 0.0;

  TextEditingController memberNameController = TextEditingController();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController totalPaidController = TextEditingController();

  // Function to clear data
  void clearData() {
    setState(() {
      expenses.clear();
    });
  }

  // Function to navigate to results page
  void navigateToResults() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultsPage(expenses: expenses)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total number of members
    int totalMembers = expenses.length;

    // Calculate total amount paid
    double totalAmountPaid = expenses.fold(
        0, (previousValue, expense) => previousValue + expense['totalPaid']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Row(
          children: [
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            SizedBox(width: 30),
            Text(
              "SplitPay",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: clearData,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green], // Choose your colors
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Member\'s Name:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  TextField(
                                    controller: memberNameController,
                                    onChanged: (value) {
                                      setState(() {
                                        memberName = value;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Enter member\'s name',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Item Name:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            TextField(
                                              controller: itemNameController,
                                              onChanged: (value) {
                                                setState(() {
                                                  itemName = value;
                                                });
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Total Paid:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            TextField(
                                              controller: totalPaidController,
                                              onChanged: (value) {
                                                setState(() {
                                                  totalPaid =
                                                      double.tryParse(value) ??
                                                          0.0;
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
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
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.amber),
                                        onPressed: () {
                                          if (memberName.isNotEmpty &&
                                              itemName.isNotEmpty &&
                                              totalPaid > 0.0) {
                                            setState(() {
                                              expenses.add({
                                                'memberName': memberName,
                                                'itemName': itemName,
                                                'totalPaid': totalPaid,
                                              });
                                            });

                                            // Clear the input fields
                                            memberNameController.clear();
                                            itemNameController.clear();
                                            totalPaidController.clear();
                                          } else {
                                            // Show a dialog if any controller is empty
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Error'),
                                                  content: const Text(
                                                      'Please fill in all fields with valid data.'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 100),
                                          child: Row(
                                            children: [
                                              Icon(Icons.add_circle),
                                              SizedBox(width: 10),
                                              Text('Add'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Expenses List:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Name'),
                            SizedBox(width: 10),
                            Text('Item'),
                            SizedBox(width: 10),
                            Text('Paid (RM)'),
                            SizedBox(width: 50),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: expenses.asMap().entries.map((entry) {
                        final index = entry.key;
                        final expense = entry.value;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('${expense['memberName']}'),
                            ),
                            Expanded(
                              child: Text('${expense['itemName']}'),
                            ),
                            Expanded(
                              child: Text('RM ${expense['totalPaid']}'),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  expenses.removeAt(index);
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total Members: $totalMembers\nTotal Amount Paid: \RM ${totalAmountPaid.toStringAsFixed(2)}\n Pay/person: \RM ${totalAmountPaid / totalMembers}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              onPressed: navigateToResults,
              child: const Text("Calculate"),
            ),
          ),
        ),
      ),
    );
  }
}
