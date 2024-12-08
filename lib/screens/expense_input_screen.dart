import 'package:flutter/material.dart';
import 'graph_screen.dart';

class ExpenseInputScreen extends StatefulWidget {
  final String accountName;

  const ExpenseInputScreen({super.key, required this.accountName});

  @override
  State<ExpenseInputScreen> createState() => _ExpenseInputScreenState();
}

class _ExpenseInputScreenState extends State<ExpenseInputScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<Map<String, dynamic>> expenses = [];
  static Map<String, List<Map<String, dynamic>>> allAccountsExpenses = {};

  @override
  void initState() {
    super.initState();
    if (!allAccountsExpenses.containsKey(widget.accountName)) {
      allAccountsExpenses[widget.accountName] = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses for ${widget.accountName}"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: "Expense Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade400,
              ),
              onPressed: () {
                setState(() {
                  final expense = {
                    "description": descriptionController.text,
                    "amount": double.tryParse(amountController.text) ?? 0.0,
                  };
                  allAccountsExpenses[widget.accountName]?.add(expense);
                  descriptionController.clear();
                  amountController.clear();
                });
              },
              child: const Text("Add Expense"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: allAccountsExpenses[widget.accountName]?.length ?? 0,
                itemBuilder: (context, index) {
                  final expense = allAccountsExpenses[widget.accountName]![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      title: Text(expense["description"]),
                      trailing: Text("\$${expense["amount"]}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GraphScreen(allExpenses: allAccountsExpenses),
            ),
          );
        },
        child: const Icon(Icons.bar_chart),
      ),
    );
  }
}
