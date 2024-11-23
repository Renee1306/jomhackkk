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

  // Add this list
  final List<BillPayment> _billPayments = [
    // Maybank bills
    BillPayment(
      title: 'House Loan',
      amount: 2500.00,
      dueDate: DateTime(2024, 6, 15),
      icon: Icons.house,
      color: const Color(0xFF1E2B47),
      frequency: 'Monthly',
      cardType: 'Maybank',
    ),
    BillPayment(
      title: 'Car Loan',
      amount: 1200.00,
      dueDate: DateTime(2024, 6, 20),
      icon: Icons.directions_car,
      color: const Color(0xFF1E2B47),
      frequency: 'Monthly',
      cardType: 'Maybank',
    ),

    // CIMB bills
    BillPayment(
      title: 'Netflix Premium',
      amount: 54.90,
      dueDate: DateTime(2024, 6, 15),
      icon: Icons.movie_outlined,
      color: const Color(0xFFD31145),
      frequency: 'Monthly',
      cardType: 'CIMB Credit Card',
    ),
    BillPayment(
      title: 'Spotify Family',
      amount: 23.90,
      dueDate: DateTime(2024, 6, 18),
      icon: Icons.music_note,
      color: const Color(0xFFD31145),
      frequency: 'Monthly',
      cardType: 'CIMB Credit Card',
    ),
    BillPayment(
      title: 'iCloud Storage',
      amount: 12.90,
      dueDate: DateTime(2024, 6, 20),
      icon: Icons.cloud_outlined,
      color: const Color(0xFFD31145),
      frequency: 'Monthly',
      cardType: 'CIMB Credit Card',
    ),

    // Touch n Go bills
    BillPayment(
      title: 'Touch n Go RFID',
      amount: 100.00,
      dueDate: DateTime(2024, 6, 25),
      icon: Icons.contactless,
      color: const Color(0xFF1E88E5),
      frequency: 'Monthly',
      cardType: 'Touch n Go eWallet',
    ),
  ];

  // Add this method to get bills for specific card
  List<BillPayment> _getBillsForCard(String cardType) {
    return _billPayments.where((bill) => bill.cardType == cardType).toList();
  }

  // Add this method to build bill section
  Widget _buildUpcomingBills(String cardType) {
    final bills = cardType.isEmpty ? _billPayments : _getBillsForCard(cardType);
    if (bills.isEmpty) return const SizedBox.shrink();

    double totalMonthlyBills = bills.fold(0.0, (sum, bill) => sum + bill.amount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upcoming Bill Payments',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              Text(
                'RM ${totalMonthlyBills.toStringAsFixed(2)}/month',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 130, // Increased height
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: bills.length,
            itemBuilder: (context, index) {
              final bill = bills[index];
              return Container(
                width: 150, // Increased width
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          bill.frequency,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (cardType.isEmpty) // Only show bank indicator in total view
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: bill.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getBankInitial(bill.cardType),
                              style: TextStyle(
                                color: bill.color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: bill.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            bill.icon,
                            color: bill.color,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            bill.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'RM ${bill.amount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          DateFormat('dd MMM').format(bill.dueDate),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

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
      body: SingleChildScrollView(
        child: Column(
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
            _currentCardIndex == 0
                ? _buildUpcomingBills('')
                : _buildUpcomingBills(_cards[_currentCardIndex - 1].bankName),
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Recent Transactions',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                  ),
                  Container(
                    height: 620, // Adjust this height as needed
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _getAllTransactions().length,
                      itemBuilder: (context, index) {
                        final transaction = _getAllTransactions()[index];
                        return Column(
                          children: [
                            _buildTransactionItem(transaction),
                            if (index < _getAllTransactions().length - 1)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  height: 1,
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
    double totalIncome = 0;
    double totalExpense = 0;
    double totalBalance = 0;

    // Calculate totals
    for (var card in _cards) {
      totalIncome += card.income;
      totalExpense += card.expense;
    }
    
    // Set total balance as income minus expense
    totalBalance = totalIncome - totalExpense;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
      ),
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
                    'RM ${totalBalance.toStringAsFixed(2)}',  // This will now be positive
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
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
          const SizedBox(height: 20),
          Text(
            'Income: RM ${totalIncome.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Expense: RM ${totalExpense.toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpenseRow() {
    // Get the current card or total values
    double income = 0;
    double expense = 0;
    double balance = 0;

    if (_currentCardIndex == 0) {
      // For total card - calculate total from all cards
      for (var card in _cards) {
        income += card.income;
        expense += card.expense;
        balance += card.balance;
      }
      // Make balance positive for total view
      balance = income - expense; // This will show positive balance
    } else {
      // For individual cards - keep original balance
      final card = _cards[_currentCardIndex - 1];
      income = card.income;
      expense = card.expense;
      balance = card.balance;
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          transaction.icon,
          size: 20,
          color: Colors.grey[800],
        ),
      ),
      title: Text(
        transaction.title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy, HH:mm').format(transaction.date),
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 13,
        ),
      ),
      trailing: Text(
        '$sign RM ${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: amountColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
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

  String _getBankInitial(String bankName) {
    if (bankName.contains('Maybank')) return 'M';
    if (bankName.contains('Touch n Go')) return 'T';
    if (bankName.contains('CIMB')) return 'C';
    if (bankName.contains('GrabPay')) return 'G';
    return '';
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

// Add this class
class BillPayment {
  final String title;
  final double amount;
  final DateTime dueDate;
  final IconData icon;
  final Color color;
  final String frequency;
  final String cardType; // To identify which card this bill belongs to

  BillPayment({
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.icon,
    required this.color,
    required this.frequency,
    required this.cardType,
  });
} 