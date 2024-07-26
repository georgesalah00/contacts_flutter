import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../blocs/contact/contact_bloc.dart';
import '../../data/models/chart_data.dart';
import '../../data/models/contact.dart';

class ChartScreen extends StatelessWidget {
  static const id = 'charts_screen';
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return  (state is ChartsState)?Column(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  primaryYAxis: const NumericAxis(),
                  series: <CartesianSeries>[
                    BarSeries<ChartData, String>(
                      dataSource: state.ageChartData,
                      xValueMapper: (ChartData data, _) => data.range,
                      yValueMapper: (ChartData data, _) => data.count,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SfCircularChart(
                  title: const ChartTitle(text: 'Gender Distribution'),
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<GenderData, Gender>(
                      dataSource: state.genderChartData,
                      xValueMapper: (GenderData data, _) => data.gender,
                      yValueMapper: (GenderData data, _) => data.count,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    ),
                  ],
                ),
              )
            ],
          ): Container();
        },
      ),
    );
  }
}
