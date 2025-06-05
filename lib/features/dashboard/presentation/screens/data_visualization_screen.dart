import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataVisualizationScreen extends StatelessWidget {
  const DataVisualizationScreen({super.key});

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
              // Header
              _buildHeader(context),
              const SizedBox(height: 24),

              // Visual Dashboards Section
              _buildSectionTitle(
                title: "Visual Dashboards",
                icon: Icons.insights,
                description: "Interactive data visualization for farm metrics",
              ),
              const SizedBox(height: 16),

              // Crop Health Card
              _buildChartCard(
                title: "Crop Health Status (Last 4 Weeks)",
                chart: _buildLineChart(),
                icon: Icons.health_and_safety,
                iconColor: Colors.green,
              ),
              const SizedBox(height: 16),

              // Environmental Trends Card
              _buildChartCard(
                title: "Environmental Trends",
                chart: _buildBarChart(),
                icon: Icons.thermostat,
                iconColor: Colors.blue,
              ),
              const SizedBox(height: 16),

              // AI Prediction Card
              _buildChartCard(
                title: "AI Prediction Summary",
                chart: _buildPieChart(),
                icon: Icons.psychology,
                iconColor: Colors.purple,
              ),
              const SizedBox(height: 24),

              // Reports Section
              _buildSectionTitle(
                title: "Download Reports",
                icon: Icons.download,
                description: "Export detailed farm analytics",
              ),
              const SizedBox(height: 16),

              // Report Buttons
              _buildReportButton(
                context,
                icon: Icons.description,
                label: "Download Full Farm Report",
                description: "PDF format with all metrics",
                color: Colors.green,
              ),
              const SizedBox(height: 12),
              _buildReportButton(
                context,
                icon: Icons.analytics,
                label: "Export AI Analysis Report",
                description: "Detailed predictions and trends",
                color: Colors.teal,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.analytics, size: 32, color: Colors.green.shade700),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Farm Data Visualization",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900),
                ),
                const SizedBox(height: 4),
                Text(
                  "Interactive charts and reports for your farm",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle({
    required String title,
    required IconData icon,
    required String description,
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
                  color: Colors.green.shade900),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38, top: 4),
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard({
    required String title,
    required Widget chart,
    required IconData icon,
    required Color iconColor,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String description,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Preparing $label..."),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: color,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 24, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    final data = [
      _Point("Week 1", 80),
      _Point("Week 2", 65),
      _Point("Week 3", 90),
      _Point("Week 4", 70),
    ];

    final series = [
      charts.Series<_Point, String>(
        id: 'Crop Health',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (_Point point, _) => point.label,
        measureFn: (_Point point, _) => point.value,
        data: data,
      )
    ];

    return charts.LineChart(
      series.cast<charts.Series<dynamic, num>>(),
      animate: true,
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        strokeWidthPx: 3,
      ),
      domainAxis: const charts.OrdinalAxisSpec(
        // Changed to OrdinalAxisSpec for string categories
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        // Changed to NumericAxisSpec for numeric values
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final data = [
      _Point("Moisture", 45),
      _Point("Temp", 30),
      _Point("Rain", 60),
    ];

    final series = [
      charts.Series<_Point, String>(
        id: 'Environment',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (_Point point, _) => point.label,
        measureFn: (_Point point, _) => point.value,
        data: data,
      )
    ];

    return charts.BarChart(
      series,
      animate: true,
      vertical: false,
      domainAxis: const charts.OrdinalAxisSpec(
        // Changed to OrdinalAxisSpec for string categories
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
      primaryMeasureAxis: const charts.NumericAxisSpec(
        // Changed to NumericAxisSpec for numeric values
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 10,
            color: charts.MaterialPalette.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    final data = [
      _Point("Healthy", 60),
      _Point("Disease Risk", 25),
      _Point("Pest Alert", 15),
    ];

    final series = [
      charts.Series<_Point, String>(
        id: 'AI Summary',
        domainFn: (_Point point, _) => point.label,
        measureFn: (_Point point, _) => point.value,
        data: data,
        colorFn: (_Point point, _) {
          switch (point.label) {
            case "Healthy":
              return charts.MaterialPalette.green.shadeDefault;
            case "Disease Risk":
              return charts.MaterialPalette.deepOrange.shadeDefault;
            case "Pest Alert":
              return charts.MaterialPalette.red.shadeDefault;
            default:
              return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        labelAccessorFn: (_Point point, _) => '${point.label}: ${point.value}%',
      )
    ];

    return charts.PieChart<String>(
      series,
      animate: true,
      defaultRenderer: charts.ArcRendererConfig<String>(
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.auto,
          ),
        ],
      ),
    );
  }
}
class _Point {
  final String label;
  final int value;

  _Point(this.label, this.value);
}
