import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final _textController = TextEditingController();
  String expression = "";

  
  final List<String> lstSymbols = [
    "C", "/", "*", "<-",
    "7", "8", "9", "+",
    "4", "5", "6", "-",
    "1", "2", "3", "=",
    "%", "0", ".", "",
  ];

  void _onButtonPressed(String symbol) {
    setState(() {
      if (symbol == "C") {
        expression = "";
        _textController.text = "";
      } else if (symbol == "<-") {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
          _textController.text = expression;
        }
      } else if (symbol == "=") {
        try {
          final result = _evaluateExpression(expression);
          expression = result.toString();
          _textController.text = expression;
        } catch (e) {
          _textController.text = "Error";
        }
      } else {
        expression += symbol;
        _textController.text = expression;
      }
    });
  }

  double _evaluateExpression(String expr) {
    try {
      final sanitizedExpr = expr.replaceAll('×', '*').replaceAll('÷', '/');
      Parser parser = Parser();
      Expression parsedExpression = parser.parse(sanitizedExpr);
      ContextModel contextModel = ContextModel();
      return parsedExpression.evaluate(EvaluationType.REAL, contextModel);
    } catch (e) {
      throw Exception("Invalid expression");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              readOnly: true,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: lstSymbols.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: lstSymbols[index].isNotEmpty
                        ? () => _onButtonPressed(lstSymbols[index])
                        : null,
                    child: Text(
                      lstSymbols[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

