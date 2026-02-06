import 'package:evently/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addEvent),

      ),
    );
  }
}
