import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

extension ProviderContainerTestSuit on ProviderContainer {
  T readWithoutDisposed<T>(ProviderListenable<T> provider) {
    // A provider without any listener will be immediately disposed upon value being read
    // as discussed at thread: https://github.com/rrousselGit/riverpod/issues/1329
    // To overcome it during testing, add a listener to the provider before read its value.
    listen(provider, (_, __) {});
    return read(provider);
  }

  expectProviderState<State>(ProviderListenable<State> provider, State state) async {
    State? s;
    final matcher = equals(state);
    int count = 3;
    bool isMatched = false;
    listen(provider, (_, _) {});
    while (!isMatched && count > 0) {
      s = read(provider);
      isMatched = matcher.matches(s, {});
      if (isMatched) {
        return;
      }
      await Future.delayed(Duration(microseconds: 50));
      count--;
    }
    fail("Actual state is $s not $state");
  }
}
