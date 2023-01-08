import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  final String message;

  const InformationWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
