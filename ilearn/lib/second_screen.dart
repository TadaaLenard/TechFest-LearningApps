import 'package:flutter/material.dart';
import 'package:ilearn/exercises.dart';

// StatelessWidget: Facts screen that displays facts with swipe functionality
class FactScreen extends StatelessWidget {
  final String itemName;

  const FactScreen({Key? key, required this.itemName}) : super(key: key);

  // Define facts for each topic
  Map<String, List<String>> get factsByTopic => {
        // Physics facts
        "Gravity 1": [
          "Gravity is a force that attracts objects with mass toward one another. The more mass an object has, the stronger its gravitational pull.",
          "On Earth, gravity causes objects to accelerate toward the ground at approximately 9.8 m/s².",
          "Sir Isaac Newton formulated the law of universal gravitation in the 17th century, though the concept was later refined by Einstein's theory of general relativity."
        ],
        "Gravity 2": [
          "Einstein's theory of general relativity describes gravity as a curvature of spacetime caused by mass and energy.",
          "Black holes have gravity so strong that not even light can escape once it passes the event horizon.",
          "Gravitational waves, ripples in spacetime caused by violent cosmic events, were first detected in 2015, confirming a major prediction of general relativity."
        ],
        "Force 1": [
          "Force is defined as any interaction that, when unopposed, changes the motion of an object.",
          "Force is a vector quantity, having both magnitude and direction.",
          "Newton's Second Law states that force equals mass times acceleration (F = ma)."
        ],
        "Force 2": [
          "The four fundamental forces in nature are gravity, electromagnetism, strong nuclear force, and weak nuclear force.",
          "Friction is a force that opposes the relative motion of two surfaces in contact.",
          "According to Newton's Third Law, for every action force there is an equal and opposite reaction force."
        ],
        "Electromagnetic": [
          "Electromagnetism is one of the four fundamental forces and includes both electric and magnetic phenomena.",
          "Light is an electromagnetic wave that travels at approximately 300,000 kilometers per second in vacuum.",
          "Electromagnetic forces are responsible for chemical bonds, electricity, and magnetism."
        ],

        // Biology facts
        "Photosynthesis": [
          "Photosynthesis is the process by which plants use sunlight, water, and carbon dioxide to create oxygen and energy in the form of sugar.",
          "The green pigment chlorophyll is essential for capturing light energy during photosynthesis.",
          "Photosynthesis takes place in the chloroplasts, primarily in plant leaves."
        ],
        "Cell Organisation": [
          "Cells are the basic structural and functional units of all living organisms.",
          "Eukaryotic cells contain membrane-bound organelles, while prokaryotic cells do not.",
          "The cell membrane regulates what enters and exits the cell through various transport mechanisms."
        ],
        "Nutrition": [
          "Nutrition is the process of consuming food and utilizing it for growth, metabolism, and repair.",
          "The six essential nutrients are carbohydrates, proteins, fats, vitamins, minerals, and water.",
          "Malnutrition can result from consuming either too few or too many nutrients."
        ],
        "Reproduction": [
          "Reproduction is the biological process by which new individual organisms are produced.",
          "Sexual reproduction involves the combination of genetic material from two parents.",
          "Asexual reproduction produces offspring that are genetically identical to the parent."
        ],

        // English facts
        "Pronunciation": [
          "English pronunciation varies widely across different regions and countries.",
          "The 'th' sound (as in 'think' or 'the') is one of the most difficult sounds for non-native English speakers to master.",
          "English has approximately 44 distinct phonemes (sound units), including 20 vowel sounds and 24 consonant sounds."
        ],
        "Grammar 1": [
          "English has 8 parts of speech: nouns, pronouns, verbs, adjectives, adverbs, prepositions, conjunctions, and interjections.",
          "Subject-verb agreement is a fundamental rule in English grammar.",
          "English relies heavily on word order to convey meaning, typically following a subject-verb-object pattern."
        ],
        "Grammar 2": [
          "There are 12 major verb tenses in English, combining past, present, and future with simple, continuous, perfect, and perfect continuous forms.",
          "Modal verbs (can, could, may, might, must, shall, should, will, would) express necessity, possibility, permission, or obligation.",
          "Articles (a, an, the) are used to indicate whether a noun refers to something specific or general."
        ],
        "Grammar 3": [
          "Conditionals in English express hypothetical situations and their consequences.",
          "The passive voice emphasizes the action's recipient rather than the performer.",
          "Reported speech is used to communicate what someone else said without using their exact words."
        ],
        "Formal Writing": [
          "Formal writing avoids contractions, slang, and colloquial expressions.",
          "Passive voice is often used in formal writing to maintain an objective tone.",
          "Clear paragraph structure with topic sentences is essential in formal writing."
        ],
      };

  @override
  Widget build(BuildContext context) {
    // Get the appropriate facts for the selected item
    final facts =
        factsByTopic[itemName] ?? ["No facts available for this topic."];

    // Create a PageController for swiping between facts
    final PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Column(
        children: [
          // Fact display area with PageView for swiping
          Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseScreen(itemName: itemName),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book),
                label: const Text("Exercises"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple.shade100,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              )),

          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: facts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Fact number indicator

                        Text(
                          "Fact ${index + 1} of ${facts.length}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // The fact text
                        Text(
                          facts[index],
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Navigation controls
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous button
                Container(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (pageController.page! > 0) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Previous"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade100,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ),

                // Next button
                Container(
                  width: 130,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (pageController.page! < facts.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    label: const Text("Next"),
                    icon: const Icon(Icons.arrow_forward),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade100,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
