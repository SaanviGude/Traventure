import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userprofile.dart';
import 'guideprofile.dart';
import 'forgot.dart';
import 'homepage.dart';
import 'homepagenotlogin.dart';
import 'profile.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDxmiAg550tVkBW4_zPijLVIG_kA_YH44E",
  authDomain: "flutter-basics-85cec.firebaseapp.com",
  projectId: "flutter-basics-85cec",
  storageBucket: "flutter-basics-85cec.appspot.com",
  messagingSenderId: "507247752159",
  appId: "1:507247752159:web:da06cb67117d4206100a6a",
  measurementId: "G-XJL9HZ5MJZ"
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to log in user
  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User logged in, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print(e.toString());
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: ${e.toString()}')),
      );
    }
  }

  /*// Function to create a new user
  Future<void> _createAccount() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': _emailController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to another page (optional)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginPage()),
      );
    } catch (e) {
      print(e.toString());
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account: ${e.toString()}')),
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF235537).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFEEE2B3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFDCD0A1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                            );

                          },
                          child: Text(
                            'forget password?',
                            style: TextStyle(color: Color(0xFFEAE0AE),
                                fontStyle:  FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _loginUser, /*{ ,
                          // Log in action
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },*/
                        child: Text('LOG IN',style: TextStyle(color:Color(0xFF235537))),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                          backgroundColor: Color(0xFFF3E5B5), // Fix for primary
                        ),
                      ),

                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserProfilePage()),
                          );
                        },
                        child: Text(
                          "don't have account? create account",
                          style: TextStyle(color: Color(0xFFDACEA0),
                              fontSize: 20
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.android, color: Colors.blue,size:35),

                            onPressed: () {
                              // Google login action
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.apple, color: Colors.blue,size: 35 ),
                            onPressed: () {
                              // Apple login action
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Skip action
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => noHomePage()),
                          );
                        },
                        child: Text('SKIP',
                            style: TextStyle(color: Color(0xFF255A39),fontSize: 25.00)
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDCD0A1)
                        )
                      //style: color:
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // Admin action
                          // Navigate to AdminLoginPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminLoginPage()),
                          );
                        },
                        child: Text('ADMIN', style: TextStyle(color: Color(0xFF255A39),fontSize: 25.00)),
                        style:
                        ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDCD0A1)

                        )

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
/*
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Perform login validation here
    if (username == 'admin' && password == 'admin123') {
      // Successful login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful!')),
      );
    } else {
      // Failed login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials!')),
      );
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Login',style: TextStyle(color: Color(0xFFEEE2B3)),),
          backgroundColor: Color(0xFF255A39),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
                fit: BoxFit.cover,
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0),
                  Container(
                    padding: EdgeInsets.all(35),
                    decoration: BoxDecoration(
                      color: Color(0xFF235537).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Row(
                          children: [

                            Text('Id:',style: TextStyle(color:  Color(0xFFF3E5B5))),
                            Expanded(
                              child:TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(),
                                    filled:true,
                                    fillColor: Color(0xFFDCD0A1)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children:[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('pwd',style: TextStyle(color:  Color(0xFFF3E5B5)))),
                            Expanded(child:
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color:Colors.black),
                                  border: OutlineInputBorder(),
                                  filled:true,
                                  fillColor: Color(0xFFDCD0A1)
                              ),
                              obscureText: true, // Hide password text
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Forgot password action
                            },
                            child: Text(
                              'forget password?',
                              style: TextStyle(color: Color(0xFFEAE0AE),
                                  fontStyle:  FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Log in
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          },
                          child: Text('LOG IN',style: TextStyle(color:Color(0xFF235537))),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                            backgroundColor: Color(0xFFF3E5B5), // Fix for primary
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // Create account action
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GuideProfilePage()),
                            );
                          },
                          child: Text(
                            "don't have account? create account",
                            style: TextStyle(color: Color(0xFFDACEA0),
                                fontSize: 20
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to log in user
  Future<void> _loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // User logged in, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginPage()),
      );
    } catch (e) {
      print(e.toString());
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to login: ${e.toString()}')),
      );
    }
  }

  // Function to create a new user
  Future<void> _createAccount() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Store additional user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': _emailController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to another page (optional)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminLoginPage()),
      );
    } catch (e) {
      print(e.toString());
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF235537).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFEEE2B3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFDCD0A1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Forgot password action
                            // Navigator to forgot password page
                          },
                          child: Text(
                            'forget password?',
                            style: TextStyle(
                              color: Color(0xFFEAE0AE),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _loginUser, // Call login function
                        child: Text(
                          'LOG IN',
                          style: TextStyle(color: Color(0xFF235537)),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 36),
                          backgroundColor: Color(0xFFF3E5B5),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: _createAccount, // Call create account function
                        child: Text(
                          "don't have an account? create account",
                          style: TextStyle(
                            color: Color(0xFFDACEA0),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Add social login buttons, etc.
                    ],
                  ),
                ),
                // Additional Widgets like skip and admin buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Perform login validation here
    if (username == 'admin' && password == 'admin123') {
      // Successful login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Successful!')),
      );
    } else {
      // Failed login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Login',style: TextStyle(color: Color(0xFFEEE2B3)),),
          backgroundColor: Color(0xFF255A39),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/AppHS.jpeg'), // Add your background image
                fit: BoxFit.cover,
              ),
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 0),
                  Container(
                    padding: EdgeInsets.all(35),
                    decoration: BoxDecoration(
                      color: Color(0xFF235537).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Row(
                          children: [
                            Text('Id:',style: TextStyle(color:  Color(0xFFF3E5B5))),
                            Expanded(
                              child:TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    border: OutlineInputBorder(),
                                    filled:true,
                                    fillColor: Color(0xFFDCD0A1)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children:[
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text('pwd',style: TextStyle(color:  Color(0xFFF3E5B5)))),
                            Expanded(child:
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color:Colors.black),
                                  border: OutlineInputBorder(),
                                  filled:true,
                                  fillColor: Color(0xFFDCD0A1)
                              ),
                              obscureText: true, // Hide password text
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Forgot password action

/*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                              );
*/
                            },
                            child: Text(
                              'forget password?',
                              style: TextStyle(color: Color(0xFFEAE0AE),
                                  fontStyle:  FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Log in action
                          },
                          child: Text('LOG IN',style: TextStyle(color:Color(0xFF235537))),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                            backgroundColor: Color(0xFFF3E5B5), // Fix for primary
                          ),
                        ),
                        SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            // Create account action
                          },
                          child: Text(
                            "don't have account? create account",
                            style: TextStyle(color: Color(0xFFDACEA0),
                                fontSize: 20
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}*/
