import 'package:flutter/material.dart';
import 'package:ilearn/second_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<String> items;
  final Map<String, List<String>>
      factsByTopic; // To store descriptions of the topic after passed from the homepage.

  const SearchScreen(
      {Key? key, required this.items, required this.factsByTopic})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems =
        List.from(widget.items); // Initialise to display all topics
    _searchController.addListener(
        _onSearchChanged); // Perform the method when the controller value changes
  }

  // Function that manages user input in searching topics
  // Changes the filtered items based on user input
  void _onSearchChanged() {
    setState(() {
      _filteredItems = widget.items
          .where((item) =>
              item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTap(String item) {
    // Fetch the corresponding facts for the selected item
    final facts =
        widget.factsByTopic[item] ?? ["No facts available for this topic."];

    // Navigate to FactScreen, passing itemName and facts
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FactScreen(
          itemName: item,
          facts: facts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "What topics are you interested in?",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredItems.isNotEmpty
                  ? ListView.builder(
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return Card(
                          child: ListTile(
                            title: Text(item),
                            onTap: () => _onItemTap(item),
                          ),
                        );
                      },
                    )
                  : Center(child: Text("No results found")),
            ),
          ],
        ),
      ),
    );
  }
}
