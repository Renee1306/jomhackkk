
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Welcome to MoneyTracker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Connect your bank accounts and e-wallets to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              // Banks Section
              const Text(
                'Banks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
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
              // E-Wallets Section
              const Text(
                'E-Wallets',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _selectedAccounts.isNotEmpty
              ? () => _showAuthenticationFlow(context)
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
          ),
          child: Text(
            'Connect Selected ${_selectedAccounts.length} ${_selectedAccounts.length == 1 ? 'Account' : 'Accounts'}',
          ),
        ),
      ),
    );
  }
  Widget _buildBankItem(Bank bank) {
    bool isSelected = _selectedAccounts.any((account) => account.bank == bank);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bank.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            bank.logo,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: ${bank.logo}'); // Debug print
              return Icon(bank.iconData, color: bank.color);
            },
          ),
        ),
        title: Text(
          bank.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(bank.website),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (bool? value) {
            setState(() {
              if (value == true) {
                _selectedAccounts.add(BankAccount(bank: bank));
              } else {
                _selectedAccounts.removeWhere((account) => account.bank == bank);
              }
            });
          },
        ),
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedAccounts.removeWhere((account) => account.bank == bank);
            } else {
              _selectedAccounts.add(BankAccount(bank: bank));
            }
          });
        },
      ),
    );
  }
  void _showAuthenticationFlow(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BankAuthenticationFlow(
          bank: _selectedAccounts.first.bank,
          onComplete: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainNavigationPage(),
              ),
            );
          },
        );
      },
    );
  }
}
class BankAuthenticationFlow extends StatefulWidget {
  final Bank bank;
  final VoidCallback onComplete;
  const BankAuthenticationFlow({
    Key? key,
    required this.bank,
    required this.onComplete,
  }) : super(key: key);
  @override
  State<BankAuthenticationFlow> createState() => _BankAuthenticationFlowState();
}
class _BankAuthenticationFlowState extends State<BankAuthenticationFlow> {
  int _currentStep = 0;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<String> _availableAccounts = [
    'Savings Account ****1234',
    'Current Account ****5678',
    'Credit Card ****9012',
  ];
  final List<String> _selectedAccounts = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              Text(
                'Connect ${widget.bank.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: _buildCurrentStep(),
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
        return Container();
    }
  }
  Widget _buildLoginStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: const InputDecoration(
            labelText: 'Username',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentStep = 1;
            });
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
  Widget _buildAccountSelectionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Select accounts to connect',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _availableAccounts.length,
            itemBuilder: (context, index) {
              final account = _availableAccounts[index];
              return CheckboxListTile(
                title: Text(account),
                value: _selectedAccounts.contains(account),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedAccounts.add(account);
                    } else {
                      _selectedAccounts.remove(account);
                    }
                  });
                },
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _selectedAccounts.isNotEmpty
              ? () {
                  setState(() {
                    _currentStep = 2;
                  });
                }
              : null,
          child: const Text('Continue'),
        ),
      ],
    );
  }
  Widget _buildAuthorizationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 64,
          color: Colors.green,
        ),
        const SizedBox(height: 24),
        const Text(
          'Authorization Complete',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '${_selectedAccounts.length} accounts connected successfully',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: widget.onComplete,
          child: const Text('Continue to App'),
        ),
      ],
    );
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
