import 'package:flutter/material.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';
import 'package:the_weather_flutter/provider/utils/localized.dart';
import 'package:the_weather_flutter/ui/components/weather_icon.dart';

class WeatherForcastsCard extends StatelessWidget {
  final CityForcast forcast;
  const WeatherForcastsCard(this.forcast, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("天氣預測(未來36小時) - ${forcast.city.name}"),
            SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: ListView.separated(
                separatorBuilder: (_, __) => SizedBox(width: 12),
                scrollDirection: Axis.horizontal,
                itemCount: forcast.records.length,
                itemBuilder: (ctx, i) {
                  return _ForcastSlot(forcast.records[i]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForcastSlot extends StatelessWidget {
  final ForcastRecord forcast;

  const _ForcastSlot(this.forcast);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isNow = now.isAfter(forcast.start) && now.isBefore(forcast.end);
    final temperatureTextStyle =
        isNow
            ? Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: Colors.white)
            : Theme.of(context).textTheme.labelSmall;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration:
              isNow
                  ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.purple,
                  )
                  : null,
          child: Column(
            children: [
              Text(
                forcast.maxTemperature.localized,
                style: temperatureTextStyle,
              ),
              Text("|", style: temperatureTextStyle),
              Text(
                forcast.minTemperature.localized,
                style: temperatureTextStyle,
              ),
            ],
          ),
        ),
        WeatherIcon(
          forcast.weatherTerm,
          isNightIcon: forcast.start.hour > 18 || forcast.start.hour < 6,
        ),
        if (isNow) Text("現在") else Text(forcast.start.localizedHour),
        Text(forcast.confortableTerm),
      ],
    );
  }
}
