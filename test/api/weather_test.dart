import 'package:flutter_test/flutter_test.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';

import '../setup.dart';

main() {
  setup();
  test(
    "forcast api request",
    skip: "Comment out this line to try real api",
    () async {
      final client = getIt<WeatherAPI>();
      final op = client.getForcasts36Hours([TaiwanCity.taipei]);
      final r = await op.future();
      expect(r.success, equals("true"));
    },
  );
}
