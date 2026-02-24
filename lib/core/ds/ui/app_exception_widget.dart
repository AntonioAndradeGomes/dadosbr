import 'package:dadosbr/core/errors/app_exception.dart';
import 'package:flutter/material.dart';

class AppExceptionWidget extends StatelessWidget {
  final AppException exception;
  const AppExceptionWidget({super.key, required this.exception});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Icon(Icons.error, color: Theme.of(context).colorScheme.error, size: 48),
        Text(
          exception.message,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}
