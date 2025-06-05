import 'package:flutter/material.dart';

class DecisionSupportScreen extends StatelessWidget {
  const DecisionSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50.withOpacity(0.5),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              _buildWelcomeHeader(context),
              const SizedBox(height: 24),

              // Agronomic Advice Section
              _buildSectionHeader(
                title: "Tailored Agronomic Advice",
                icon: Icons.agriculture,
                subtitle: "Personalized recommendations for your farm",
              ),
              const SizedBox(height: 12),

              // Advice Cards with horizontal scroll
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 4),
                    _buildAdviceCard(
                      title: "Maize Planting Guide",
                      advice:
                          "• Optimal planting depth: 3-5cm\n• Row spacing: 75cm\n• Plant spacing: 30cm\n• Fertilizer: 200kg NPK/ha",
                      icon: Icons.grass,
                      color: Colors.teal.shade50,
                      iconColor: Colors.teal,
                      emoji: "🌽",
                    ),
                    const SizedBox(width: 12),
                    _buildAdviceCard(
                      title: "Soil Management",
                      advice:
                          "• Test soil every season\n• Target pH: 6.0-6.5\n• Apply 5 tons compost/ha\n• Rotate with legumes",
                      icon: Icons.terrain,
                      color: Colors.amber.shade50,
                      iconColor: Colors.amber.shade700,
                      emoji: "🌱",
                    ),
                    const SizedBox(width: 12),
                    _buildAdviceCard(
                      title: "Water Conservation",
                      advice:
                          "• Mulch to retain moisture\n• Drip irrigation recommended\n• Collect rainwater\n• Water early morning",
                      icon: Icons.water_drop,
                      color: Colors.blue.shade50,
                      iconColor: Colors.blue,
                      emoji: "💧",
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Alerts Section
              _buildSectionHeader(
                title: "Critical Alerts & Notifications",
                icon: Icons.notifications_active,
                subtitle: "Time-sensitive actions for your farm",
              ),
              const SizedBox(height: 12),

              // Alert Cards
              _buildAlertCard(
                title: "Drought Warning",
                message:
                    "Low rainfall expected next 2 weeks. Prepare irrigation systems and conserve water.",
                color: Colors.orange.shade50,
                borderColor: Colors.orange,
                icon: Icons.warning,
                severity: "High",
                time: "Today",
              ),
              const SizedBox(height: 12),
              _buildAlertCard(
                title: "Pest Alert: Army Worms",
                message:
                    "Increased activity detected in neighboring farms. Inspect crops daily and prepare organic pesticides.",
                color: Colors.red.shade50,
                borderColor: Colors.red,
                icon: Icons.bug_report,
                severity: "Critical",
                time: "2 hours ago",
              ),
              const SizedBox(height: 12),
              _buildAlertCard(
                title: "Planting Window Open",
                message:
                    "Ideal conditions for planting maize. Soil temperature at 18°C with adequate moisture.",
                color: Colors.green.shade50,
                borderColor: Colors.green,
                icon: Icons.calendar_today,
                severity: "Opportunity",
                time: "June 5-15",
              ),
              const SizedBox(height: 24),

              // Weather & Market Section
              _buildSectionHeader(
                title: "Quick Insights",
                icon: Icons.insights,
                subtitle: "Weather and market updates",
              ),
              const SizedBox(height: 12),
              _buildInsightsRow(context),
              const SizedBox(height: 32),

              // Refresh Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 2,
                            ),
                            const SizedBox(width: 12),
                            const Text("Updating farm advisories..."),
                          ],
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.green.shade700,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white, size: 20),
                  label: const Text(
                    "Refresh Data",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    shadowColor: Colors.green.withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.shade100.withOpacity(0.6),
            Colors.green.shade50.withOpacity(0.4),
          ],
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.shade100,
            radius: 30,
            child: Icon(
              Icons.agriculture,
              size: 32,
              color: Colors.green.shade800,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Farm Decision Support",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "AI-powered recommendations for your farm operations",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required IconData icon,
    String? subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: Colors.green.shade800),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAdviceCard({
    required String title,
    required String advice,
    required IconData icon,
    required Color color,
    required Color iconColor,
    String? emoji,
  }) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: iconColor),
                ),
                if (emoji != null) ...[
                  const SizedBox(width: 8),
                  Text(emoji, style: const TextStyle(fontSize: 20)),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              advice,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String message,
    required Color color,
    required Color borderColor,
    required IconData icon,
    required String severity,
    required String time,
  }) {
    Color severityColor;
    switch (severity.toLowerCase()) {
      case "high":
        severityColor = Colors.orange;
        break;
      case "critical":
        severityColor = Colors.red;
        break;
      default:
        severityColor = Colors.green;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: borderColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: severityColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: severityColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              severity,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: severityColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInsightCard(
            icon: Icons.wb_sunny,
            title: "Weather",
            value: "Sunny, 28°C",
            change: "+2°C from yesterday",
            color: Colors.blue.shade50,
            iconColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildInsightCard(
            icon: Icons.attach_money,
            title: "Maize Price",
            value: "\$210/ton",
            change: "+5% this week",
            color: Colors.amber.shade50,
            iconColor: Colors.amber.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required String title,
    required String value,
    required String change,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}