/*import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String packageName;
  final List<Map<String, dynamic>> travelersInfo; // Pass travelers' info from the booking page
  final int numberOfTravelers;
  final int price;// Pass the number of travelers

  PaymentPage({
    required this.packageName,
    required this.travelersInfo,
    required this.numberOfTravelers,
    required this.price
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  //double pricePerTraveler = price; // Price per traveler
  late double totalAmount;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    totalAmount = widget.numberOfTravelers * widget.price.toDouble(); // Calculate total amount
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void openCheckout() {
    var options = {
      'key': 'YOUR_RAZORPAY_KEY', // Your Razorpay API key
      'amount': (totalAmount * 100).toString(), // Amount in paise
      'currency': 'INR',
      'name': widget.packageName,
      'description': 'Payment for booking',
      'prefill': {
        'contact': '', // Optionally prefill contact
        'email': '', // Optionally prefill email
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    print("Payment Success: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful!')),
    );
    // Optionally navigate to confirmation page
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure here
    print("Payment Error: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display total amount
              Text(
                'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Card Number
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              // Expiry Date
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expiry Date (MM/YY)',
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),

              // CVV
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              SizedBox(height: 20),

              // "Proceed to Payment" button
              Center(
                child: ElevatedButton(
                  onPressed: openCheckout,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF5E8953),
                  ),
                  child: Text(
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//correct code
*/
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'upiTurbo.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
typedef void OnSuccess<T>(T result);
typedef void OnFailure<T>(T error);

class PaymentPage extends StatefulWidget {
  final String? userId;
  final String packageName;
  final List<Map<String, dynamic>> travelersInfo; // Pass travelers' info from the booking page
  final int numberOfTravelers;
  final int price;// Pass the number of travelers

  PaymentPage({
    super.key,
    required this.userId,
    required this.packageName,
    required this.travelersInfo,
    required this.numberOfTravelers,
    required this.price
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late String paymentDocId;
  late UpiTurbo _upiTurbo;
  //double pricePerTraveler = price; // Price per traveler
  late double totalAmount;

  final MethodChannel _channel =
  MethodChannel('upi_turbo'); // UPI Turbo channel


  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _upiTurbo = UpiTurbo(_channel);
    totalAmount = widget.numberOfTravelers * widget.price.toDouble(); // Calculate total amount
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _openCheckout();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf', // Your Razorpay API key
      'amount': (totalAmount * 100).toString(), // Amount in paise
      'currency': 'INR',
      'name': widget.packageName,
      'description': 'Payment for booking',
      'prefill': {
        'contact': '', // Optionally prefill contact
        'email': getUserEmail(widget.userId).then((email) {
    if (email != null) {
    print('User email: $email');
    } else {
    print('User email not found');
    }
    },
    )
      },
      'external': {
        'wallets': ['paytm','gpay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle successful payment here
    print("Payment Success: ${response.paymentId}");
    User? currentUser = FirebaseAuth.instance.currentUser;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful!')),
    );
    // Optionally navigate to confirmation page
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure here
    print("Payment Error: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  void _manageUpiAccounts() {
    _upiTurbo.manageUpiAccounts(
      customerMobile: "1234567890",
      onFailure: (error) {
        print("Failed to manage UPI accounts: ${error.errorDescription}");
      },
    );
  }
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display total amount
              Text(
                'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Card Number
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Number',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),

              // Expiry Date
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expiry Date (MM/YY)',
                ),
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 10),

              // CVV
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              SizedBox(height: 20),

              // "Proceed to Payment" button
              Center(
                child: ElevatedButton(
                  onPressed: openCheckout,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Color(0xFF5E8953),
                  ),
                  child: Text(
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class UpiTurbo {
  late MethodChannel _channel;
  bool _isTurboPluginAvailable = true;

  UpiTurbo(this._channel) {
    _checkTurboPluginAvailable();
  }

  void _checkTurboPluginAvailable() async {
    try {
      final Map<dynamic, dynamic> response =
      await _channel.invokeMethod('isTurboPluginAvailable');
      _isTurboPluginAvailable = response["isTurboPluginAvailable"] ?? false;
    } on PlatformException catch (error) {
      _isTurboPluginAvailable = false;
      print("Error checking Turbo Plugin availability: ${error.message}");
    }
  }



void linkNewUpiAccount({
  required String customerMobile,
  String? color,
  required OnSuccess<List<UpiAccount>> onSuccess,
  required OnFailure<Error> onFailure,
}) async {
  if (!_isTurboPluginAvailable) {
    _emitFailure(onFailure);
    return;
  }

  try {
    var requestParams = {"customerMobile": customerMobile, "color": color};
    final Map<dynamic, dynamic> response =
    await _channel.invokeMethod('linkNewUpiAccount', requestParams);

    if (response.containsKey('data') && response['data'].isNotEmpty) {
      onSuccess(_parseUpiAccounts(response['data']));
    } else {
      onFailure(Error(
          errorCode: "NO_ACCOUNT_FOUND",
          errorDescription: "No UPI account found"));
    }
  } on PlatformException catch (error) {
    onFailure(Error(
        errorCode: error.code,
        errorDescription: error.message ?? "Unknown error"));
  }
}


void manageUpiAccounts({
  required String customerMobile,
  String? color,
  required OnFailure<Error> onFailure,
}) async {
  if (!_isTurboPluginAvailable) {
    _emitFailure(onFailure);
    return;
  }

  try {
    var requestParams = {"customerMobile": customerMobile, "color": color};
    await _channel.invokeMethod('manageUpiAccounts', requestParams);
  } on PlatformException catch (error) {
    onFailure(Error(
        errorCode: error.code,
        errorDescription: error.message ?? "Unknown error"));
  }
}

List<UpiAccount> _parseUpiAccounts(String jsonString) {
  if (jsonString.isEmpty) {
    return <UpiAccount>[];
  }
  List<dynamic> json = jsonDecode(jsonString);
  List<UpiAccount> accounts = [];
  for (var account in json) {
    accounts.add(UpiAccount.fromJson(account));
  }
  return accounts;
}

void _emitFailure(OnFailure<Error> onFailure) {
  onFailure(Error(
      errorCode: "TURBO_PLUGIN_UNAVAILABLE",
      errorDescription: "Turbo Plugin is unavailable"));
}
}
class UpiAccount {
  String upiId;
  String displayName;
  String accountType;

UpiAccount({
  required this.upiId,
  required this.displayName,
  required this.accountType,
});

factory UpiAccount.fromJson(Map<dynamic, dynamic> json) {
return UpiAccount(
upiId: json['upiId'] ?? '',
displayName: json['displayName'] ?? '',
accountType: json['accountType'] ?? '',
);
}
}
class Error {
String errorCode;
String errorDescription;

Error({required this.errorCode, required this.errorDescription});
}




Future<String?> getUserEmail(String? userId) async {
  try {
    // Query Firestore collection where user data is stored
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users')  // Assuming 'users' is your collection
        .doc(userId)          // Use the userId as the document ID
        .get();

    // Check if the document exists and contains the 'email' field
    if (userDoc.exists && userDoc.data() != null) {
      return userDoc.data()?['email'];  // Return the email
    } else {
      return null;  // No email found
    }
  } catch (e) {
    print('Error getting user email: $e');
    return null;  // Return null if there's an error
  }
}
2nd code
*/

/*
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String packageName;
  final String? userId;
  final List<Map<String, dynamic>> travelersInfo; // Travelers' info
  final int numberOfTravelers;
  final double price;

  PaymentPage({
    required this.userId,
    required this.packageName,
    required this.travelersInfo,
    required this.numberOfTravelers,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late double totalAmount;
  late String paymentDocId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    totalAmount = widget.numberOfTravelers * widget.price.toDouble();

    // Set Razorpay event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Automatically open Razorpay checkout when the page is initialized
    _openCheckout();
  }

  // Function to open Razorpay checkout
  void _openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf', // Replace with your actual Razorpay API key
      'amount': (totalAmount * 100).toInt(), // Amount in paise
      'currency': 'INR',
      'name': widget.packageName,
      'description': 'Payment for booking',
      'prefill': {
        'contact': '', // Optionally prefill contact
        'email': '', // Optionally prefill email
      },
      'external': {
        'wallets': ['paytm', 'gpay'] // Allow UPI and Paytm wallets
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  // Handle Razorpay payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful!')),
    );

    // Optionally, navigate to a confirmation page or save payment info to database
    // Example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(paymentId: response.paymentId),
      ),
    );
  }

  // Handle Razorpay payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  // Handle external wallet (e.g., Paytm, GPay)
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Processing Payment...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openCheckout, // Reopen checkout if needed
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Color(0xFF5E8953),
              ),
              child: Text(
                'Retry Payment',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingConfirmationPage extends StatelessWidget {
  final String? paymentId;

  const BookingConfirmationPage({Key? key, this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Text(
          'Payment Successful! Your Payment ID: $paymentId',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert'; // for jsonDecode
import 'package:http/http.dart' as http; // for http.post

class PaymentPage extends StatefulWidget {
  final String packageName;
  final String? userId;
  final List<Map<String, dynamic>> travelersInfo; // Travelers' info
  final int numberOfTravelers;
  final double price;

  PaymentPage({
    required this.userId,
    required this.packageName,
    required this.travelersInfo,
    required this.numberOfTravelers,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late double totalAmount;
  late String paymentDocId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    totalAmount = widget.numberOfTravelers * widget.price.toDouble();

    // Set Razorpay event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Automatically open Razorpay checkout when the page is initialized
    _openCheckout();
  }

  // Function to open Razorpay checkout
  void _openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf', // Replace with your actual Razorpay API key
      'amount': (totalAmount * 100).toInt(), // Amount in paise
      'currency': 'INR',
      'name': widget.packageName,
      'description': 'Payment for booking',
      'prefill': {
        'contact': '', // Optionally prefill contact
        'email': '', // Optionally prefill email
      },
      'external': {
        'wallets': ['paytm', 'gpay'] // Allow UPI and Paytm wallets
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  // Handle Razorpay payment success
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("Payment Successful: ${response.paymentId}");

    // Call the server to validate the payment
    bool isPaymentValid = await validatePaymentOnServer(response.paymentId);

    if (isPaymentValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment Successful!')),
      );

      // Optionally, navigate to a confirmation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationPage(paymentId: response.paymentId),
        ),
      );
    } else {
      // If payment validation fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment validation failed!')),
      );
    }
  }

// Function to validate payment with server
  Future<bool> validatePaymentOnServer(String? paymentId) async {
    // Here you would make an HTTP request to your server to validate the payment
    // This is a mock of the HTTP call
    try {
      var response = await http.post(
        Uri.parse('https://yourserver.com/validate_payment'),
        body: {'payment_id': paymentId},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['status'] == 'success';
      } else {
        print('Server error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error validating payment: $e');
      return false;
    }
  }


  // Handle Razorpay payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Error: ${response.message}");

    // Show error dialog with retry option
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Failed'),
        content: Text(response.message ?? 'Something went wrong.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openCheckout(); // Retry payment
            },
            child: const Text('Retry'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  // Handle external wallet (e.g., Paytm, GPay)
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Processing Payment...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openCheckout, // Reopen checkout if needed
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Color(0xFF5E8953),
              ),
              child: Text(
                'Retry Payment',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingConfirmationPage extends StatelessWidget {
  final String? paymentId;

  const BookingConfirmationPage({Key? key, this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Text(
          'Payment Successful! Your Payment ID: $paymentId',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
*/


//always successfull
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homepage.dart';

class PaymentPage extends StatefulWidget {
  // final String imageUrl;
  final String packageName;
  final String? userId;
  final List<Map<String, dynamic>> travelersInfo; // Travelers' info
  final int numberOfTravelers;
  final double price;

  PaymentPage({
    //  required this.imageUrl,
    required this.userId,
    required this.packageName,
    required this.travelersInfo,
    required this.numberOfTravelers,
    required this.price,
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late Razorpay _razorpay;
  late double totalAmount;
  late String paymentDocId;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    totalAmount = widget.numberOfTravelers * widget.price.toDouble();

    // Set Razorpay event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Automatically open Razorpay checkout when the page is initialized
    _openCheckout();
  }

  // Function to open Razorpay checkout
  void _openCheckout() {
    var options = {
      'key': 'rzp_test_Pjb30t4hoYGOFf', // Replace with your actual Razorpay API key
      'amount': (totalAmount * 100).toInt(), // Amount in paise
      'currency': 'INR',
      'name': widget.packageName,
      'description': 'Payment for booking',
      'prefill': {
        'contact': '', // Optionally prefill contact
        'email': '', // Optionally prefill email
      },
      'external': {
        'wallets': ['paytm', 'gpay'] // Allow UPI and Paytm wallets
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error opening Razorpay: $e");
    }
  }

  // Handle Razorpay payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Payment Successful: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful!')),
    );

    FirebaseFirestore.instance.collection('userlogin')
        .doc(widget.userId)
        .collection('history')
        .add({
      'imageUrl':'https://firebasestorage.googleapis.com/v0/b/flutter-basics-85cec.appspot.com/o/history_image%2FScreenshot%202024-07-28%20220809.png?alt=media&token=2be525d0-f2f3-459d-9ec4-3b9a7bd91867',
      'packageName': widget.packageName,
      'travelersInfo': widget.travelersInfo,
      'numberOfTravelers': widget.numberOfTravelers,
      'price': widget.price.toDouble(),
      'paymentId': response.paymentId,
      'date': '123', // Booking date
    });

    // Add booking details to global bookings collection
    FirebaseFirestore.instance.collection('bookings')
        .add({
      'userId': widget.userId,
      'packageName': widget.packageName,
      'travelersInfo': widget.travelersInfo,
      'numberOfTravelers': widget.numberOfTravelers,
      'price': totalAmount.toDouble(),
      'paymentId': response.paymentId,
      'date': '123', // Booking date
    });

    // Optionally, navigate to a confirmation page or save payment info to database
    // Example:
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(paymentId: response.paymentId),
      ),
    );
  }

  // Handle Razorpay payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment Failed: ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed: ${response.message}')),
    );
  }

  // Handle external wallet (e.g., Paytm, GPay)
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External Wallet Selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment for ${widget.packageName}'),
        backgroundColor: Color(0xFF5E8953),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Processing Payment...', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openCheckout, // Reopen checkout if needed
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Color(0xFF5E8953),
              ),
              child: Text(
                'Retry Payment',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomePage(selectedSearch: null,userId: FirebaseAuth.instance.currentUser?.uid,)), // Replace with your actual home page widget
                      (Route<dynamic> route) => false, // Remove all previous routes
                );
              },// Reopen checkout if needed
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Color(0xFF5E8953),
              ),
              child: Text(
                'home page',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingConfirmationPage extends StatelessWidget {
  final String? paymentId;

  const BookingConfirmationPage({Key? key, this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4D8C53),
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle, // You can choose any icon you prefer
              size: 60,
              color: Colors.green,
            ),
            SizedBox(height: 20), // Space between the icon and the text
            Text(
              'Payment Successful! Your Payment ID: $paymentId',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center, // Center the text
            ),

            SizedBox(height: 10), // Space before the button
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) =>
                      HomePage(selectedSearch: null,
                        userId: FirebaseAuth.instance.currentUser?.uid,)),
                  // Replace with your actual home page widget
                      (Route<
                      dynamic> route) => false, // Remove all previous routes
                );
              },
              child: Text(
                'Go to Home', style: TextStyle(color: Color(0xFFE4D59F)),),
              // Button label
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5E8953), // Button color
              ),
            ),
          ],

        ),
      ),
    );
  }
}
