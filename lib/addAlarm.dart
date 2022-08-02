import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddAlarm extends StatelessWidget {
  const AddAlarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Alarm Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}