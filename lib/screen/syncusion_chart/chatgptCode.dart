import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataPoint {
  final int time;
  final int value;

  DataPoint(this.time, this.value);
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
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => updateData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
int newwvalue=1;
  void updateData() {
    // Generate random data
    final Random random = Random();
    final int currentTime = DateTime.now().millisecondsSinceEpoch;
   // final int newValue = random.nextInt(100);

    setState(() {
      newwvalue++;
      data.add(DataPoint(currentTime, newwvalue));

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
      ColumnSeries<DataPoint, int>(
          dataSource: filteredData,
          xValueMapper: (DataPoint dp, _) => dp.time,
          yValueMapper: (DataPoint dp, _) => dp.value,
          name: 'Histogram',
          
          color: Colors.blue,
          width: 0.9,
          spacing: 0),
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
              child: SfCartesianChart(
                series: _createSeries(),
                primaryXAxis: NumericAxis(),
                primaryYAxis: NumericAxis(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
