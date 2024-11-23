import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({Key? key}) : super(key: key);

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage> {
  bool _isInvestmentEnabled = false;

  // Sample investment data
  final List<Investment> _investments = [
    Investment(
      name: 'Fixed Deposit',
      amount: 50000,
      returnRate: 2.95,
      institution: 'CIMB Bank',
      type: InvestmentType.fixedDeposit,
      lastUpdate: DateTime(2024, 1, 15),
    ),
    Investment(
      name: 'ASB',
      amount: 30000,
      returnRate: 4.1,
      institution: 'Amanah Saham Nasional',
      type: InvestmentType.unitTrust,
      lastUpdate: DateTime(2024, 1, 10),
    ),
    Investment(
      name: 'Public e-Growth Fund',
      amount: 15000,
      returnRate: 8.5,
      institution: 'Public Mutual',
      type: InvestmentType.unitTrust,
      lastUpdate: DateTime(2024, 1, 5),
    ),
    Investment(
      name: 'Maybank Shares',
      amount: 10000,
      returnRate: 6.2,
      institution: 'Bursa Malaysia',
      type: InvestmentType.stocks,
      lastUpdate: DateTime(2024, 1, 1),
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
              'Investments',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            Text(
              'January 2024',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
      body: _isInvestmentEnabled 
          ? SingleChildScrollView(
              child: Column(
                children: [
                  _buildPortfolioSummary(),
                  _buildInvestmentCategories(),
                  _buildInvestmentsList(),
                  _buildGoalBasedRecommendations(),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Investment Tracking',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Track your investments and get insights\non your portfolio performance',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isInvestmentEnabled = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3192),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Enable Investment Tracking',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildPortfolioSummary() {
    double totalInvestment = _investments.fold(0, (sum, item) => sum + item.amount);
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Portfolio Value',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'RM ${totalInvestment.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPortfolioStat('Fixed Deposit', '35%', Colors.blue),
              _buildPortfolioStat('Unit Trust', '45%', Colors.green),
              _buildPortfolioStat('Stocks', '20%', Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _investments.length,
        itemBuilder: (context, index) {
          final investment = _investments[index];
          return _buildInvestmentItem(investment);
        },
      ),
    );
  }

  Widget _buildInvestmentItem(Investment investment) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getInvestmentColor(investment.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getInvestmentIcon(investment.type),
              color: _getInvestmentColor(investment.type),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  investment.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  investment.institution,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'RM ${investment.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${investment.returnRate}% p.a.',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalBasedRecommendations() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recommended for You',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildRecommendationCard(
            'Retirement Planning',
            'Based on your profile, consider Public Mutual\'s e-Growth Fund for long-term growth.',
            Icons.account_balance,
            const Color(0xFF6B4EFF),
          ),
          const SizedBox(height: 12),
          _buildRecommendationCard(
            'Emergency Fund',
            'Build 6 months of expenses (RM30,000) through Fixed Deposit.',
            Icons.savings,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildRecommendationCard(
            'High Growth Potential',
            'Explore ETFs for diversified market exposure with moderate risk.',
            Icons.trending_up,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getInvestmentColor(InvestmentType type) {
    switch (type) {
      case InvestmentType.fixedDeposit:
        return Colors.blue;
      case InvestmentType.unitTrust:
        return Colors.green;
      case InvestmentType.stocks:
        return Colors.orange;
    }
  }

  IconData _getInvestmentIcon(InvestmentType type) {
    switch (type) {
      case InvestmentType.fixedDeposit:
        return Icons.account_balance;
      case InvestmentType.unitTrust:
        return Icons.pie_chart;
      case InvestmentType.stocks:
        return Icons.show_chart;
    }
  }

  Widget _buildInvestmentCategories() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 130,
      child: Row(
        children: [
          Expanded(
            child: _buildCategoryCard(
              'Fixed\nDeposit',
              Icons.account_balance,
              Colors.blue,
              () => _showFDRates(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCategoryCard(
              'Unit\nTrust',
              Icons.pie_chart,
              Colors.green,
              () => _showUnitTrustFunds(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildCategoryCard(
              'Stocks',
              Icons.show_chart,
              Colors.orange,
              () => _showStockMarket(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFDRates(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Fixed Deposit Rates',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildFDRateCard('CIMB Bank', '3.40%', '3.50%', '3.70%'),
                    _buildFDRateCard('Maybank', '3.30%', '3.45%', '3.65%'),
                    _buildFDRateCard('Public Bank', '3.35%', '3.55%', '3.75%'),
                    _buildFDRateCard('Hong Leong Bank', '3.45%', '3.60%', '3.80%'),
                    _buildFDRateCard('RHB Bank', '3.35%', '3.50%', '3.70%'),
                    _buildFDRateCard('AmBank', '3.40%', '3.55%', '3.75%'),
                    _buildFDRateCard('Bank Islam', '3.30%', '3.45%', '3.65%'),
                    _buildFDRateCard('Alliance Bank', '3.45%', '3.60%', '3.80%'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFDRateCard(
    String bankName,
    String rate3Month,
    String rate6Month,
    String rate12Month,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bankName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRateColumn('3 Months', rate3Month),
              _buildRateColumn('6 Months', rate6Month),
              _buildRateColumn('12 Months', rate12Month),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRateColumn(String duration, String rate) {
    return Column(
      children: [
        Text(
          duration,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          rate,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  void _showUnitTrustFunds(BuildContext context) {
    // Implement unit trust funds bottom sheet
    // Similar structure to FD rates but with fund information
  }

  void _showStockMarket(BuildContext context) {
    // Implement stock market bottom sheet
    // Similar structure to FD rates but with stock information
  }
}

class Investment {
  final String name;
  final double amount;
  final double returnRate;
  final String institution;
  final InvestmentType type;
  final DateTime lastUpdate;

  Investment({
    required this.name,
    required this.amount,
    required this.returnRate,
    required this.institution,
    required this.type,
    required this.lastUpdate,
  });
}

enum InvestmentType {
  fixedDeposit,
  unitTrust,
  stocks,
}
