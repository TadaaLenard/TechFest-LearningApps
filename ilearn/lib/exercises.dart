import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Define a variable to store the Gemini API key loaded from .env file,
// If it is not avaiable, load a default api key,
// which is set to a string in this case since there is no default api key.
String _apiKey = dotenv.env['GeminiAPI'] ?? 'default_api_key';

// Define a model to store the selected Gemini model
final model = GenerativeModel(
  model: 'gemini-1.5-flash-latest',
  apiKey: _apiKey,
);

String? question;
String? userAnswer;
String? responseAnalysis;

class ExerciseScreen extends StatefulWidget {
  final String itemName;

  const ExerciseScreen({super.key, required this.itemName});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateQnA(); // Generate a questions provided by Gemini during initialisation
  }

  void generateQnA() async {
    try {
      // Request for the question
      final questionResponse = await model.generateContent([
        Content.text(
            'Generate an academic question about ${widget.itemName}. The number behind just represents the level of difficulty of the topic. Do not generate a question that is unrelated to the topic in terms of study. It should help the student to understand further about the topic.')
      ]);

      setState(() {
        question = questionResponse.text ?? "No question generated.";
        // Clear the answer and response when generating new content
        responseAnalysis = null;
        userAnswer = null;
      });
    } catch (e) {
      setState(() {
        question = "Failed to generate question.";
      });
    }
  }

  void analyzeAnswer() async {
    try {
      if (userAnswer != null && userAnswer!.isNotEmpty) {
        // Send the user input along with the question to analyze it
        final analysisResponse = await model.generateContent([
          Content.text(
              'Analyze the answer "$userAnswer" in relation to the question "$question" and provide feedback and correct answer. Do not criticize the user if the answer is not correct, just encourage the user if they are wrong.')
        ]);

        setState(() {
          responseAnalysis = analysisResponse.text ??
              "Analysis failed."; // Assign the response from Gemini
        });
      }
    } catch (e) {
      setState(() {
        responseAnalysis = "Error analyzing answer.";
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Check if the question is ready
            question == null
                ? const CircularProgressIndicator() // Show loading indicator
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      question ?? "Generating question...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                      textAlign: TextAlign.justify, // Justified question
                    ),
                  ),
            const SizedBox(height: 20),
            // Show user input for the answer only before submission
            if (responseAnalysis == null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _answerController,
                  decoration: InputDecoration(
                    labelText: 'Your Answer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      userAnswer = value;
                    });
                  },
                ),
              ),
            const SizedBox(height: 20),
            if (responseAnalysis == null) ...[
              ElevatedButton(
                onPressed: () {
                  analyzeAnswer();
                },
                child: const Text('Submit Answer'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
            const SizedBox(height: 20),
            // Show response analysis after submission
            if (responseAnalysis != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.purple.shade300,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  responseAnalysis ?? "No analysis available.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                  textAlign: TextAlign.justify, // Justified response
                ),
              ),
            ],
            // Display encouragement if the user hasn't answered yet or their answer is incorrect
            if (userAnswer == null ||
                userAnswer!.isEmpty ||
                responseAnalysis == "Error analyzing answer")
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'No worries if you didn\'t know the answer! Try your best, and I\'m here to help. You\'ll get there!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 20),
            // Refresh Button to generate new question and answer
            ElevatedButton(
              onPressed: () {
                setState(() {
                  question = null;
                  responseAnalysis = null;
                  userAnswer = null;
                  _answerController.clear(); // Clear the text input
                });
                generateQnA();
              },
              child: const Text('Generate New Question'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
