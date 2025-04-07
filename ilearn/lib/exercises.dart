import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

String _apiKey = dotenv.env['GeminiAPI'] ?? 'default_api_key';

final model = GenerativeModel(
  model: 'gemini-1.5-flash-latest',
  apiKey: _apiKey,
);

String? question;
String? answer;

class ExerciseScreen extends StatefulWidget {
  final String itemName;

  const ExerciseScreen({super.key, required this.itemName});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final PageController pageController = PageController();
  List<bool> flippedStates = List.generate(10, (index) => false);

  @override
  void initState() {
    super.initState();
    generateQnA();
  }

  void generateQnA() async {
    try {
      // Request for the question
      final questionResponse = await model.generateContent(
          [Content.text('Generate a question about ${widget.itemName}.')]);

      setState(() {
        question = questionResponse.text ?? "No question generated.";
      });

      // Use the generated question as a prompt for the answer
      if (question != null && question!.isNotEmpty) {
        final answerResponse = await model.generateContent([
          Content.text(
              'Provide the correct answer to the following question: $question')
        ]);

        setState(() {
          answer = answerResponse.text ?? "No answer generated.";
        });
      } else {
        setState(() {
          answer = "Failed to generate a valid question.";
        });
      }
    } catch (e) {
      setState(() {
        question = "Failed to generate question.";
        answer = "Failed to generate answer.";
      });
    }
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
          // Check if the question and answer are ready
          question == null || answer == null
              ? CircularProgressIndicator() // Show loading indicator
              : Text(
                  question ?? "Generating question...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 10, // Example number of questions
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      flippedStates[index] = !flippedStates[index];
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (widget, animation) {
                      return RotationYTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(animation),
                        child: widget,
                      );
                    },
                    child: flippedStates[index]
                        ? _buildAnswerCard(index)
                        : _buildBackCard(index),
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
      key: ValueKey("back_$index"),
      text: "Tap to Reveal",
      color: Colors.purple.shade200,
    );
  }

  Widget _buildAnswerCard(int index) {
    return _buildCard(
      key: ValueKey("answer_$index"),
      text: answer ?? "Answer not available",
      color: Colors.purple.shade50,
    );
  }

  Widget _buildCard(
      {required Key key, required String text, required Color color}) {
    return Container(
      key: key,
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
        child: SingleChildScrollView(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify, // Justified text
          ),
        ),
      ),
    );
  }
}

// Flip animation helper
class RotationYTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> turns;

  const RotationYTransition(
      {required this.child, required this.turns, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: turns,
      builder: (context, child) {
        final angle = turns.value * 3.1415927;
        final isFlipped = turns.value > 0.5;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(angle),
          child: isFlipped
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.1415927),
                  child: child,
                )
              : child,
        );
      },
      child: child,
    );
  }
}
