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
}
