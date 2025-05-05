import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'language_provider.dart';
import 'package:provider/provider.dart';

class AzureTranslator {
  static const String endpoint =
      'https://api.cognitive.microsofttranslator.com';
  static const String apiKey =
      '7KsCqKVrisGPT3Y4n7dmky8E5upRKY58LRgvadcwsUrCLBQqYq1MJQQJ99BEACmepeSXJ3w3AAAbACOGlm4E';
  static const String location = 'uksouth';

  static Future<String> translateText(String text, String toLang) async {
    final uri = Uri.parse('$endpoint/translate?api-version=3.0&to=$toLang');

    final response = await http.post(
      uri,
      headers: {
        'Ocp-Apim-Subscription-Key': apiKey,
        'Ocp-Apim-Subscription-Region': location,
        'Content-Type': 'application/json',
      },
      body: jsonEncode([
        {'Text': text},
      ]),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data[0]['translations'][0]['text'];
    } else {
      throw Exception('Translation failed: ${response.body}');
    }
  }
}

// ✅ Helper method to auto-translate using current language from provider
Future<String> translate(BuildContext context, String text) async {
  final langCode = context.read<LanguageProvider>().languageCode;

  // 🔁 Your default text is in Sinhala, so don't translate if selected language is Sinhala
  if (langCode == 'si') return text;

  try {
    return await AzureTranslator.translateText(text, langCode);
  } catch (e) {
    print('Translation error: $e');
    return text; // fallback
  }
}
