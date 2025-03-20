import 'package:flutter_test/flutter_test.dart';

import 'utils/injectable.dart';

void setup() {
  setUpAll(() {
    configureTestDependencies();
  });
  tearDown(() {
    resetMockAPI();
  });
}
