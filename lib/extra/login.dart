import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to handle login
  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Navigate to the next page (for example, home page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Update this to your home page
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong password provided.');
      } else {
        _showErrorDialog(e.message ?? 'An error occurred.');
      }
    }
  }

  // Function to display error dialogs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                            );
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
                        onPressed: _login,  // Call the login function here
                        child: Text('LOG IN', style: TextStyle(color: Color(0xFF235537))),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                          backgroundColor: Color(0xFFF3E5B5),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Create account action
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage()),
                          );
                        },
                        child: Text(
                          "don't have an account? create account",
                          style: TextStyle(color: Color(0xFFDACEA0), fontSize: 20),
                        ),
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

/*
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,  // Automatic hot reload
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Container'),
      ),
      body: Row( //Multiple children possible + multiple types of widgets
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: ,
        children: [ //<Type of widget specified if needed>
          Text('A',style: TextStyle(fontSize: 25),),
          Text('B',style: TextStyle(fontSize: 25),),
          Text('C',style: TextStyle(fontSize: 25),),
          Text('D',style: TextStyle(fontSize: 25),),
          Text('E',style: TextStyle(fontSize: 25),),
          ElevatedButton(onPressed: (){}, child: Text('Click'))
        ],
      ),
    );
  }
}
*/
//wrap with widgets use Alt+Enter
/*

colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
useMaterial3: true,

body:Center( //Center of the screen
child: Container( //contains widgets and their properties in it
//Can have only 1 child which can children under it
width: 100,
height: 100,
color: Colors.limeAccent, //class Colors used
child: Text('Hello Devops!!'),
),

  body: Text('Hello Futter Devs',style: TextStyle(
        fontSize: 25,
        color: Colors.lightBlue,
        fontWeight: FontWeight.w800,
        backgroundColor: Colors.deepOrangeAccent
      ),),

body: Center(
        child: Container(
          width: 200,
          height: 100,
          color: Colors.blueGrey,
          child: Center(child: Text('This is center of Container', style: TextStyle(color: Colors.white),)),
        ),
      )

TextButton(
        child: Text('Click here!!'),
        onPressed: (){
          print('Text Button Tapped!');
        },
        onLongPress: (){
          print('LongPressed!!');
        }

ElevatedButton(
        child: Text('Elevated Button'),
        onPressed: (){
          print('Button pressed');
        },
      )

OutlinedButton(
        child: Text('Outlined Button'),
        onPressed: (){
          print('Outlined Clicked');
        },
      )

Center(
        child: Container(
            width: 100,
            height: 100,
            child: Image.asset('assets/images/AppHS.jpeg')),
      )

),*/
/*
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
//import 'admin_login.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
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
                        onPressed: () {
                          // Log in action
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AdminLoginPage()),
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
                        },
                        child: Text('SKIP',
                            style: TextStyle(color: Color(0xFF255A39))
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
                        child: Text('ADMIN', style: TextStyle(color: Color(0xFF255A39))),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
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
}
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/AppHS.jpeg'), // Background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF235537).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'FORGOT PASSWORD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      // ID Field
                      TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          labelText: 'ID:',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFFDCD0A1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // New Password Field
                      TextField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'NEW PASSWORD',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFFDCD0A1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Confirm Password Field
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'CONFIRM PASSWORD',
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFFDCD0A1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          // Submit action
                        },
                        child: Text('SUBMIT'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      // Back action
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('BACK'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
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
*/
/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF486F43).withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
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
                          fillColor: Colors.white,
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
                          },
                          child: Text(
                            'forget password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Log in action
                        },
                        child: Text('LOG IN'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
                          //primary: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          // Create account action
                        },
                        child: Text(
                          "don't have account? create account",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.android),
                            onPressed: () {
                              // Google login action
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.apple),
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
                      },
                      child: Text('SKIP'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Admin action
                      },
                      child: Text('ADMIN'),
                    )
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
*/

/*onPressed: () async {
                          try {
                            // Create a new user
                            UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            // Store additional user details in Firestore
                            await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
                              'name': _nameController.text.trim(),
                              'phone': _phoneController.text.trim(),
                              'aadhaar': _aadhaarController.text.trim(),
                              'address': _addressController.text.trim(),
                              'email': _emailController.text.trim(),
                              'isUser': isUser,
                            });

                            // Navigate to the homepage after successful signup
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          } catch (e) {
                            print('Error: $e');
                            // Handle error (e.g., show a dialog or snackbar with the error message)
                          }
                        },
                        child: Text('SIGN UP', style: TextStyle(color: Color(0xFF235537))),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          backgroundColor: Color(0xFFDCD0A1),
                          textStyle: TextStyle(color: Color(0xFF235537)),
                        ),
                      )*/

/*ElevatedButton(
                        onPressed: () {
                          // Sign up action here
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },*/

// Navigate to the homepage after successful signup
/*Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );*/