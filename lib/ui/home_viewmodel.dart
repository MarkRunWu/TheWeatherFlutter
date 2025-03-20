import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/error.dart';
import 'package:the_weather_flutter/app_config.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';
import 'package:the_weather_flutter/provider/weather.dart';

part 'home_viewmodel.g.dart';

sealed class HomeState extends Equatable {
  final String query;
  const HomeState(this.query);

  HomeState copyWith(String? query) {
    return switch (this) {
      HomeReadyState(:final forcasts) => HomeReadyState(
        query ?? this.query,
        forcasts,
      ),
      HomeLoadingState() => HomeLoadingState(query ?? this.query),
      HomeErrorState(:final error) => HomeErrorState(
        error,
        query ?? this.query,
      ),
    };
  }

  @override
  List<Object?> get props => [query];
}

class HomeReadyState extends HomeState {
  final List<CityForcast> forcasts;

  const HomeReadyState(super.query, this.forcasts);
  @override
  List<Object?> get props => [...super.props, forcasts];
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState(super.query);
}

class HomeErrorState extends HomeState {
  final AppError error;
  const HomeErrorState(this.error, super.query);
  @override
  List<Object?> get props => [...super.props, error];
}

final searchTextProvider = StateProvider<String>((Ref ref) {
  return '';
});

@riverpod
List<TaiwanCity> cityFilters(Ref ref, String q) {
  final queries = q.trim().replaceAll("台", "臺").split(" ");
  return queries
      .map(
        (q) => TaiwanCity.values.where(
          (city) => q.isNotEmpty && city.name.startsWith(q),
        ),
      )
      .expand((e) => e)
      .toSet()
      .toList();
}

@riverpod
Future<List<CityForcast>> debouncedSearchForcast(
  Ref ref,
  List<TaiwanCity> cities,
) async {
  if (cities.isEmpty) {
    return List.empty();
  }
  var isDisposed = false;
  ref.onDispose(() => isDisposed = true);
  await Future.delayed(
    Duration(milliseconds: getIt<AppConfig>().debounceMilliSec),
  );
  if (isDisposed) {
    throw Exception("canceled");
  }
  return ref.watch(forcastsNext36HoursProvider(cities).future);
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  void searchByText(String text) {
    ref.read(searchTextProvider.notifier).state = text;
  }

  void refresh() {
    ref.invalidate(forcastsNext36HoursProvider);
  }

  @override
  HomeState build() {
    final q = ref.watch(searchTextProvider);
    final cities = ref.watch(cityFiltersProvider(q));
    final r = ref.watch(debouncedSearchForcastProvider(cities));
    return r.map(
      data: (d) => HomeReadyState(q, d.value),
      error:
          (e) =>
              e.isLoading
                  ? HomeLoadingState(q)
                  : HomeErrorState(e.error as AppError, q),
      loading: (l) => HomeLoadingState(q),
    );
  }
}
