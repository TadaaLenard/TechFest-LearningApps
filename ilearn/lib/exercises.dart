import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

String _apiKey = dotenv.env['GeminiAPI']!;
final model = GenerativeModel(
  model: 'gemini-1.5-flash-latest',
  apiKey: _apiKey,
);
String? questions;
String? answer;

class ExerciseScreen extends StatefulWidget {
  final String itemName;

  const ExerciseScreen({super.key, required this.itemName});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final PageController pageController = PageController();
  List<bool> flippedStates =
      List.generate(10, (index) => false); // Tracks flip state per card

  @override
  void initState() {
    super.initState();
    generateQnA();
  }

  void generateQnA() async {
    final prompt = 'Write a story about a magic backpack.';
    final content = [Content.text(prompt)];
    questions = (await model.generateContent(content)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Question 1",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade700,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 10, // Example number of questions
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      flippedStates[index] =
                          !flippedStates[index]; // Toggle flip state
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (widget, animation) {
                      return RotationYTransition(
                        turns: animation,
                        child: widget,
                      );
                    },
                    child: flippedStates[index]
                        ? _buildAnswerCard(index) // Front (Answer)
                        : _buildBackCard(index), // Back (Tap to Reveal)
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard(int index) {
    return _buildCard(
      text: "Tap to Reveal",
      color: Colors.purple.shade200,
    );
  }

  Widget _buildAnswerCard(int index) {
    return _buildCard(
      text: "Answer ${index + 1}",
      color: Colors.purple.shade50,
    );
  }

  Widget _buildCard({required String text, required Color color}) {
    return Container(
      key: ValueKey(text), // Ensures proper animation when flipping
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Flip animation helper
class RotationYTransition extends AnimatedWidget {
  final Widget child;
  final Animation<double> turns;

  const RotationYTransition(
      {required this.child, required this.turns, Key? key})
      : super(key: key, listenable: turns);

  @override
  Widget build(BuildContext context) {
    final value = turns.value * 3.1415927; // Convert turns to radians
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(value),
      child: value > 1.57
          ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1415927),
              child: child,
            )
          : child,
    );
  }
}
