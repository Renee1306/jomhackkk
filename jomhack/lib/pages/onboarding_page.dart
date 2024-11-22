import 'package:flutter/material.dart';
import '../main.dart';
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}
class _OnboardingPageState extends State<OnboardingPage> {
  final List<BankAccount> _selectedAccounts = [];
  
  // Separate lists for banks and e-wallets
  final List<Bank> malaysianBanks = [
    Bank(
      name: 'CIMB Bank',
      logo: 'assets/cimb_logo.png',
      website: 'www.cimb.com.my',
      iconData: Icons.account_balance,
      color: Colors.red,
      type: 'Bank',
    ),
    Bank(
      name: 'Maybank',
      logo: 'assets/maybank_logo.png',
      website: 'www.maybank2u.com.my',
      iconData: Icons.account_balance,
      color: Colors.amber,
      type: 'Bank',
    ),
    Bank(
      name: 'Bank Islam',
      logo: 'assets/bankislam_logo.png',
      website: 'www.bankislam.com.my',
      iconData: Icons.account_balance,
      color: Colors.green,
      type: 'Bank',
    ),
    Bank(
      name: 'Bank Negara Malaysia',
      logo: 'assets/bnm_logo.png',
      website: 'www.bnm.gov.my',
      iconData: Icons.account_balance,
      color: Colors.blue,
      type: 'Bank',
    ),
    Bank(
      name: 'OCBC Bank',
      logo: 'assets/ocbc_logo.png',
      website: 'www.ocbc.com.my',
      iconData: Icons.account_balance,
      color: Colors.red.shade800,
      type: 'Bank',
    ),
  ];
  final List<Bank> malaysianEwallets = [
    Bank(
      name: 'Touch n Go eWallet',
      logo: 'assets/tng_logo.png',
      website: 'www.tngdigital.com.my',
      iconData: Icons.account_balance_wallet,
      color: Colors.blue,
      type: 'E-Wallet',
    ),
    Bank(
      name: 'GrabPay',
      logo: 'assets/grab_logo.png',
      website: 'www.grab.com/my',
      iconData: Icons.payment,
      color: Colors.green,
      type: 'E-Wallet',
    ),
    Bank(
      name: 'Boost',
      logo: 'assets/boost_logo.png',
      website: 'www.myboost.com.my',
      iconData: Icons.rocket_launch,
      color: Colors.orange,
      type: 'E-Wallet',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF666666),
                ),
              ),
              const Text(
                'Savy',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E1E),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Connect your bank accounts and e-wallets to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2196F3),
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('Banks', Icons.account_balance),
              const SizedBox(height: 16),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: malaysianBanks.length,
                  itemBuilder: (context, index) {
                    return _buildBankItem(malaysianBanks[index]);
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('E-Wallets', Icons.account_balance_wallet),
              const SizedBox(height: 16),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: malaysianEwallets.length,
                  itemBuilder: (context, index) {
                    return _buildBankItem(malaysianEwallets[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _selectedAccounts.isNotEmpty
              ? () => _showAuthenticationFlow(context)
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2196F3),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            'Connect Selected ${_selectedAccounts.length} ${_selectedAccounts.length == 1 ? 'Account' : 'Accounts'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
               color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2196F3).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF2196F3),
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ],
    );
  }
  Widget _buildBankItem(Bank bank) {
    bool isSelected = _selectedAccounts.any((account) => account.bank == bank);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedAccounts.removeWhere((account) => account.bank == bank);
              } else {
                _selectedAccounts.add(BankAccount(bank: bank));
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: bank.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    bank.logo,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(bank.iconData, color: bank.color);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bank.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bank.website,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF2196F3) : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showAuthenticationFlow(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BankAuthenticationFlow(
        bank: _selectedAccounts.first.bank,
        onComplete: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainNavigationPage()),
          );
        },
      ),
    );
  }
}
class BankAuthenticationFlow extends StatefulWidget {
  final Bank bank;
  final VoidCallback? onComplete;

  const BankAuthenticationFlow({
    Key? key,
    required this.bank,
    this.onComplete,
  }) : super(key: key);

  @override
  State<BankAuthenticationFlow> createState() => _BankAuthenticationFlowState();
}

class _BankAuthenticationFlowState extends State<BankAuthenticationFlow> {
  int _currentStep = 0;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> _availableAccounts = [
    'Savings Account - 1234',
    'Current Account - 5678',
    'Credit Card - 9012',
  ];
  final List<String> _selectedAccounts = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: _buildCurrentStep(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            'Connect ${widget.bank.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildLoginStep();
      case 1:
        return _buildAccountSelectionStep();
      case 2:
        return _buildAuthorizationStep();
      default:
        return _buildLoginStep();
    }
  }

  Widget _buildLoginStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          // Bank Logo
          Center(
            child: Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.bank.color.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.bank.color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Image.asset(
                widget.bank.logo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    widget.bank.iconData,
                    size: 48,
                    color: widget.bank.color,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Bank Name
          Text(
            widget.bank.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please enter your ${widget.bank.name} credentials',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          // Username field
          TextField(
            controller: _usernameController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(
                Icons.person_outline,
                color: widget.bank.color,
              ),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: widget.bank.color),
              ),
              labelStyle: TextStyle(color: Colors.grey[600]),
              floatingLabelStyle: TextStyle(color: widget.bank.color),
            ),
          ),
          const SizedBox(height: 16),
          // Password field
          TextField(
            controller: _passwordController,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: widget.bank.color,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.visibility_off_outlined),
                onPressed: () {
                  // Toggle password visibility
                  setState(() {
                    // Add password visibility toggle logic
                  });
                },
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: const Color(0xFFF7F9FC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: widget.bank.color),
              ),
              labelStyle: TextStyle(color: Colors.grey[600]),
              floatingLabelStyle: TextStyle(color: widget.bank.color),
            ),
          ),
          const SizedBox(height: 24),
          // Forgot Password
          Center(
            child: TextButton(
              onPressed: () {
                // Handle forgot password
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: widget.bank.color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Login button
          ElevatedButton(
            onPressed: () {
              if (_usernameController.text.isNotEmpty && 
                  _passwordController.text.isNotEmpty) {
                setState(() {
                  _currentStep = 1;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.bank.color,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Terms and Privacy
          Text(
            'By continuing, you agree to our Terms of Service and Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        // Bank Logo (smaller version)
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: widget.bank.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                widget.bank.logo,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    widget.bank.iconData,
                    size: 24,
                    color: widget.bank.color,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Select accounts to connect',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Account List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _availableAccounts.length,
          itemBuilder: (context, index) {
            final account = _availableAccounts[index];
            bool isSelected = _selectedAccounts.contains(account);
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? widget.bank.color : Colors.grey[200]!,
                  width: 1,
                ),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: widget.bank.color.withOpacity(0.1),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedAccounts.remove(account);
                      } else {
                        _selectedAccounts.add(account);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Account Type Icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: widget.bank.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getAccountIcon(account),
                            color: widget.bank.color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Account Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                account.split(' - ')[0],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E1E1E),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '****${account.split(' - ')[1]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Checkbox
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? widget.bank.color : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? widget.bank.color : Colors.grey[300]!,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        // Continue Button
        ElevatedButton(
          onPressed: _selectedAccounts.isNotEmpty
              ? () {
                  setState(() {
                    _currentStep = 2;
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.bank.color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: Text(
            _selectedAccounts.isEmpty
                ? 'Select at least one account'
                : 'Continue with ${_selectedAccounts.length} ${_selectedAccounts.length == 1 ? 'account' : 'accounts'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getAccountIcon(String account) {
    if (account.toLowerCase().contains('savings')) {
      return Icons.savings_outlined;
    } else if (account.toLowerCase().contains('current')) {
      return Icons.account_balance_outlined;
    } else if (account.toLowerCase().contains('credit')) {
      return Icons.credit_card_outlined;
    }
    return Icons.account_balance_wallet_outlined;
  }

  Widget _buildAuthorizationStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Success Animation Container
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(0.1),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.2),
                ),
              ),
              const Icon(
                Icons.check_circle,
                size: 64,
                color: Colors.green,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        // Success Title
        const Text(
          'Authorization Complete',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 12),
        // Success Message
        Text(
          '${_selectedAccounts.length} ${_selectedAccounts.length == 1 ? 'account' : 'accounts'} connected successfully',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        // Continue Button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ElevatedButton(
            onPressed: widget.onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Continue to App',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Additional Info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'You can manage your connected accounts in the settings',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
class Bank {
  final String name;
  final String logo;
  final String website;
  final IconData iconData;
  final Color color;
  final String type;  // 'Bank' or 'E-Wallet'
  Bank({
    required this.name,
    required this.logo,
    required this.website,
    required this.iconData,
    required this.color,
    required this.type,
  });
}
class BankAccount {
  final Bank bank;
  BankAccount({required this.bank});
} 
