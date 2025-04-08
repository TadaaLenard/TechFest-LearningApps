import 'package:flutter/material.dart';
import 'package:ilearn/exercises.dart';

class FactScreen extends StatelessWidget {
  final String itemName;
  final List<String> facts;

  const FactScreen({
    Key? key,
    required this.itemName,
    required this.facts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
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
            ),
          ),
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
                        Text(
                          "Fact ${index + 1} of ${facts.length}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade700,
                          ),
                        ),
                        const SizedBox(height: 20),
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
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
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
                SizedBox(
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
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
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
