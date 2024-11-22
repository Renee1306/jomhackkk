import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerPage extends StatefulWidget {
  const ExpenseTrackerPage({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerPage> createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Month';
  String _selectedCategory = 'All';

  final List<String> _periods = ['Today', 'This Week', 'This Month', 'This Year'];
  final List<String> _categories = [
    'All',
    'Food & Drinks',
    'Transportation',
    'Shopping',
    'Bills',
    'Entertainment',
    'Groceries',
    'Health',
    'Others'
  ];

  final List<Expense> _expenses = [
    Expense(
      title: 'Tesco Groceries',
      amount: 285.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      source: TransactionSource.cimbDebit2664,
      category: 'Groceries',
      icon: Icons.shopping_cart,
      color: Colors.green,
    ),
    Expense(
      title: 'Netflix Subscription',
      amount: 54.90,
      date: DateTime.now().subtract(const Duration(days: 2)),
      source: TransactionSource.cimbCredit1234,
      category: 'Entertainment',
      icon: Icons.movie,
      color: Colors.red,
    ),
    Expense(
      title: 'Grab Ride',
      amount: 25.80,
      date: DateTime.now().subtract(const Duration(days: 2)),
      source: TransactionSource.grabPay,
      category: 'Transportation',
      icon: Icons.directions_car,
      color: Colors.blue,
    ),
    // Add more sample expenses as needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double get totalSpending {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Spending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'RM ${totalSpending.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Transactions'),
                  Tab(text: 'Analytics'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTransactionsTab(),
            _buildAnalyticsTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExpenseDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTransactionsTab() {
    return Column(
      children: [
        _buildFilters(),
        Expanded(
          child: ListView.builder(
            itemCount: _expenses.length,
            itemBuilder: (context, index) {
              return _buildExpenseCard(_expenses[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: _selectedPeriod,
              isExpanded: true,
              items: _periods.map((String period) {
                return DropdownMenuItem<String>(
                  value: period,
                  child: Text(period),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPeriod = newValue!;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(Expense expense) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: expense.color.withOpacity(0.2),
          child: Icon(expense.icon, color: expense.color),
        ),
        title: Text(expense.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMM dd, yyyy').format(expense.date),
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              _getSourceName(expense.source),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: Text(
          'RM ${expense.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return const Center(
      child: Text('Analytics Coming Soon!'),
    );
  }

  void _showAddExpenseDialog() {
    // Implement add expense dialog
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AddExpenseForm();
      },
    );
  }

  String _getSourceName(TransactionSource source) {
    switch (source) {
      case TransactionSource.cimbDebit2664:
        return 'CIMB Debit *2664';
      case TransactionSource.cimbCredit1234:
        return 'CIMB Credit *1234';
      case TransactionSource.grabPay:
        return 'GrabPay';
      case TransactionSource.tngEwallet:
        return 'TNG eWallet';
      default:
        return 'Unknown Source';
    }
  }
}

// Add Expense Form Widget
class AddExpenseForm extends StatefulWidget {
  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
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
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Expense Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (RM)',
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
                  // Add expense logic here
                  Navigator.pop(context);
                }
              },
              child: const Text('Add Expense'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Enums and Classes
enum TransactionSource {
  cimbDebit2664,
  cimbCredit1234,
  grabPay,
  tngEwallet,
}

class Expense {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionSource source;
  final String category;
  final IconData icon;
  final Color color;

  const Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
    required this.category,
    required this.icon,
    required this.color,
  });
} 