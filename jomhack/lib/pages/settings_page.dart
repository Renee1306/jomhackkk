import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
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
              'Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E1E),
              ),
            ),
            Text(
              'Customize your app',
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
          _buildSectionTitle('Account'),
          _buildSettingCard([
            _buildSettingTile(
              icon: Icons.person,
              iconColor: const Color(0xFF2E3192),
              title: 'Profile',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
            _buildSettingTile(
              icon: Icons.notifications,
              iconColor: const Color(0xFF00B4D8),
              title: 'Notifications',
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
                activeColor: const Color(0xFF2E3192),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle('Preferences'),
          _buildSettingCard([
            _buildSettingTile(
              icon: Icons.category,
              iconColor: const Color(0xFF4CAF50),
              title: 'Categories',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
            _buildSettingTile(
              icon: Icons.payment,
              iconColor: const Color(0xFFE91E63),
              title: 'Payment Methods',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
            _buildSettingTile(
              icon: Icons.language,
              iconColor: const Color(0xFF9C27B0),
              title: 'Language',
              trailing: const Text(
                'English',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                ),
              ),
            ),
            _buildSettingTile(
              icon: Icons.currency_exchange,
              iconColor: const Color(0xFFFF9800),
              title: 'Currency',
              trailing: const Text(
                'MYR',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 14,
                ),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle('Security'),
          _buildSettingCard([
            _buildSettingTile(
              icon: Icons.backup,
              iconColor: const Color(0xFF3F51B5),
              title: 'Backup & Restore',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
            _buildSettingTile(
              icon: Icons.security,
              iconColor: const Color(0xFF607D8B),
              title: 'Security',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSectionTitle('About'),
          _buildSettingCard([
            _buildSettingTile(
              icon: Icons.info,
              iconColor: const Color(0xFF795548),
              title: 'About',
              trailing: const Icon(Icons.chevron_right, color: Color(0xFF666666)),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 12),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: const Color(0xFF2E3192),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
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
        children: children,
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E1E1E),
          ),
        ),
        trailing: trailing,
      ),
    );
  }
} 