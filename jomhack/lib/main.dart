import 'package:flutter/material.dart';
import 'pages/expense_tracker_page.dart';
import 'pages/budget_page.dart';
import 'pages/wallet_page.dart';
import 'pages/settings_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/ask_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // Updated list of pages to include AskPage
  final List<Widget> _pages = [
    ExpenseTrackerPage(),
    BudgetPage(),
    WalletPage(),
    AskPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Ask',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Update the enum for Malaysian payment sources
enum TransactionSource {
  cimbDebit2664,
  grabPay,
  tngEwallet,
  maybank2u,
  cimbCredit1234,
  cash,
  boost
}

class Expense {
  final String title;
  final double amount;
  final DateTime date;
  final TransactionSource source;
  final String category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.source,
    required this.category,
  });
}
