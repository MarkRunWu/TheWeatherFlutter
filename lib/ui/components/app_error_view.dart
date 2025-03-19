import 'package:flutter/material.dart';
import 'package:the_weather_flutter/api/models/error.dart';

class AppErrorView extends StatelessWidget {
  final AppError error;
  final Function() onRetry;

  const AppErrorView(this.error, {required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(error.localizedMessage, textAlign: TextAlign.center),
          ElevatedButton(onPressed: onRetry, child: Text("Retry")),
        ],
      ),
    );
  }
}
