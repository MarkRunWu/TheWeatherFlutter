import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/error.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';
import 'package:the_weather_flutter/provider/weather.dart';

part 'home_viewmodel.g.dart';

sealed class HomeState {}

class HomeReadyState extends HomeState {
  String query;
  CityForcast? forcast;

  HomeReadyState(this.query, this.forcast);
}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final AppError error;
  HomeErrorState(this.error);
}

final searchTextProvider = StateProvider<String>((Ref ref) {
  return '';
});

@riverpod
HomeState homeState(Ref ref) {
  final q = ref.watch(searchTextProvider);
  final r = ref.watch(
    forcastsNext36HoursProvider(
      TaiwanCity.values
          .where((city) => q.isNotEmpty && city.name.startsWith(q))
          .firstOrNull,
    ),
  );
  return r.map(
    data: (d) => HomeReadyState(q, d.value),
    error: (e) => HomeErrorState(e.error as AppError),
    loading: (l) => HomeLoadingState(),
  );
}

class HomeStateHandler {
  static void searchByText(WidgetRef ref, String text) {
    ref.read(searchTextProvider.notifier).state = text.trim().replaceAll(
      "台",
      "臺",
    );
  }
}
