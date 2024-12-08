import 'package:flutter/material.dart';
import 'expense_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> accounts = const [
    {"name": "Aishwarya"},
    {"name": "Ishwarya"},
    {"name": "Vaishnavi"},
    {"name": "Yashaswiny"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select an Account"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards in each row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3, // Adjusts the height of the cards
          ),
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseInputScreen(accountName: account["name"]),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                color: Colors.primaries[index % Colors.primaries.length].shade200,
                child: Center(
                  child: Text(
                    account["name"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
