import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/ui/components/app_error_view.dart';
import 'package:the_weather_flutter/ui/components/weather_forcasts_card.dart';
import 'package:the_weather_flutter/ui/home_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  late TextEditingController _searchBarEditingController;

  @override
  void initState() {
    _searchBarEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchBarEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    ref.listen(
      homeViewModelProvider,
      (old, newState) => _searchBarEditingController.text = newState.query,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SearchBar(
                autoFocus: true,
                controller: _searchBarEditingController,
                onChanged:
                    (text) => {
                      ref
                          .read(homeViewModelProvider.notifier)
                          .searchByText(text),
                    },
                onSubmitted:
                    (text) => {
                      ref
                          .read(homeViewModelProvider.notifier)
                          .searchByText(text),
                    },
                hintText: "輸入城市查詢天氣, (ex: 台北市, 新北市, 桃園市, ...",
                trailing:
                    state.query.isNotEmpty
                        ? [
                          CloseButton(
                            onPressed: () {
                              ref
                                  .read(homeViewModelProvider.notifier)
                                  .searchByText("");
                            },
                          ),
                        ]
                        : null,
              ),
              SizedBox(height: 16),
              Expanded(
                child: switch (state) {
                  HomeReadyState(:final forcasts) =>
                    forcasts.isNotEmpty
                        ? ListView.separated(
                          itemCount: forcasts.length,
                          itemBuilder:
                              (ctx, i) => WeatherForcastsCard(forcasts[i]),
                          separatorBuilder:
                              (_, i) => const SizedBox(height: 16),
                        )
                        : _SearchHintView(),
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
      ),
    );
  }
}

class _SearchHintView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.query.isNotEmpty
                ? "無法找到與 `${state.query}` 有關的天氣預報, 請重新搜索。"
                : "鍵入搜尋欄開始搜尋台灣各城市天氣預報,\n 或點選建議城市:",
            textAlign: TextAlign.center,
          ),
          Wrap(
            children:
                TaiwanCity.values
                    .map(
                      (city) => ElevatedButton(
                        onPressed:
                            () => {
                              ref
                                  .read(homeViewModelProvider.notifier)
                                  .searchByText(city.name),
                            },
                        child: Text(city.name),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
