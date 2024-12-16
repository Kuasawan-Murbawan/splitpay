import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final List<Map<String, dynamic>> expenses;

  const ResultsPage({required this.expenses});

  @override
  Widget build(BuildContext context) {
    // Calculate the average amount paid by each person
    double totalPaidOverall = 0;
    for (var expense in expenses) {
      totalPaidOverall += expense['totalPaid'];
    }

    double averageAmount = totalPaidOverall / expenses.length;

    Set<String> paymentSet = {};
    Map<String, double> bayarLebih = {};
    Map<String, double> bayarKurang = {};

    for (var person in expenses) {
      String name = person['memberName'];
      double difference = person['totalPaid'] - averageAmount;
      (difference > 0 ? bayarLebih : bayarKurang)[name] = difference;
    }

    bayarLebih = Map.fromEntries(bayarLebih.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));
    bayarKurang = Map.fromEntries(bayarKurang.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value)));

    // Calculate payments
    for (var lebihEntry in bayarLebih.entries.toList()) {
      String lebihName = lebihEntry.key;
      double lebihAmount = lebihEntry.value;

      for (var kurangEntry in bayarKurang.entries.toList()) {
        String kurangName = kurangEntry.key;
        double kurangAmount = kurangEntry.value;

        double baki = lebihAmount + kurangAmount;

        if (baki > 0) {
          paymentSet.add(
              "$kurangName need to pay ${kurangAmount.abs().toStringAsFixed(2)} to $lebihName"); // the bayarKurang settle bayar hutang
          // the bayarLebih still ada lebih, so we need to update the lebihAmount
          lebihAmount = baki;
          // the bayarKurang sudah settle hutang, so we remove it from the list
          bayarKurang.remove(kurangName);
        } else if (baki < 0) {
          paymentSet.add(
              "$kurangName need to pay ${lebihAmount.toStringAsFixed(2)}  to $lebihName"); // the bayarLebih settle kutip hutang
          // the bayarKurang still have hutang, so we need to update the bayarKurang
          bayarKurang[kurangName] = baki;
          // the bayarLebih sudah settle kutip hutang, so we remove it from the list
          bayarLebih.remove(lebihName);
          break;
        } else {
          paymentSet.add(
              "$kurangName need to pay ${lebihAmount.toStringAsFixed(2)} to $lebihName"); // the bayarLebih settle kutip hutang
          // both bayarLebih and bayarKurang already settle hutang, so we remove both from the list
          bayarLebih.remove(lebihName);
          bayarKurang.remove(kurangName);
          break;
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
                const Padding(
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
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(2),
                        2: FlexColumnWidth(2),
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
