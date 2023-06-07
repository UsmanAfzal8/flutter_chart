// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class DataPoint {
//   final DateTime time;
//   final double value;

//   DataPoint(this.time, this.value);
// }

// class HeartBeatHistogramChart extends StatefulWidget {
//   @override
//   _HeartBeatHistogramChartState createState() =>
//       _HeartBeatHistogramChartState();
// }

// class _HeartBeatHistogramChartState extends State<HeartBeatHistogramChart> {
//   List<DataPoint> data = [];
//   Timer? timer;
//   int selectedInterval = 1;
//   int visiblePoints =
//       60; // Number of data points to be displayed initially (1 minute)

//   @override
//   void initState() {
//     super.initState();
//     timer = Timer.periodic(Duration(seconds: 2), (Timer t) => updateData());
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   double newwValue = 1;
//   void updateData() {
//     // Generate random data
//     final Random random = Random();
//     final DateTime currentTime = DateTime.now();
//     //final double newValue = random.nextDouble() * 100;

//     setState(() {
//       if (newwValue % 2 == 0) {
//         newwValue =newwValue + 3;
//       } else {
//         newwValue++;
//       }
     

//       data.add(DataPoint(currentTime, newwValue));

//       // Remove data points older than the selected interval
//       final DateTime threshold =
//           currentTime.subtract(Duration(minutes: selectedInterval));
//       data.removeWhere((dp) => dp.time.isBefore(threshold));

//       // Limit the number of visible points
//       if (data.length > visiblePoints) {
//         data.removeRange(0, data.length - visiblePoints);
//       }
//     });
//   }

//   List<ChartSeries<DataPoint, DateTime>> _createSeries() {
//     return [
//       StepAreaSeries<DataPoint, DateTime>(
//         dataSource: data,
//         animationDuration: 0.0,
//         animationDelay: 0.0,
//         xValueMapper: (DataPoint dp, _) => dp.time,
//         yValueMapper: (DataPoint dp, _) => dp.value,
//         name: 'Live Data',
//         color: Colors.blue,
//       ),
//     ];
//   }
// List<DataPoint> filteredData = [];
//   // void _changeInterval(int minutes) {
//   //   setState(() {
//   //     selectedInterval = minutes;
//   //     visiblePoints = minutes * 60;
//   //   });
//   // }
//  void filterData(int minutes) {
//     final int currentTime = DateTime.now().millisecondsSinceEpoch;
//     final int threshold = currentTime - (minutes * 60 * 1000);

//     setState(() {
//       filteredData = data.where((dp) => dp.time >= threshold).toList();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Live Line Chart'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () => _changeInterval(1),
//                   child: Text('1m'),
//                 ),
//                 SizedBox(width: 16.0),
//                 ElevatedButton(
//                   onPressed: () => _changeInterval(5),
//                   child: Text('5m'),
//                 ),
//                 SizedBox(width: 16.0),
//                 ElevatedButton(
//                   onPressed: () => _changeInterval(7),
//                   child: Text('7m'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: SfCartesianChart(
//                 primaryXAxis: DateTimeAxis(),
//                 series: _createSeries(),
//                 primaryYAxis: NumericAxis(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
