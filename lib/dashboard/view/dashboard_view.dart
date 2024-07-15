import 'package:auth/dashboard/view/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DashboardCard(
                    icon: Icons.person,
                    label: 'Users',
                    value: '150',
                    color: Colors.blue,
                  ),
                  DashboardCard(
                    icon: Icons.shopping_cart,
                    label: 'Orders',
                    value: '75',
                    color: Colors.green,
                  ),
                  DashboardCard(
                    icon: Icons.attach_money,
                    label: 'Revenue',
                    value: '\$5,000',
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('User 1'),
                    subtitle: Text('Active'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('User 2'),
                    subtitle: Text('Inactive'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('User 3'),
                    subtitle: Text('Active'),
                  ),
                  // Add more list tiles as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
