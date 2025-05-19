import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'translation_provider.dart';

class TranslatableText extends StatelessWidget {
  final String originalText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatableText(
    this.originalText, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);

    return FutureBuilder<String>(
      future: provider.translate(originalText),
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? originalText,
          style: style,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        );
      },
    );
  }
}

class TranslationLoadingOverlay extends StatelessWidget {
  final Widget child;

  const TranslationLoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Consumer<TranslationProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Container(
                color: Colors.white.withOpacity(0.8),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
