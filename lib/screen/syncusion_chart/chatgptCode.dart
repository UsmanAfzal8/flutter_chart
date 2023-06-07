import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataPoint {
  final int time;
  final int value;
  final int yValue;
  DataPoint(this.time, this.value, this.yValue);
}

class LiveHistogramChart extends StatefulWidget {
  @override
  _LiveHistogramChartState createState() => _LiveHistogramChartState();
}

class _LiveHistogramChartState extends State<LiveHistogramChart> {
  List<DataPoint> data = [];
  List<DataPoint> filteredData = [];
  Timer? timer;
  int selectedInterval = 1;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => updateData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int newwvalue = 1;
  int yValue = 1;
  void updateData() {
    // Generate random data
    final Random random = Random();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    // final int newValue = random.nextInt(100);

    setState(() {
      // if (newwvalue % 2 == 0) {
      //   newwvalue = newwvalue + 5;
      // } else {
      // }
      newwvalue++;
      yValue = yValue + 2;
      data.add(DataPoint(currentTime, newwvalue, yValue));

      // Remove data points older than 7 minutes
      final int threshold = currentTime - (7 * 60 * 1000);
      data.removeWhere((dp) => dp.time < threshold);

      // Filter data based on selected time interval
      filterData(selectedInterval);
    });
  }

  void filterData(int minutes) {
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    final int threshold = currentTime - (minutes * 60 * 1000);

    setState(() {
      filteredData = data.where((dp) => dp.time >= threshold).toList();
    });
  }

  List<ChartSeries<DataPoint, int>> _createSeries() {
    return [
      //  StepLineSeries<DataPoint, int>(
      //   dataSource: [
      //     DataPoint(DateTime.now().subtract(Duration(minutes: selectedInterval)).microsecondsSinceEpoch, 30),
      //     DataPoint(DateTime.now().millisecondsSinceEpoch, 30)],
      //   xValueMapper: (DataPoint dp, _) => dp.time,
      //   yValueMapper: (DataPoint dp, _) => dp.value,
      //   name: 'g',
      //   animationDelay: 0.0,
      //   animationDuration: 0.0,
      //   color: Colors.red,
      //   width: 2,

      // ),
      StepAreaSeries<DataPoint, int>(
        dataSource: filteredData,
        xValueMapper: (DataPoint dp, _) => dp.yValue,
        yValueMapper: (DataPoint dp, _) => dp.value,
        name: 'Histogram',
        animationDelay: 0.0,
        xAxisName: 'Value',
        yAxisName: 'Time',
        animationDuration: 0.0,
        color: Colors.blue,
        //  trendlines: [
        //   Trendline(
        //      color: Colors.red,
        //  isVisible: true,
        //  name: '',
        //   animationDuration: 0,

        //   intercept: 10,

        //   ),
        //  ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Histogram Chart'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedInterval = 1;
                    filterData(selectedInterval);
                  });
                },
                child: Text('1 Minute'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedInterval = 5;
                    filterData(selectedInterval);
                  });
                },
                child: Text('5 Minutes'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedInterval = 7;
                    filterData(selectedInterval);
                  });
                },
                child: Text('7 Minutes'),
              ),
            ],
          ),
          Container(
            height: 250,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SfCartesianChart(
                    series: _createSeries(),
                    primaryXAxis: NumericAxis(),
                    primaryYAxis: NumericAxis(
                      maximum: 100,
                      visibleMaximum: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 42,
                    right: 0,
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.red,
                    ),
                  ),
                  const Positioned(
                    bottom: 90,
                    left: 0,
                    child: Text(
                      'Q',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Positioned(
                    top: 76,
                    left: 0,
                    child: Text(
                      '2Q',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 42,
                    right: 0,
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
