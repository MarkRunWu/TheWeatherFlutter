import 'package:flutter_test/flutter_test.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/provider/weather.dart';

import '../setup.dart';
import '../utils/riverpod.dart';

main() {
  setup();
  test("Fetch forcast data provider", () async {
    final container = createContainer();
    await expectLater(
      container
          .readWithoutDisposed(
            ForcastsNext36HoursProvider([TaiwanCity.taipei]).future,
          )
          .then((v) => v.length),
      completion(isNonZero),
    );
  });
}
