import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart'; // Add this package to pubspec.yaml

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // Sample budget data
  final List<BudgetCategory> _budgets = [
    BudgetCategory(
      name: 'Groceries',
      budgetAmount: 800.0,
      spentAmount: 650.0,
      icon: Icons.shopping_cart,
      color: Colors.green,
    ),
    BudgetCategory(
      name: 'Dining',
      budgetAmount: 500.0,
      spentAmount: 480.0,
      icon: Icons.restaurant,
      color: Colors.orange,
    ),
    BudgetCategory(
      name: 'Entertainment',
      budgetAmount: 300.0,
      spentAmount: 150.0,
      icon: Icons.movie,
      color: Colors.purple,
    ),
    BudgetCategory(
      name: 'Transportation',
      budgetAmount: 400.0,
      spentAmount: 280.0,
      icon: Icons.directions_car,
      color: Colors.blue,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Budget'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddBudgetDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBudgetSummary(),
            _buildBudgetList(),
            _buildForecastCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetSummary() {
    double totalBudget = _budgets.fold(0, (sum, item) => sum + item.budgetAmount);
    double totalSpent = _budgets.fold(0, (sum, item) => sum + item.spentAmount);
    double remainingBudget = totalBudget - totalSpent;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Monthly Budget Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Total Budget',
                  totalBudget,
                  Colors.blue,
                ),
                _buildSummaryItem(
                  'Spent',
                  totalSpent,
                  Colors.red,
                ),
                _buildSummaryItem(
                  'Remaining',
                  remainingBudget,
                  Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: totalSpent / totalBudget,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                totalSpent / totalBudget > 0.9 ? Colors.red : Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, double amount, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'RM ${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _budgets.length,
      itemBuilder: (context, index) {
        return _buildBudgetCard(_budgets[index]);
      },
    );
  }

  Widget _buildBudgetCard(BudgetCategory budget) {
    double percentage = budget.spentAmount / budget.budgetAmount;
    bool isOverBudget = percentage > 0.9;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(budget.icon, color: budget.color),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'RM ${budget.spentAmount.toStringAsFixed(2)} / RM ${budget.budgetAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${(percentage * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: isOverBudget ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? Colors.red : budget.color,
              ),
            ),
            if (isOverBudget)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Warning: Near or over budget!',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Spending Forecast',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Add your forecast chart here
            const Text(
              'Based on your current spending pattern:',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            _buildForecastItem(
              'Groceries',
              'Likely to exceed by RM 50',
              Icons.warning,
              Colors.orange,
            ),
            _buildForecastItem(
              'Entertainment',
              'On track to meet budget',
              Icons.check_circle,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(
    String category,
    String message,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            category,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(message),
        ],
      ),
    );
  }

  void _showAddBudgetDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddBudgetForm(
          onSubmit: (category, amount) {
            setState(() {
              _budgets.add(BudgetCategory(
                name: category,
                budgetAmount: amount,
                spentAmount: 0,
                icon: Icons.category,
                color: Colors.blue,
              ));
            });
          },
        );
      },
    );
  }
}

class BudgetCategory {
  final String name;
  final double budgetAmount;
  final double spentAmount;
  final IconData icon;
  final Color color;

  BudgetCategory({
    required this.name,
    required this.budgetAmount,
    required this.spentAmount,
    required this.icon,
    required this.color,
  });
}

class AddBudgetForm extends StatefulWidget {
  final Function(String category, double amount) onSubmit;

  const AddBudgetForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddBudgetFormState createState() => _AddBudgetFormState();
}

class _AddBudgetFormState extends State<AddBudgetForm> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a category name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Budget Amount (RM)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _categoryController.text,
                    double.parse(_amountController.text),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Budget Category'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}