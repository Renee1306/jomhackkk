import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerPage extends StatefulWidget {
  const ExpenseTrackerPage({Key? key}) : super(key: key);

  @override
  State<ExpenseTrackerPage> createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  int _currentCardIndex = 0;
  final PageController _pageController = PageController();
  bool _isAmountVisible = true;

  // Sample card data
  final List<BankCard> _cards = [
    // First card is Maybank
    BankCard(
      name: 'Renee Nyong',
      bankName: 'Maybank',
      accountNumber: 'XXX5787',
      balance: 1100,
      income: 50000,
      expense: 20100,
      color: const Color(0xFF1E2B47),
      minimumBalance: 1000,
      transactions: [
        Transaction(
          title: 'Salary',
          amount: 50000,
          date: DateTime(2023, 6, 5, 9, 00),
          icon: Icons.account_balance_wallet,
          type: TransactionType.income,
        ),
        Transaction(
          title: 'Housing',
          amount: 1200,
          date: DateTime(2023, 6, 11, 10, 11),
          icon: Icons.home,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Insurance',
          amount: 450,
          date: DateTime(2023, 6, 6, 21, 30),
          icon: Icons.security,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Investment',
          amount: 18000,
          date: DateTime(2023, 6, 2, 0, 4),
          icon: Icons.attach_money,
          type: TransactionType.expense,
        ),
      ],
    ),
    // Second card is Touch n Go
    BankCard(
      name: 'Renee Nyong',
      bankName: 'Touch n Go eWallet',
      accountNumber: 'XXX8823',
      balance: 450.60,
      income: 500,
      expense: 2000.40,
      color: const Color(0xFF1E88E5),
      minimumBalance: 50.00,
      transactions: [
        Transaction(
          title: 'Tealive',
          amount: 15.90,
          date: DateTime(2023, 6, 11, 16, 30),
          icon: Icons.local_drink,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Parking KLCC',
          amount: 12.00,
          date: DateTime(2023, 6, 11, 14, 00),
          icon: Icons.local_parking,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Top Up',
          amount: 500,
          date: DateTime(2023, 6, 10, 09, 30),
          icon: Icons.account_balance_wallet,
          type: TransactionType.income,
        ),
        Transaction(
          title: 'Toll LDP',
          amount: 21.50,
          date: DateTime(2023, 6, 9, 18, 45),
          icon: Icons.toll,
          type: TransactionType.expense,
        ),
      ],
    ),
    // CIMB Credit Card
    BankCard(
      name: 'Renee Nyong',
      bankName: 'CIMB Credit Card',
      accountNumber: 'XXXX XXXX XXXX 3344',
      balance: -2150.80,
      income: 0,
      expense: 2150.80,
      color: const Color(0xFFD31145),
      creditLimit: 2500.00,
      transactions: [
        Transaction(
          title: 'Uniqlo',
          amount: 299.90,
          date: DateTime(2023, 6, 11, 15, 20),
          icon: Icons.shopping_bag,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Watson',
          amount: 150.90,
          date: DateTime(2023, 6, 10, 14, 30),
          icon: Icons.local_pharmacy,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Shopee',
          amount: 1700.00,
          date: DateTime(2023, 6, 8, 21, 15),
          icon: Icons.shopping_cart,
          type: TransactionType.expense,
        ),
      ],
    ),
    // GrabPay Wallet
    BankCard(
      name: 'Renee Nyong',
      bankName: 'GrabPay',
      accountNumber: 'XXX9977',
      balance: 25.30,
      income: 200,
      expense: 174.70,
      color: const Color(0xFF00B14F),
      creditLimit: 200.00,
      transactions: [
        Transaction(
          title: 'GrabFood - McD',
          amount: 25.90,
          date: DateTime(2023, 6, 11, 19, 30),
          icon: Icons.fastfood,
          type: TransactionType.expense,
        ),
        Transaction(
          title: 'Top Up',
          amount: 200,
          date: DateTime(2023, 6, 9, 10, 00),
          icon: Icons.account_balance_wallet,
          type: TransactionType.income,
        ),
        Transaction(
          title: 'GrabCar',
          amount: 48.80,
          date: DateTime(2023, 6, 8, 09, 15),
          icon: Icons.local_taxi,
          type: TransactionType.expense,
        ),
      ],
    ),
  ];

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
              'Expenses',
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentCardIndex = index;
                });
              },
              children: [
                _buildTotalCard(),
                ..._cards.map((card) => _buildBankCard(card)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _cards.length + 1,
              (index) => _buildDotIndicator(index),
            ),
          ),
          _buildIncomeExpenseRow(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    '01 Jun - 11 Jun',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: _currentCardIndex == _cards.length
                    ? _getAllTransactions().length
                    : _cards[_currentCardIndex].transactions.length,
                itemBuilder: (context, index) {
                  final transactions = _currentCardIndex == _cards.length
                      ? _getAllTransactions()
                      : _cards[_currentCardIndex].transactions;
                  return _buildTransactionItem(transactions[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankCard(BankCard card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      height: 250,
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.bankName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card.accountNumber,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isAmountVisible = !_isAmountVisible;
                  });
                },
                child: Icon(
                  _isAmountVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            'Balance',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isAmountVisible ? 'RM ${card.balance.toStringAsFixed(2)}' : 'RM ****',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (card.alert != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.amber,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      card.alert!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentCardIndex == index 
            ? const Color(0xFF2196F3)
            : Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget _buildTotalCard() {
    double totalBalance = _cards.fold(0, (sum, card) => sum + card.balance);
    double totalIncome = _cards.fold(0, (sum, card) => sum + card.income);
    double totalExpense = _cards.fold(0, (sum, card) => sum + card.expense);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)], // Modern blue gradient
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2196F3).withOpacity(0.3),
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
                      _isAmountVisible 
                          ? 'RM ${totalBalance.toStringAsFixed(2)}'
                          : 'RM ××××.××',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isAmountVisible = !_isAmountVisible;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _isAmountVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'Income: RM ${totalIncome.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Expense: RM ${totalExpense.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeExpenseRow() {
    // Get the current card or total values
    double income = 0;
    double expense = 0;

    if (_currentCardIndex == 0) {
      // For total card
      for (var card in _cards) {
        income += card.income;
        expense += card.expense;
      }
    } else {
      // For individual cards
      final card = _cards[_currentCardIndex - 1];
      income = card.income;
      expense = card.expense;
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Income',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'RM ${income.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: Colors.grey.withOpacity(0.2),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Expense',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'RM ${expense.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    final bool isExpense = transaction.type == TransactionType.expense;
    final String sign = isExpense ? '-' : '+';
    final Color amountColor = isExpense ? Colors.red : Colors.green;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(transaction.icon),
      ),
      title: Text(transaction.title),
      subtitle: Text(
        DateFormat('dd MMM yyyy, HH:mm').format(transaction.date),
      ),
      trailing: Text(
        '$sign RM ${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Transaction> _getAllTransactions() {
    List<Transaction> allTransactions = [];
    for (var card in _cards) {
      allTransactions.addAll(card.transactions);
    }
    allTransactions.sort((a, b) => b.date.compareTo(a.date));
    return allTransactions;
  }
}

class BankCard {
  final String name;
  final String bankName;
  final String accountNumber;
  final double balance;
  final double income;
  final double expense;
  final Color color;
  final List<Transaction> transactions;
  final double? creditLimit;  // Add credit limit field
  final double? minimumBalance;  // Add minimum balance field

  BankCard({
    required this.name,
    required this.bankName,
    required this.accountNumber,
    required this.balance,
    required this.income,
    required this.expense,
    required this.color,
    required this.transactions,
    this.creditLimit,
    this.minimumBalance,
  });

  String? get alert {
    if (creditLimit != null) {
      double usagePercentage = (expense / creditLimit!) * 100;
      if (usagePercentage >= 80) {
        return "You've reached ${usagePercentage.toStringAsFixed(0)}% of your credit limit";
      }
    }
    if (bankName.contains('Touch n Go') || bankName.contains('GrabPay')) {
      double spendingPercentage = (expense / (balance + expense)) * 100;
      if (spendingPercentage >= 80) {
        return "You've spent ${spendingPercentage.toStringAsFixed(0)}% of your loaded amount";
      }
    }
    return null;
  }
}

class Transaction {
  final String title;
  final double amount;
  final DateTime date;
  final IconData icon;
  final TransactionType type;

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.icon,
    required this.type,
  });
}

enum TransactionType { income, expense } 