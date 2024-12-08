import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  final List<String> accounts;
  final Function(String account, Map<String, dynamic> expense) onAddExpense;

  const AddExpenseScreen({super.key, required this.accounts, required this.onAddExpense});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedAccount;
  String _description = "";
  double _amount = 0.0;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onAddExpense(
        _selectedAccount!,
        {
          "description": _description,
          "amount": _amount,
          "date": DateTime.now(),
        },
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedAccount,
                onChanged: (value) {
                  setState(() {
                    _selectedAccount = value;
                  });
                },
                items: widget.accounts
                    .map((account) => DropdownMenuItem(
                          value: account,
                          child: Text(account),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: "Account"),
                validator: (value) =>
                    value == null ? "Please select an account" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) =>
                    value!.isEmpty ? "Please enter a description" : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amount = double.parse(value!);
                },
                validator: (value) =>
                    value!.isEmpty ? "Please enter an amount" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Add Expense"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
