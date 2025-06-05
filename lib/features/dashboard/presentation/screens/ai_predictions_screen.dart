import 'package:flutter/material.dart';

class AIPredictionsScreen extends StatelessWidget {
  const AIPredictionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                icon: Icons.health_and_safety,
                title: "Crop Disease Prediction",
                subtitle: "Real-time AI analysis",
              ),
              const SizedBox(height: 12),
              _buildPredictionCard(
                context,
                icon: Icons.local_florist,
                title: "Disease Detected: Leaf Spot",
                description: "Confidence: 91%",
                action: "Apply fungicide and isolate affected crops.",
                color: Colors.red.shade100,
                iconColor: Colors.red,
              ),
              const SizedBox(height: 24),
              
              _buildSectionHeader(
                icon: Icons.eco,
                title: "Crop Recommendation",
                subtitle: "Optimized for your soil",
              ),
              const SizedBox(height: 12),
              _buildPredictionCard(
                context,
                icon: Icons.agriculture,
                title: "Recommended Crops: Maize, Beans",
                description: "Soil pH: 6.3 • Temp: 26°C • Rainfall: 85mm",
                action: "Ideal planting window: Next 2 weeks",
                color: Colors.blue.shade100,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 24),
              
              _buildSectionHeader(
                icon: Icons.warning_amber,
                title: "Pest & Disease Forecast",
                subtitle: "7-day outlook",
              ),
              const SizedBox(height: 12),
              _buildPredictionCard(
                context,
                icon: Icons.bug_report,
                title: "Pest Risk Level: Medium",
                description: "Historical pattern detected",
                action: "Monitor for aphids over next 7 days.",
                color: Colors.orange.shade100,
                iconColor: Colors.orange,
              ),
              const SizedBox(height: 32),
              
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text("Refreshing predictions..."),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text("Refresh AI Predictions", 
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24, 
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 24, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPredictionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String action,
    required Color color,
    required Color iconColor,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: iconColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.green.shade100,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.lightbulb_outline, 
                            size: 16, 
                            color: Colors.green.shade600,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              action,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}