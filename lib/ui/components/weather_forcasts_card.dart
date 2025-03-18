import 'package:flutter/material.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';

class WeatherForcastsCard extends StatelessWidget {
  final CityForcast forcast;
  const WeatherForcastsCard(this.forcast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Forecast weather(Next 36 hours) in ${forcast.city.name}"),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: forcast.records.length,
              itemBuilder: (ctx, i) {
                return _ForcastSlot(forcast.records[i]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ForcastSlot extends StatelessWidget {
  final ForcastRecord forcast;

  const _ForcastSlot(this.forcast);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(forcast.minTemperature.toString()),
        Text(forcast.maxTemperature.toString()),
        Text(forcast.confortableTerm),
        Text(forcast.start.toString()),
      ],
    );
  }
}
