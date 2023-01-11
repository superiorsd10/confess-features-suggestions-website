import 'package:confess_feature_suggestions/screens/thank_you.dart';
import 'package:confess_feature_suggestions/screens/write_suggestion.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Confess Feature Suggestions',
      home: WriteSuggestion(),
    );
  }
}
