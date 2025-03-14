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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: SingleChildScrollView(
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
                    ElevatedButton(
                      onPressed: () {
                        print("Button Pressed!");
                      },
                      child: Icon(
                        Icons.menu,
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
                    ElevatedButton(
                      onPressed: () {
                        print("Button Pressed!");
                      },
                      child: Icon(
                        Icons.account_circle,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.thumb_up, color: Colors.white),
                      onPressed: () {
                        print("Button Pressed!");
                      },
                      label: Text("Workshop"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("Button Pressed!");
                      },
                      child: Text("Tutorial"),
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
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sciences",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Physics",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ScrollableButtonList(
                      items: [
                        "Gravity 1",
                        "Gravity 2",
                        "Gravity 3",
                        "Gravity 3",
                        "Gravity 3"
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Text(
                      "Biology",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ScrollableButtonList(
                      items: [
                        "Gravity 1",
                        "Gravity 2",
                        "Gravity 3",
                        "Gravity 3",
                        "Gravity 3"
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Language",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Chinese",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ScrollableButtonList(
                      items: [
                        "Gravity 1",
                        "Gravity 2",
                        "Gravity 3",
                        "Gravity 3",
                        "Gravity 3"
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
            child: ElevatedButton(
              onPressed: () {
                print("$item Clicked");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Light grey color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
              child: Text(
                item,
                style: TextStyle(color: Colors.black), // Text color
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
