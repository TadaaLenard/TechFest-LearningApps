import 'package:flutter/material.dart';

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
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
              textStyle:
                  TextStyle(fontSize: 20), // Change only for this Scaffold
            ),
          ),
        ),
        child: SingleChildScrollView(
          // Makes the screen scrollable
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50, // Set height
                  color: Colors.purple, // Set background color
                ),
                Container(
                  color: const Color.fromARGB(
                      255, 250, 221, 255), // Background color for the row
                  padding: EdgeInsets.all(10), // Optional padding
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
                          color: Colors.black, // Adjust color as needed
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
                                vertical: 12, horizontal: 16), // Adjust padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16), // Adjust border radius
                            ),
                          ),
                          child: const Column(
                            mainAxisSize:
                                MainAxisSize.min, // Keep button compact
                            children: [
                              Icon(Icons.desk_rounded,
                                  color: Colors.purple,
                                  size: 70), // Adjust size if needed
                              SizedBox(
                                  height: 4), // Space between icon and text
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
                                vertical: 12, horizontal: 16), // Adjust padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  16), // Adjust border radius
                            ),
                          ),
                          child: const Column(children: [
                            Icon(Icons.video_call_rounded,
                                color: Colors.purple,
                                size: 70), // Adjust size if needed
                            SizedBox(height: 4), Text("Tutorial")
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black, // Line color
                  thickness: 1, // Line thickness
                  height: 20, // Space around the divider
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

class ScrollableButtonList extends StatelessWidget {
  final List<String> items;

  ScrollableButtonList({required this.items});

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
                  print("$item Clicked");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 255, 234, 234), // Light grey color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                child: Text(
                  item,
                  style: TextStyle(color: Colors.black), // Text color
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
