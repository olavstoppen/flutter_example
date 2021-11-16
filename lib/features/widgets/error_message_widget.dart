import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onPressed;

  const ErrorMessageWidget({
    Key? key,
    required this.errorMessage,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(errorMessage),
          const SizedBox(height: 16.0,),
          TextButton(onPressed: onPressed, child: const Text("Retry"))
        ],
      ),
    );
  }
}
