import 'package:flutter/material.dart';
import 'package:ilearn/second_screen.dart';

// StatefulWidget: Used for widgets that can change state
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// State class for MyHomePage
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
                Container(
                  height: 50,
                  color: Colors.purple,
                ),
                Container(
                  color: const Color.fromARGB(255, 250, 221, 255),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          print("Button Pressed!");
                        },
                        icon: Icon(
                          Icons.menu,
                          size: 50,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () {
                            print("Button Pressed!");
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.search,
                                ),
                              ]),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          print("Button Pressed!");
                        },
                        icon: Icon(
                          size: 50,
                          Icons.account_circle,
                        ),
                      )
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
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sciences",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Physics",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      ScrollableButtonList(
                        items: [
                          "Gravity 1",
                          "Gravity 2",
                          "Force 1",
                          "Force 2",
                          "Electromagnetic"
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 10),
                      Text(
                        "Biology",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      ScrollableButtonList(
                        items: [
                          "Photosynthesis",
                          "Cell Organisation",
                          "Nutrition",
                          "Reproduction",
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Language",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "English",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      ScrollableButtonList(
                        items: [
                          "Pronunciation",
                          "Grammar 1",
                          "Grammar 2",
                          "Grammar 3",
                          "Formal Writing"
                        ],
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

// StatelessWidget: Used for widgets that don't change state
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
                child: Text(
                  item,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
