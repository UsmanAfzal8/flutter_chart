import 'package:flutter/material.dart';

import 'screen/chart_screen/chart_screen.dart';
import 'screen/power_chart.dart';
import 'screen/syncusion_chart/chatgptCode.dart';
import 'screen/syncusion_chart/heart_beat_line_chart.dart';
import 'screen/syncusion_chart/histogram.dart';
import 'screen/syncusion_chart/syncation_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LiveHistogramChart(),
    );
  }
}




