import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TranslationProvider with ChangeNotifier {
  String _selectedLanguage = 'si'; // Default: Sinhala
  final Map<String, String> _cache = {};

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String langCode) {
    _selectedLanguage = langCode;
    notifyListeners();
  }

  Future<String> translate(String text) async {
    if (_selectedLanguage == 'si') return text;

    final cacheKey = '${_selectedLanguage}_$text';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=en',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key':
              '7KsCqKVrisGPT3Y4n7dmky8E5upRKY58LRgvadcwsUrCLBQqYq1MJQQJ99BEACmepeSXJ3w3AAAbACOGlm4E',
          'Ocp-Apim-Subscription-Region': 'uksouth',
          'Content-Type': 'application/json',
        },
        body: jsonEncode([
          {'Text': text},
        ]),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translatedText = data[0]['translations'][0]['text'];
        _cache[cacheKey] = translatedText;

        return translatedText;
      } else {
        debugPrint('Translation failed: ${response.body}');
        return text;
      }
    } catch (e) {
      debugPrint('Translation error: $e');
      return text;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //batch
  Future<Map<String, String>> translateAll(List<String> texts) async {
    final Map<String, String> translatedMap = {};
    final List<Map<String, String>> body = [];

    for (String text in texts) {
      final cacheKey = '${_selectedLanguage}_$text';
      if (_cache.containsKey(cacheKey)) {
        translatedMap[text] = _cache[cacheKey]!;
      } else {
        body.add({'Text': text});
      }
    }

    if (body.isEmpty || _selectedLanguage == 'si') {
      return translatedMap..addEntries(texts.map((t) => MapEntry(t, t)));
    }

    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=$_selectedLanguage',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Ocp-Apim-Subscription-Key':
              '7KsCqKVrisGPT3Y4n7dmky8E5upRKY58LRgvadcwsUrCLBQqYq1MJQQJ99BEACmepeSXJ3w3AAAbACOGlm4E',
          'Ocp-Apim-Subscription-Region': 'uksouth',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        int i = 0;
        for (final result in data) {
          final originalText = body[i]['Text']!;
          final translatedText = result['translations'][0]['text'];
          final cacheKey = '${_selectedLanguage}_$originalText';
          _cache[cacheKey] = translatedText;
          translatedMap[originalText] = translatedText;
          i++;
        }
      }
    } catch (e) {
      debugPrint('Translation error: $e');
    }

    _isLoading = false;
    notifyListeners();

    return translatedMap;
  }
}
