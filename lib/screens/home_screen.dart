import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:latex_editor/widgets/inline_latex_view.dart';

class LatexMixedScreen extends StatefulWidget {
  const LatexMixedScreen({super.key});

  @override
  State<LatexMixedScreen> createState() => _LatexMixedScreenState();
}

class _LatexMixedScreenState extends State<LatexMixedScreen> {
  // Initial text
  final TextEditingController _controller = TextEditingController(
    text: r"",
  );

  String _currentText = r"";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mixed Text & LaTeX Editor"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- INPUT SECTION ---
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Input (Wrap latex in \$\$ ... \$\$):", 
                style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            TextField(controller: _controller,maxLines: 5,minLines: 3,
              decoration: const InputDecoration(border: OutlineInputBorder(),hintText: r'Example: This is text and $$ \sqrt{x} $$ is math.',),
              onChanged: (value) {
                setState(() {
                  _currentText = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // --- OUTPUT SECTION ---
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Output 1: Display Mode (Block)
                    _buildPreviewCard(
                      title: "Display Mode (Block)",
                      content: _currentText,
                      mathStyle: MathStyle.display,
                      description: "Math is rendered larger.",
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewCard({
    required String title,
    required String content,
    required MathStyle mathStyle,
    required String description,
  }) {
    return Card(elevation: 2,
      child: Padding(padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.indigo.shade50,borderRadius: BorderRadius.circular(4),border: Border.all(color: Colors.indigo.shade100),),
                  child: Text(mathStyle == MathStyle.display ? "Display" : "Text", style: TextStyle(fontSize: 10, color: Colors.indigo.shade900)),
                )
              ],
            ),
            Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            const Divider(height: 20),
            
            // --- THE PARSED OUTPUT ---
            Container(width: double.infinity,padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(4),),
              child: InlineLatexText(input: content)
            ),
          ],
        ),
      ),
    );
  }
}