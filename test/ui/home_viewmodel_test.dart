import 'package:flutter_test/flutter_test.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/error.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/provider/models/forcast_ext.dart';
import 'package:the_weather_flutter/ui/home_viewmodel.dart';

import '../mock/data.dart';
import '../mock/weather_api.dart';
import '../setup.dart';
import '../utils/injectable.dart';
import '../utils/riverpod.dart';

void main() {
  setup();

  group("Test home viewmodel", () {
    test("Should have init state", () async {
      final container = createContainer();
      await container.expectProviderState(
        homeViewModelProvider,
        HomeReadyState("", []),
      );
    });
    test("Should change query", () async {
      final q = "test";
      final container = createContainer();
      container.read(homeViewModelProvider.notifier).searchByText(q);
      await container.expectProviderState(
        homeViewModelProvider,
        HomeReadyState(q, []),
      );
    });
    test("Should show permission error", () async {
      mockAPI(PermissionErrorAPI());
      final container = createContainer();
      final q = TaiwanCity.taipei.name;
      container.read(homeViewModelProvider.notifier).searchByText(q);
      await container.expectProviderState(
        homeViewModelProvider,
        HomeErrorState(APIError(statusCode: 400), q),
      );
    });
    test("Should show city weather result", () async {
      final container = createContainer();
      final city = TaiwanCity.taipei;
      final q = city.name;
      container.read(homeViewModelProvider.notifier).searchByText(q);
      await container.expectProviderState(
        homeViewModelProvider,
        HomeReadyState(
          q,
          createMockForcastsResponse([city]).records.locations
              .map(
                (l) => CityForcastMapper.from(l, dateTimeAfter: DateTime.now()),
              )
              .toList(),
        ),
      );
    });

    test("Should show multiple city weather results", () async {
      final container = createContainer();
      final cities = [TaiwanCity.taipei, TaiwanCity.yilan];
      final q = cities.map((city) => city.name).join(" ");
      container.read(homeViewModelProvider.notifier).searchByText(q);
      await container.expectProviderState(
        homeViewModelProvider,
        HomeReadyState(
          q,
          createMockForcastsResponse(cities).records.locations
              .map(
                (l) => CityForcastMapper.from(l, dateTimeAfter: DateTime.now()),
              )
              .toList(),
        ),
      );
    });
  });
}

class PermissionErrorAPI extends MockWeatherAPI {
  @override
  CancellableFuture<ForcastsResponse> getForcasts36Hours(
    List<TaiwanCity> cities,
  ) {
    return CancellableFuture(() => throw APIError(statusCode: 400), () {});
  }
}
