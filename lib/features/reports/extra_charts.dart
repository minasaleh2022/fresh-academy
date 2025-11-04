import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ExtraCharts extends StatelessWidget {
  const ExtraCharts({super.key});
  @override
  Widget build(BuildContext context) {
    final pieData = [30.0, 25.0, 20.0, 15.0, 10.0];
    final bars = [12.0, 18.0, 9.0, 22.0, 15.0];
    final scatter = [FlSpot(1,2), FlSpot(2,1.5), FlSpot(3,3.2), FlSpot(4,2.7), FlSpot(5,4.1)];

    return Scaffold(
      appBar: AppBar(title: const Text('Charts إضافية وتصدير PDF'), actions: [
        IconButton(icon: const Icon(Icons.picture_as_pdf_outlined), onPressed: () async {
          final doc = pw.Document();
          doc.addPage(pw.Page(build: (c)=> pw.Column(children: [
            pw.Text('Fresh Academy — تقرير مختصر', style: pw.TextStyle(fontSize: 20)),
            pw.SizedBox(height: 12),
            pw.Text('ملخص المؤشرات الرسومية.'),
          ])));
          await Printing.layoutPdf(onLayout: (format) async => doc.save());
        }),
      ]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Pie Chart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 220, child: PieChart(PieChartData(sections: List.generate(pieData.length, (i)=> PieChartSectionData(value: pieData[i], title: '${pieData[i]}%'))))),
          const SizedBox(height: 16),
          const Text('Bar Chart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 220, child: BarChart(BarChartData(
            barGroups: List.generate(bars.length, (i)=> BarChartGroupData(x: i, barRods: [BarChartRodData(toY: bars[i])])),
          ))),
          const SizedBox(height: 16),
          const Text('Scatter Chart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 220, child: ScatterChart(ScatterChartData(scatterSpots: scatter.map((e)=> ScatterSpot(e.x, e.y)).toList()))),
        ],
      ),
    );
  }
}
