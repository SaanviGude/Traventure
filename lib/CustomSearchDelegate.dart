class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchTerms;

  CustomSearchDelegate({required this.searchTerms});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFE1C767), // Custom background color of the search bar
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: Colors.black, // Search text color
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.black), // Hint text color
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black, // Cursor color in the search box
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.green, // Change the text color of the result
              fontWeight: FontWeight.bold,
            ),
          ),
          tileColor: Colors.white, // Change the background color of the result item
          onTap: () {
            close(context, result); // Select the search result and close search
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var term in searchTerms) {
      if (term.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(term);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(
              color: Colors.black, // Change the text color of the suggestion
            ),
          ),
          tileColor: Color(0xFFEEE2B3), // Change the background color of the suggestion item
          onTap: () {
            close(context, result); // Close search and return the selected result
          },
        );
      },
    );
  }
}
