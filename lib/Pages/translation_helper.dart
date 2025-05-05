import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';
import 'trans.dart'; // Assuming this contains AzureTranslator

// Translates a map of labels if the current language is English
Future<Map<String, String>> translateLabels(
  BuildContext context,
  Map<String, String> labels,
) async {
  final langCode = context.read<LanguageProvider>().languageCode;

  if (langCode == 'en') {
    List<String> keys = labels.keys.toList();
    List<String> values = labels.values.toList();

    List<String> translated = await Future.wait(
      values.map((text) => AzureTranslator.translateText(text, 'en')),
    );

    return Map.fromIterables(keys, translated);
  } else {
    return labels;
  }
}

// Translates a single string based on the current language using dummy map
Future<String> translate(BuildContext context, String text) async {
  final langCode = context.read<LanguageProvider>().languageCode;

  if (langCode == 'en') {
    Map<String, String> dummyTranslations = {
      "තාක්ෂණික සහාය": "Technical Support",
      "ආරක්ෂාව": "Security",
      "උපකාරකය": "Assistant",
    };
    return dummyTranslations[text] ?? text;
  } else {
    return text;
  }
}
