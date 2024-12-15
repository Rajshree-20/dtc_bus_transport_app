import 'package:flutter/material.dart';

class PassAndTickets extends StatefulWidget {
  @override
  _PassAndTicketsState createState() => _PassAndTicketsState();
}

class _PassAndTicketsState extends State<PassAndTickets> {
  bool showTickets = true;
  String selectedPassTab = 'Active'; // Default tab for Pass

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tickets & Pass'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16.0),

              // Ticket and Pass Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showTickets = true;
                      });
                    },
                    child: Text(
                      'Ticket',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: showTickets ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showTickets = false;
                      });
                    },
                    child: Text(
                      'Pass',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: showTickets ? Colors.grey : Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Pass Tab Options
              if (!showTickets)
                Container(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedPassTab = 'Active';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedPassTab == 'Active'
                                ? Colors.blue
                                : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              color: selectedPassTab == 'Active'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedPassTab = 'Past';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedPassTab == 'Past'
                                ? Colors.blue
                                : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Past',
                            style: TextStyle(
                              color: selectedPassTab == 'Past'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16.0),

              // Display Ticket or Pass Information
              Expanded(
                child: showTickets
                    ? Center(
                  child: Text(
                    'Ticket Information Goes Here',
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
                    : selectedPassTab == 'Active'
                    ? Center(
                  child: Text(
                    'No Active Pass Information Available',
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.black54),
                  ),
                )
                    : Center(
                  child: Text(
                    'No Past Pass Information Available',
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.black54),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Book Now or Buy Pass Button
              showTickets
                  ? ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketBookingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Book Ticket',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
                  : ElevatedButton(
                onPressed: () {
                  _showPassOptionsDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Buy Pass',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPassOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Pass'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Daily Pass'),
                subtitle: Text('Unlimited travel for one day'),
                trailing: Text('₹50'),
                onTap: () {
                  Navigator.pop(context);
                  // Proceed to purchase Daily Pass
                },
              ),
              Divider(),
              ListTile(
                title: Text('Weekly Pass'),
                subtitle: Text('Unlimited travel for 7 days'),
                trailing: Text('₹300'),
                onTap: () {
                  Navigator.pop(context);
                  // Proceed to purchase Weekly Pass
                },
              ),
              Divider(),
              ListTile(
                title: Text('Monthly Pass'),
                subtitle: Text('Unlimited travel for 30 days'),
                trailing: Text('₹1000'),
                onTap: () {
                  Navigator.pop(context);
                  // Proceed to purchase Monthly Pass
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class TicketBookingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Book Tickets'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Route Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Route Number : 21',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'NON - AC',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Route Info
              Text('From', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 8.0),
              Text('Karol Bagh', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),
              Text('To', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 8.0),
              Text('Sarojini Nagar', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),

              // Passenger Info
              Text('Passengers', style: TextStyle(fontSize: 16.0)),
              const SizedBox(height: 8.0),
              Text('2 Adult Male', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16.0),

              // Ticket Validity Info
              Text(
                'This ticket will be valid till 4 hours. By proceeding, you agree to our Terms and Conditions.',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 16.0),

              // Fare Summary
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fare Summary', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Text('Fare: 2 x ₹20', style: TextStyle(fontSize: 16.0)),
                    const SizedBox(height: 8.0),
                    Text('Total: ₹40', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Proceed to Payment Button
              ElevatedButton(
                onPressed: () {
                  // Proceed to payment logic
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Proceed To Payment',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}