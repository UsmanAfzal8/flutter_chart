import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final List<String> upperData = ['3M', '6M', '9M', '1Y', 'MAX'];
  List<Color> gradientColors = [
    const Color(0xFF405246).withOpacity(0.3),
    const Color(0xFF405246).withOpacity(0.8),
    Colors.black.withOpacity(0.4),
  ];
  String selectedData = '3M';
  double maxXValue = 2;
  List<FlSpot> spots = [
    const FlSpot(0, 72.5),
    const FlSpot(1, 71.2),
    const FlSpot(2, 74.1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Chart Screen')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            _upperWidget(),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 400,
                height: 200,
                child: Row(
                  children: [
                    Expanded(child: LineChart(mainData())),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Jan', style: style);
        break;
      case 1:
        text = Text('Feb', style: style);
        break;
      case 2:
        text = Text('Mar', style: style);
        break;
      case 3:
        text = Text('Apr', style: style);
        break;
      case 4:
        text = Text('May', style: style);
        break;
      case 5:
        text = Text('June', style: style);
        break;
      case 6:
        text = Text('July', style: style);
        break;
      case 7:
        text = Text('Aug', style: style);
        break;
      case 8:
        text = Text('Sep', style: style);
        break;
      case 9:
        text = Text('Oct', style: style);
        break;
      case 10:
        text = Text('Nov', style: style);
        break;
      case 11:
        text = Text('Dec', style: style);
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8.0,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 70:
        text = '70';
        break;
      case 72:
        text = '72';
        break;
      case 75:
        text = '75';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.2,
            dashArray: [2, 2],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white,
            strokeWidth: 0.2,
            dashArray: [2, 2],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 24,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: Colors.white,
          width: 0.5,
          style: BorderStyle.solid,
        ),
      ),
      minX: 0,
      maxX: maxXValue,
      minY: 70,
      maxY: 75,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  Widget _upperWidget() {
    return SizedBox(
      height: 25,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (upperData[index] == '3M') {
                          spots = [
                            const FlSpot(0, 72.5),
                            const FlSpot(1, 73.2),
                            const FlSpot(2, 74.1),
                          ];
                          maxXValue = 2;
                        } else if (upperData[index] == '6M') {
                          spots = [
                            const FlSpot(0, 72.5),
                            const FlSpot(1, 73.2),
                            const FlSpot(2, 74.1),
                            const FlSpot(3, 72.8),
                            const FlSpot(4, 73.6),
                            const FlSpot(5, 74.2),
                          ];
                          maxXValue = 5;
                        } else if (upperData[index] == '9M') {
                          spots = [
                            const FlSpot(0, 72.5),
                            const FlSpot(1, 73.2),
                            const FlSpot(2, 74.1),
                            const FlSpot(3, 72.8),
                            const FlSpot(4, 73.6),
                            const FlSpot(5, 74.2),
                            const FlSpot(6, 73.4),
                            const FlSpot(7, 72.9),
                            const FlSpot(8, 73.8),
                          ];
                          maxXValue = 8;
                        } else {
                          spots = [
                            const FlSpot(0, 72.5),
                            const FlSpot(1, 73.2),
                            const FlSpot(2, 74.1),
                            const FlSpot(3, 72.8),
                            const FlSpot(4, 73.6),
                            const FlSpot(5, 74.2),
                            const FlSpot(6, 73.4),
                            const FlSpot(7, 72.9),
                            const FlSpot(8, 73.8),
                            const FlSpot(9, 72.1),
                            const FlSpot(10, 72.5),
                            const FlSpot(11, 72.4),
                          ];
                          maxXValue = 11;
                        }
                        selectedData = upperData[index];
                      });
                    },
                    child: Text(
                      upperData[index],
                      style: TextStyle(
                        color: upperData[index] == selectedData
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                  ),
                  upperData[index] == selectedData
                      ? Container(
                          width: 20,
                          height: 3,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3),
                                  topRight: Radius.circular(3))),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 10,
              width: 1,
              color: Colors.grey,
            );
          },
          itemCount: upperData.length),
    );
  }
}
