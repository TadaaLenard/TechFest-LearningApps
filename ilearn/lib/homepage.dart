import 'package:flutter/material.dart';
import 'package:ilearn/search.dart';
import 'package:ilearn/second_screen.dart';

// ✅ Organized topic data
final Map<String, List<String>> topicData = {
  "Physics": [
    "Gravity 1",
    "Gravity 2",
    "Force 1",
    "Force 2",
    "Electromagnetic",
  ],
  "Biology": [
    "Photosynthesis",
    "Cell Organisation",
    "Nutrition",
    "Reproduction",
  ],
  "English": [
    "Pronunciation",
    "Grammar 1",
    "Grammar 2",
    "Grammar 3",
    "Formal Writing",
  ],
};

// 🔲 Main Home Page
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final allItems = topicData.values.expand((list) => list).toList();

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
                                builder: (context) =>
                                    SearchScreen(items: allItems),
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
                          onPressed: () {},
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
                            print("Button Pressed!");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Column(children: [
                            Icon(Icons.video_call_rounded,
                                color: Colors.purple, size: 70),
                            SizedBox(height: 4),
                            Text("Tutorial")
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.black, thickness: 1, height: 20),

                // ✅ Sciences
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionTitle("Sciences"),
                      CategorySection("Physics", topicData["Physics"]!),
                      CategorySection("Biology", topicData["Biology"]!),

                      // ✅ Language
                      SectionTitle("Language"),
                      CategorySection("English", topicData["English"]!),
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

// 🔲 Scrollable horizontal button list
class ScrollableButtonList extends StatelessWidget {
  final List<String> items;

  const ScrollableButtonList({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FactScreen(itemName: item),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 234, 234),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(item, style: TextStyle(color: Colors.black)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 🔲 Reusable section title widget
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

// 🔲 Reusable category + list widget
Widget CategorySection(String categoryName, List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        categoryName,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 10),
      ScrollableButtonList(items: items),
      SizedBox(height: 20),
    ],
  );
}
