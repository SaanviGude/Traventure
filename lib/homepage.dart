import 'package:flutter/material.dart';
import 'profile.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          backgroundColor: Color(0xFF235537),
          actions: <Widget>[
      // Menu button moved to actions to avoid overflow
      Padding(padding: EdgeInsets.only(right:280),
      child: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer when tapped
            },
          );
        },
      ),),
            IconButton(onPressed: (){ showSearch(context: context, delegate: CustomSearchDelegate());
            }, icon: Icon(Icons.search)),//Icon(Icons.account_circle
            IconButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage())
            );}, icon: const Icon(Icons.account_circle_sharp),
          ),
                ],



        /* title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey,  ,),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
           /* GestureDetector( // Make the profile icon clickable
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                  );
                },
                child: Icon(Icons.account_circle),
              ),*/
            ],
          ),
        ),*/
      ),
      drawer: Drawer(
          backgroundColor: Color(0xFFDCD0A1),
          child: ListView(
              children: [
                ListTile(
                  title: const Text('item1'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                ),

                ListTile(title: const Text('item1'),
                    onTap:(){
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()), // Navigate to ProfilePage
                      );
                    }

                )
              ]


          )
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 6, // Number of items/cards
          itemBuilder: (context, index) {
            return TripCard();
          },
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'goa wonders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '25,000/-',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '3 days | 29 sep',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 5),
                    Text(
                      '3.5',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'recommended',
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 12,
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




class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'goa wonders',
    'hidden gem',
    'sunset',
    'beaches',
    'Old goa',
    'Sight seeing',
    'small packages',
    'trekking',
  ];

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
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}