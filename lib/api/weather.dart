import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';

class CancellableFuture<T> {
  final Future<T> Function() future;
  final void Function() cancel;
  CancellableFuture(this.future, this.cancel);
}

abstract class WeatherAPI {
  CancellableFuture<ForcastsResponse> getForcasts36Hours(
    List<TaiwanCity> cities,
  );
}
