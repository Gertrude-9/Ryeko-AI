import 'package:flutter/material.dart';

class HelpSupportSheet extends StatelessWidget {
  const HelpSupportSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Need Help?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Our team is ready to assist you with any questions',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
          const SizedBox(height: 24),

          // Support Options
          _buildSupportCard(
            context,
            icon: Icons.email,
            iconColor: Colors.blue,
            title: 'Email Support',
            subtitle: 'support@farmapp.com',
            actionText: 'Send Email',
            onTap: () => _launchEmail(context),
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            icon: Icons.phone,
            iconColor: Colors.green,
            title: 'Call Support',
            subtitle: '+254 700 123456',
            actionText: 'Call Now',
            onTap: () => _launchPhone(context),
          ),
          const SizedBox(height: 16),
          _buildSupportCard(
            context,
            icon: Icons.chat,
            iconColor: Colors.orange,
            title: 'Live Chat',
            subtitle: 'Available 24/7',
            actionText: 'Start Chat',
            onTap: () => _launchChat(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: iconColor.withOpacity(0.1),
                  foregroundColor: iconColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                onPressed: onTap,
                child: Text(actionText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchEmail(BuildContext context) {
    // Implement email launch
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening email client...')),
    );
  }

  void _launchPhone(BuildContext context) {
    // Implement phone call
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Launching phone app...')),
    );
  }

  void _launchChat(BuildContext context) {
    // Implement chat
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening live chat...')),
    );
  }
}