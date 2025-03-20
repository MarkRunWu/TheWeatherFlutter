// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:the_weather_flutter/api/weather.dart' as _i143;
import 'package:the_weather_flutter/app_config.dart' as _i902;

import '../mock/app_config.dart' as _i403;
import '../mock/weather_api.dart' as _i213;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initTest({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i143.WeatherAPI>(() => _i213.MockWeatherAPI());
    gh.singleton<_i902.AppConfig>(() => _i403.MockAppConfig());
    return this;
  }
}
