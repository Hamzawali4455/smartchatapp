import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _darkMode = false;
  bool _readReceipts = true;
  bool _typingIndicators = true;
  bool _showOnlineStatus = true;
  bool _allowCalls = true;
  bool _allowVideoCalls = true;
  bool _twoFactorEnabled = false;
  bool _biometricEnabled = false;
  bool _appLockEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Notifications Section
            _buildSettingsSection(
              title: 'Notifications',
              children: [
                _buildSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive notifications for new messages',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Sound',
                  subtitle: 'Play sounds for notifications',
                  value: _soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Vibration',
                  subtitle: 'Vibrate for notifications',
                  value: _vibrationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _vibrationEnabled = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Appearance Section
            _buildSettingsSection(
              title: 'Appearance',
              children: [
                _buildSwitchTile(
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() {
                      _darkMode = value;
                    });
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.palette_outlined,
                  title: 'Theme',
                  subtitle: 'Choose your preferred theme',
                  onTap: () {
                    _showThemeDialog();
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.text_fields_outlined,
                  title: 'Font Size',
                  subtitle: 'Adjust text size',
                  onTap: () {
                    _showFontSizeDialog();
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Chat Section
            _buildSettingsSection(
              title: 'Chat',
              children: [
                _buildSwitchTile(
                  title: 'Read Receipts',
                  subtitle: 'Show when messages are read',
                  value: _readReceipts,
                  onChanged: (value) {
                    setState(() {
                      _readReceipts = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Typing Indicators',
                  subtitle: 'Show when someone is typing',
                  value: _typingIndicators,
                  onChanged: (value) {
                    setState(() {
                      _typingIndicators = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Online Status',
                  subtitle: 'Show your online status to others',
                  value: _showOnlineStatus,
                  onChanged: (value) {
                    setState(() {
                      _showOnlineStatus = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Calls Section
            _buildSettingsSection(
              title: 'Calls',
              children: [
                _buildSwitchTile(
                  title: 'Allow Voice Calls',
                  subtitle: 'Receive voice calls from contacts',
                  value: _allowCalls,
                  onChanged: (value) {
                    setState(() {
                      _allowCalls = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Allow Video Calls',
                  subtitle: 'Receive video calls from contacts',
                  value: _allowVideoCalls,
                  onChanged: (value) {
                    setState(() {
                      _allowVideoCalls = value;
                    });
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Security Section
            _buildSettingsSection(
              title: 'Security',
              children: [
                _buildSwitchTile(
                  title: 'Two-Factor Authentication',
                  subtitle: 'Add extra security to your account',
                  value: _twoFactorEnabled,
                  onChanged: (value) {
                    setState(() {
                      _twoFactorEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Biometric Authentication',
                  subtitle: 'Use fingerprint or face unlock',
                  value: _biometricEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricEnabled = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'App Lock',
                  subtitle: 'Lock the app when not in use',
                  value: _appLockEnabled,
                  onChanged: (value) {
                    setState(() {
                      _appLockEnabled = value;
                    });
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: () {
                    _showChangePasswordDialog();
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Privacy Section
            _buildSettingsSection(
              title: 'Privacy',
              children: [
                _buildSettingsTile(
                  icon: Icons.block_outlined,
                  title: 'Blocked Contacts',
                  subtitle: 'Manage blocked users',
                  onTap: () {
                    // TODO: Navigate to blocked contacts
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.visibility_off_outlined,
                  title: 'Stealth Mode',
                  subtitle: 'Hide your activity from others',
                  onTap: () {
                    _showStealthModeDialog();
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.delete_outline,
                  title: 'Delete Account',
                  subtitle: 'Permanently delete your account',
                  onTap: () {
                    _showDeleteAccountDialog();
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Advanced Section
            _buildSettingsSection(
              title: 'Advanced',
              children: [
                _buildSettingsTile(
                  icon: Icons.storage_outlined,
                  title: 'Storage',
                  subtitle: 'Manage app storage and cache',
                  onTap: () {
                    _showStorageDialog();
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.backup_outlined,
                  title: 'Backup & Restore',
                  subtitle: 'Backup your data',
                  onTap: () {
                    _showBackupDialog();
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.bug_report_outlined,
                  title: 'Debug Info',
                  subtitle: 'View app debug information',
                  onTap: () {
                    _showDebugDialog();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Light'),
              leading: Radio<String>(
                value: 'light',
                groupValue: 'light', // TODO: Get current theme
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('Dark'),
              leading: Radio<String>(
                value: 'dark',
                groupValue: 'light', // TODO: Get current theme
                onChanged: (value) {},
              ),
            ),
            ListTile(
              title: const Text('System'),
              leading: Radio<String>(
                value: 'system',
                groupValue: 'light', // TODO: Get current theme
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Font Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              value: 1.0, // TODO: Get current font scale
              min: 0.8,
              max: 1.4,
              divisions: 6,
              label: 'Normal',
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showStealthModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stealth Mode'),
        content: const Text(
          'In stealth mode, your online status and activity will be hidden from other users. You can still receive messages and calls.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Enable Stealth Mode'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account'),
          ),
        ],
      ),
    );
  }

  void _showStorageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Storage'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('App Storage: 150 MB'),
            const Text('Cache: 25 MB'),
            const Text('Messages: 100 MB'),
            const Text('Media: 25 MB'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Clear Cache'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Backup & Restore'),
        content: const Text('Backup your messages and settings to the cloud.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Create Backup'),
          ),
        ],
      ),
    );
  }

  void _showDebugDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Debug Information'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('App Version: 1.0.0'),
            Text('Build Number: 1'),
            Text('Platform: Android'),
            Text('Device: Pixel 6'),
            Text('OS Version: Android 13'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
