import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wallet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            Text(
              'June 2024',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1E1E1E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Bank Accounts'),
          const SizedBox(height: 16),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'CIMB Bank',
            accountNumber: '7010 XXXX XXXX 2664',
            balance: '28,981.50',
            income: '50,000.00',
            expense: '21,899.00',
            color: const Color(0xFF1E3D3B),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E3D3B), Color(0xFF2A5A57)],
            ),
          ),
          const SizedBox(height: 12),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'Maybank',
            accountNumber: '5144 XXXX XXXX 5787',
            balance: '9,999.00',
            income: '9,999.00',
            expense: '0.00',
            color: const Color(0xFF1E2B47), // Maybank dark blue
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E2B47), Color(0xFF2A4767)],
            ),
          ),
          const SizedBox(height: 12),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'Bank Islam',
            accountNumber: '8299 XXXX XXXX 1234',
            balance: '15,750.00',
            income: '20,000.00',
            expense: '4,250.00',
            color: const Color(0xFF0F4C3A), // Bank Islam green
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0F4C3A), Color(0xFF1A5A47)],
            ),
          ),

          // Credit Cards Section
          const SizedBox(height: 24),
          _buildSectionTitle('Credit Cards'),
          const SizedBox(height: 12),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'CIMB Credit Card',
            accountNumber: '5521 XXXX XXXX 1234',
            balance: '3,250.00',
            income: '10,000.00',
            expense: '6,750.00',
            color: const Color(0xFF8B0000), // Dark red for credit card
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8B0000), Color(0xFF9B0000)],
            ),
          ),

          // E-Wallets Section
          const SizedBox(height: 24),
          _buildSectionTitle('E-Wallets'),
          const SizedBox(height: 12),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'Touch n Go eWallet',
            accountNumber: 'XXX XXXX 5678',
            balance: '450.00',
            income: '500.00',
            expense: '50.00',
            color: const Color(0xFF1E88E5), // TnG blue
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E88E5), Color(0xFF2A96F3)],
            ),
          ),
          const SizedBox(height: 12),
          _buildAccountCard(
            name: 'Renee Nyong',
            bankName: 'GrabPay',
            accountNumber: 'XXX XXXX 9012',
            balance: '280.00',
            income: '300.00',
            expense: '20.00',
            color: const Color(0xFF00B14F), // Grab green
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00B14F), Color(0xFF00D16F)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountCard({
    required String name,
    required String bankName,
    required String accountNumber,
    required String balance,
    required String income,
    required String expense,
    required Color color,
    required Gradient gradient,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankName,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'RM $balance',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.copy,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              accountNumber,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTransactionInfo('Income', income, Colors.greenAccent),
                _buildTransactionInfo('Expense', expense, Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionInfo(String title, String amount, Color amountColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'RM $amount',
          style: TextStyle(
            color: amountColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 