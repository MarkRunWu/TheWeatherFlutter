import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather_flutter/ui/components/weather_forcasts_card.dart';
import 'package:the_weather_flutter/ui/home_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeStateProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: SearchBar(
                autoFocus: true,
                onSubmitted:
                    (text) => {HomeStateHandler.searchByText(ref, text)},
                hintText: "輸入城市查詢天氣, (ex: 台北市, 新北市, 桃園市, ...",
              ),
            ),
            switch (state) {
              HomeReadyState(:final forcasts) => Expanded(
                child:
                    forcasts.isNotEmpty
                        ? ListView.separated(
                          itemCount: forcasts.length,
                          itemBuilder:
                              (ctx, i) => WeatherForcastsCard(forcasts[i]),
                          separatorBuilder:
                              (_, i) => const SizedBox(height: 16),
                        )
                        : Center(
                          child: Text(
                            state.query.isNotEmpty
                                ? "No query result for `${state.query}`"
                                : "Type search bar to query weather",
                          ),
                        ),
              ),
              HomeErrorState(:final error) => Text("Error $error"),
              _ => Center(child: CircularProgressIndicator()),
            },
          ],
        ),
      ),
    );
  }
}
