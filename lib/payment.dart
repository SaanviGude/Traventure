import 'package:flutter/material.dart';
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
