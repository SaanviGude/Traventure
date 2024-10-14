import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package UI',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PackageScreen(),
    );
  }
}

class PackageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Back Button and Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                  Text(
                    'PACKAGE',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.code, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Main package image
            Container(
              margin: EdgeInsets.all(16.0),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://example.com/package_image.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Package Title, Price, and Rating
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'GOA EXPLORER',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '25,000/-',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star, color: Colors.yellow, size: 20),
                      Icon(Icons.star_border, color: Colors.grey, size: 20),
                    ],
                  ),
                ],
              ),
            ),

            // Buttons: Book Now, Add to List
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Book Now'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Add To List'),
                    ),
                  ),
                ],
              ),
            ),

            // Package Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4 DAYS - 3 NIGHTS\n'
                        'LOCAL GUIDE: SHEKAR PAGI\n'
                        'COMPANY GUIDE: ANURAG KASHYAP\n\n'
                        'PLACES:\n'
                        'MIRAMAR BEACH\n'
                        'AGUADA FORT\n'
                        'OLD GOA CHURCH\n'
                        'TAMBADI SURLA\n'
                        'MANGESHI TEMPLE\n'
                        'KALIN WORTH RESORT\n'
                        'THALASA RESORT\n\n'
                        'VEG/NON-VEG\n'
                        'PHONE NO: 334455XXX',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'DESCRIPTION:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discover the charm of Goa with our travel app, guiding you through the stunning Miramar Beach, '
                        'the historic Aguada Fort, and the iconic Old Goa Church. Uncover the serene beauty of Tambdi Surla '
                        'and the spiritual peace of Mangeshi Temple. For a perfect stay, experience luxury at Kalin Worth Resort '
                        'and the vibrant ambiance of Thalasa Resort. Explore, relax, and enjoy the best of Goa with us!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Similar Packages Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SIMILAR PACKAGES',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      // Package 1
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://example.com/similar1.jpg'), // Replace with your image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('goa wonders\n5,000/-\n3 days / 2 nights'),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      // Package 2
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://example.com/similar2.jpg'), // Replace with your image
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('goa wonders\n25,000/-\n3 days / 2 nights'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
