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
import 'package:the_weather_flutter/api/weather_dio.dart' as _i813;
import 'package:the_weather_flutter/app_config.dart' as _i902;

import '../mock/app_config.dart' as _i403;
import '../mock/weather_api.dart' as _i213;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> initTest({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i902.AppConfig>(
      () => _i403.MockAppConfig(),
      registerFor: {_test},
    );
    gh.singleton<_i143.WeatherAPI>(
      () => _i213.MockWeatherAPI(),
      registerFor: {_test},
    );
    await gh.factoryAsync<_i902.AppConfig>(
      () => _i902.AppConfig.create(),
      registerFor: {_dev, _prod},
      preResolve: true,
    );
    gh.singleton<_i143.WeatherAPI>(
      () => _i813.WeatherDio(gh<_i902.AppConfig>()),
      registerFor: {_dev, _prod},
    );
    return this;
  }
}
