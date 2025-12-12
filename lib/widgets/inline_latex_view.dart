import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class InlineLatexText extends StatelessWidget {
  final String input;
  final double fontSize;
  final Color textColor;

  const InlineLatexText({super.key, required this.input, this.fontSize = 16.0, this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    final parts = _parseText(input);

    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: parts,
    );
  }

  List<Widget> _parseText(String text) {
    final regex = RegExp(r'\$\$(.*?)\$\$', dotAll: true);
    final matches = regex.allMatches(text);

    List<Widget> widgets = [];
    int lastIndex = 0;

    for (var match in matches) {
      // Normal text before $$...$$
      if (match.start > lastIndex) {
        final normal = text.substring(lastIndex, match.start);
        widgets.add(_text(normal));
      }

      // LaTeX part
      final latex = match.group(1)?.trim();
      if (latex != null) {
        widgets.add(_latex(latex));
      }

      lastIndex = match.end;
    }

    // Remaining normal text
    if (lastIndex < text.length) {
      widgets.add(_text(text.substring(lastIndex)));
    }

    return widgets;
  }

  Widget _text(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
    );
  }

  Widget _latex(String code) {
    return Math.tex(
      code,
      mathStyle: MathStyle.text,
      textStyle: TextStyle(fontSize: fontSize, color: textColor),
    );
  }
}
