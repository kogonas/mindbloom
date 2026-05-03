import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  final FirestoreService _firestore = FirestoreService();
  List<String> moodList = [];
  Map<String, int> moodFrequency = {};

  @override
  void initState() {
    super.initState();
    loadMoodData();
  }

  Future<void> loadMoodData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_firestore.uid)
        .collection('moods')
        .orderBy('timestamp', descending: true)
        .limit(7)
        .get();

    final moods = snapshot.docs.map((doc) => doc['mood'] as String).toList();

    final freq = <String, int>{};
    for (var m in moods) {
      freq[m] = (freq[m] ?? 0) + 1;
    }

    setState(() {
      moodList = moods.reversed.toList(); // oldest → newest
      moodFrequency = freq;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Insights")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: moodList.isEmpty
            ? const Center(child: Text("No mood data yet"))
            : ListView(
                children: [
                  const Text(
                    "Mood Trend (Last 7 Days)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 4,
                            spots: List.generate(
                              moodList.length,
                              (i) => FlSpot(
                                i.toDouble(),
                                moodValue(moodList[i]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    "Mood Frequency",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    height: 200,
                    child: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        barGroups: moodFrequency.entries.map((entry) {
                          return BarChartGroupData(
                            x: entry.key.codeUnitAt(0),
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.toDouble(),
                                color: Colors.green,
                                width: 20,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Convert emoji → numeric value for chart
  double moodValue(String mood) {
    switch (mood) {
      case "😀":
        return 5;
      case "🙂":
        return 4;
      case "😐":
        return 3;
      case "😕":
        return 2;
      case "😢":
        return 1;
      default:
        return 3;
    }
  }
}
