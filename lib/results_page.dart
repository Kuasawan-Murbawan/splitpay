import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;

  ResultsPage({required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Calculate total amount paid overall
    double totalPaidOverall = 0;
    for (var expense in expenses) {
      totalPaidOverall += expense['totalPaid'];
    }

    // Calculate average amount paid per person
    double averageAmount = totalPaidOverall / expenses.length;

    // Determine who owes money to whom and how much
    Set<String> paymentSet = Set<String>();
    for (var expense in expenses) {
      String debtor = expense['memberName'];
      double amountPaid = expense['totalPaid'];
      double difference = amountPaid - averageAmount;
      if (difference < 0) {
        List<String> creditors = [];
        for (var otherExpense in expenses) {
          if (otherExpense['totalPaid'] > averageAmount) {
            creditors.add(otherExpense['memberName']);
          }
        }
        if (creditors.isNotEmpty) {
          double amountPerCreditor = difference.abs() / creditors.length;
          for (var creditor in creditors) {
            paymentSet.add(
                '$debtor needs to pay RM ${amountPerCreditor.toStringAsFixed(2)} to $creditor');
          }
        }
      }
    }

    // Build the display message
    List<String> displayMessages = paymentSet.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.green
            ], // Replace with your desired colors
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Payments Breakdown',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Divider(),
                        Text(
                          'Need to pay',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                      columnWidths: {
                        0: const FlexColumnWidth(3),
                        1: const FlexColumnWidth(2),
                        2: const FlexColumnWidth(2),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        for (var i = 0; i < displayMessages.length; i++)
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${i + 1}. ${displayMessages[i].split(' need')[0]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(displayMessages[i].split('pay ')[1]),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
