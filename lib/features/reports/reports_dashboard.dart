import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../widgets_imports.dart';

class ReportsDashboard extends StatelessWidget {
  const ReportsDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    final months = ['يناير','فبراير','مارس','أبريل','مايو','يونيو','يوليو','أغسطس','سبتمبر','أكتوبر','نوفمبر','ديسمبر'];
    final values = [120,140,160,180,190,210,220,230,250,260,270,300].map((e)=> e.toDouble()).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('التقارير الرئيسية')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('مؤشرات عامة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          GridView.count(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), children: const [
            StatCard(title: 'عدد المتدربين', value: '1240', icon: Icons.groups_outlined),
            StatCard(title: 'الدورات النشطة', value: '32', icon: Icons.menu_book_outlined),
            StatCard(title: 'نسبة النجاح', value: '87%', icon: Icons.emoji_events_outlined),
            StatCard(title: 'متوسط الحضور', value: '92%', icon: Icons.how_to_reg_outlined),
          ]),
          const SizedBox(height: 16),
          const Text('التقدم الشهري', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          SizedBox(
            height: 260,
            child: LineChart(LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 36)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta){
                  final i = v.toInt();
                  if(i<0 || i>=months.length) return const SizedBox();
                  return Padding(padding: const EdgeInsets.only(top: 6), child: Text(months[i], style: const TextStyle(fontSize: 10)));
                })),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  spots: List.generate(values.length, (i)=> FlSpot(i.toDouble(), values[i])),
                  barWidth: 3,
                  dotData: FlDotData(show: false),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
