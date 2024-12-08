import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatelessWidget {
  final Map<String, List<Map<String, dynamic>>> allExpenses;

  const GraphScreen({super.key, required this.allExpenses});

  @override
  Widget build(BuildContext context) {
    final List<Color> barColors = [Colors.blue, Colors.green, Colors.orange, Colors.red];
    final accountNames = allExpenses.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Graph"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Monthly Expense Comparison',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < accountNames.length) {
                            return Text(
                              accountNames[index],
                              style: const TextStyle(fontSize: 12),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ),
                  barGroups: accountNames.asMap().entries.map<BarChartGroupData>((entry) {
                    int index = entry.key;
                    final account = entry.value;

                    double total = allExpenses[account]!.fold<double>(
                      0.0,
                      (sum, expense) => sum + expense['amount'],
                    );

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: total,
                          color: barColors[index],
                          width: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: accountNames.asMap().entries.map((entry) {
                int index = entry.key;
                String name = entry.value;
                return Row(
                  children: [
                    Container(width: 12, height: 12, color: barColors[index]),
                    const SizedBox(width: 4),
                    Text(name),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
