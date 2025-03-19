import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather_flutter/ui/components/app_error_view.dart';
import 'package:the_weather_flutter/ui/components/weather_forcasts_card.dart';
import 'package:the_weather_flutter/ui/home_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: SearchBar(
                autoFocus: true,
                onSubmitted:
                    (text) => {
                      ref
                          .read(homeViewModelProvider.notifier)
                          .searchByText(text),
                    },
                hintText: "輸入城市查詢天氣, (ex: 台北市, 新北市, 桃園市, ...",
              ),
            ),
            Expanded(
              child: switch (state) {
                HomeReadyState(:final forcasts) =>
                  forcasts.isNotEmpty
                      ? ListView.separated(
                        itemCount: forcasts.length,
                        itemBuilder:
                            (ctx, i) => WeatherForcastsCard(forcasts[i]),
                        separatorBuilder: (_, i) => const SizedBox(height: 16),
                      )
                      : Center(
                        child: Text(
                          state.query.isNotEmpty
                              ? "無法找到與 `${state.query}` 有關的天氣預報, 請重新搜索。"
                              : "鍵入搜尋欄開始搜尋台灣各城市天氣預報",
                        ),
                      ),
                HomeErrorState(:final error) => Center(
                  child: AppErrorView(
                    error,
                    onRetry: () {
                      ref.read(homeViewModelProvider.notifier).refresh();
                    },
                  ),
                ),
                _ => Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}
