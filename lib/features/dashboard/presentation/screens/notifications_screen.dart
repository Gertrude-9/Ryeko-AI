import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom app bar with flexible space
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Notifications',
                  style: TextStyle(color: Colors.white, fontSize: 22)),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade800, Colors.green.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Notification list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildNotificationCard(index),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(int index) {
    // Sample notification data
    final notifications = [
      {
        'title': 'Irrigation Alert',
        'message': 'Field 3 needs watering today',
        'time': 'Just now',
        'icon': Icons.opacity,
        'color': Colors.blue,
        'read': false
      },
      {
        'title': 'Pest Warning',
        'message': 'Armyworm activity detected in your area',
        'time': '2 hours ago',
        'icon': Icons.bug_report,
        'color': Colors.red,
        'read': false
      },
      {
        'title': 'Harvest Reminder',
        'message': 'Maize in Field 1 ready for harvest',
        'time': 'Yesterday',
        'icon': Icons.agriculture,
        'color': Colors.green,
        'read': true
      },
      {
        'title': 'Weather Update',
        'message': 'Heavy rain expected tomorrow',
        'time': '2 days ago',
        'icon': Icons.cloud,
        'color': Colors.teal,
        'read': true
      },
      {
        'title': 'Market Price Alert',
        'message': 'Maize prices increased by 12% this week',
        'time': '3 days ago',
        'icon': Icons.attach_money,
        'color': Colors.amber,
        'read': true
      },
    ];

    final notification = notifications[index % notifications.length];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle notification tap
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Notification icon with colored background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: notification['color'] as Color? ??
                        Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification['icon'] as IconData? ?? Icons.notifications,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),

                // Notification content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification['title'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: notification['read'] as bool? ?? false
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            notification['time'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['message'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Unread indicator
                if (!(notification['read'] as bool? ?? false)) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
