import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wallets'),
      ),
      body: ListView(
        children: [
          // Bank Accounts Section
          _buildSectionHeader('Bank Accounts'),
          _buildAccountCard(
            'CIMB Debit *2664',
            'RM 5,280.50',
            Icons.credit_card,
            Colors.red,
          ),
          _buildAccountCard(
            'Maybank2u',
            'RM 3,150.75',
            Icons.account_balance,
            Colors.amber,
          ),

          // Credit Cards Section
          _buildSectionHeader('Credit Cards'),
          _buildAccountCard(
            'CIMB Credit *1234',
            'RM 2,540.80',
            Icons.credit_card,
            Colors.red,
          ),

          // E-Wallets Section
          _buildSectionHeader('E-Wallets'),
          _buildAccountCard(
            'GrabPay',
            'RM 85.50',
            Icons.delivery_dining,
            Colors.green,
          ),
          _buildAccountCard(
            'TNG eWallet',
            'RM 125.30',
            Icons.toll,
            Colors.blue,
          ),
          _buildAccountCard(
            'Boost',
            'RM 50.00',
            Icons.rocket_launch,
            Colors.orange,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new wallet/account
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAccountCard(String name, String balance, IconData icon, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(name),
        trailing: Text(
          balance,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
} 