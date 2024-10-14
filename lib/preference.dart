import 'package:flutter/material.dart';

class Preference extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<Preference> {
  // State variables for checkboxes
  bool budget1 = false;
  bool budget2 = false;
  bool budget3 = false;
  bool budget4 = false;
  bool veg = false;
  bool nonVeg = false;
  bool both = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preferences Header
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {},
                ),
                Text(
                  'PREFERENCES',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),

            SizedBox(height: 20),

            // Text Field for Type Your Need
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type your need',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Budget Section
            Text(
              'BUDGET',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            CheckboxListTile(
              title: Text('15000 - 25000/-'),
              value: budget1,
              onChanged: (bool? value) {
                setState(() {
                  budget1 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('25000 - 30000/-'),
              value: budget2,
              onChanged: (bool? value) {
                setState(() {
                  budget2 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('30000 - 40000/-'),
              value: budget3,
              onChanged: (bool? value) {
                setState(() {
                  budget3 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('40000/- and more'),
              value: budget4,
              onChanged: (bool? value) {
                setState(() {
                  budget4 = value!;
                });
              },
            ),

            SizedBox(height: 20),

            // Food Type Section
            Text(
              'FOOD TYPE',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            CheckboxListTile(
              title: Text('Veg'),
              value: veg,
              onChanged: (bool? value) {
                setState(() {
                  veg = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Non-Veg'),
              value: nonVeg,
              onChanged: (bool? value) {
                setState(() {
                  nonVeg = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Both'),
              value: both,
              onChanged: (bool? value) {
                setState(() {
                  both = value!;
                });
              },
            ),

            Spacer(),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    disabledBackgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Clear action
                    setState(() {
                      budget1 = budget2 = budget3 = budget4 = veg = nonVeg = both = false;
                    });
                  },
                  child: Text('CLEAR'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    disabledBackgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // Submit action
                  },
                  child: Text('SUBMIT'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
