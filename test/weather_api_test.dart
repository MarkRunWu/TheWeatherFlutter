import 'package:flutter_test/flutter_test.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/provider/weather.dart';

import 'utils/riverpod.dart';

void main() async {
  await configureDependencies();
  test(
    "forcast api request",
    skip: "Comment out this line to try real api",
    () async {
      final client = getIt<WeatherAPI>();
      final r = await client.getForcasts36Hours(TaiwanCity.taipei);
      expect(r.success, equals("true"));
    },
  );

  test("forcast data provider", () async {
    final container = createContainer();
    expectLater(
      container
          .read(ForcastsNext36HoursProvider(TaiwanCity.taipei).future)
          .then((v) => v.length),
      completion(isNonZero),
    );
  });
}
