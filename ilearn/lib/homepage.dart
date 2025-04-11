import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilearn/search.dart';
import 'package:ilearn/second_screen.dart';
import 'package:ilearn/tutorials.dart';
import 'package:ilearn/workshop.dart';

// Define Topic class to store the topics object data
class Topic {
  final String category;
  final String name;
  final List<String> details;

  Topic({required this.category, required this.name, required this.details});

  // Create topic instance from loaded data
  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      category: json['category'],
      name: json['name'],
      details: List<String>.from(json['details']),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Topic> topicData = [];

  @override
  void initState() {
    super.initState();
    loadTopicData(); // Load topic data from JSON file during initialisation
  }

  Future<void> loadTopicData() async {
    // Load topic data from JSON file
    final String jsonString =
        await rootBundle.loadString('assets/data/topics.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    // Since there are different subjects, each subject has different categories,
    // each category has different topics, create topic instances for each topic
    // under different categories.
    List<Topic> topics = [];
    jsonMap.forEach((category, categoryData) {
      categoryData.forEach((topicName, details) {
        topics.add(Topic(
          category: category,
          name: topicName,
          details: List<String>.from(details),
        ));
      });
    });

    setState(() {
      topicData =
          topics; // Assign those topic instances into the topicData list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 20),
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 50, color: Colors.purple),
                Container(
                  color: const Color.fromARGB(255, 250, 221, 255),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                  items: topicData
                                      .map((topic) => topic.name)
                                      .toList(),
                                  factsByTopic: Map.fromIterable(
                                    topicData,
                                    key: (topic) => topic.name,
                                    value: (topic) => topic.details,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Icon(Icons.search)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkshopListScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.desk_rounded,
                                  color: Colors.purple, size: 70),
                              SizedBox(height: 4),
                              Text("Workshop"),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TutorialListScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.video_call_rounded,
                                  color: Colors.purple, size: 70),
                              SizedBox(height: 4),
                              Text("Tutorial")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 1, height: 20),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle("Sciences"),
                      CategorySection(
                        "Physics",
                        topicData
                            .where((topic) => topic.category == 'Physics')
                            .toList(),
                      ),
                      CategorySection(
                        "Biology",
                        topicData
                            .where((topic) => topic.category == 'Biology')
                            .toList(),
                      ),
                      SectionTitle("Language"),
                      CategorySection(
                        "English",
                        topicData
                            .where((topic) => topic.category == 'English')
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollableButtonList extends StatelessWidget {
  final List<Topic> topics;

  const ScrollableButtonList({required this.topics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: topics.map((topic) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FactScreen(
                        itemName: topic.name,
                        facts: topic.details, // 👈 Corrected line
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 234, 234),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(topic.name, style: TextStyle(color: Colors.black)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

Widget SectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}

Widget CategorySection(String categoryName, List<Topic> topics) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        categoryName,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
      ScrollableButtonList(topics: topics),
      SizedBox(height: 20),
    ],
  );
}
