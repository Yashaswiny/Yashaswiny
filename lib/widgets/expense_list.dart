import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Map<String, dynamic>> accounts;

  const ExpenseList({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        final account = accounts[index];
        double totalExpenses = account["expenses"]
            .fold(0.0, (sum, expense) => sum + expense["amount"]);

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              account["name"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Total Expenses: \$${totalExpenses.toStringAsFixed(2)}",
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () {
              // Navigate to account details (future feature)
            },
          ),
        );
      },
    );
  }
}
