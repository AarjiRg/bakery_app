import 'package:bakery_app/admin_view/admin_addproduct_page.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
           
            _buildCustomButton(
              context,
              title: 'Add Products',
              icon: Icons.add,
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddproductPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),


            _buildCustomButton(
              context,
              title: 'View Products',
              icon: Icons.list,
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {
  
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewProductsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
      


            _buildCustomButton(
              context,
              title: 'view orders',
              icon: Icons.list,
              gradient: const LinearGradient(
                colors: [Colors.green, Colors.teal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {
  
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewProductsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

     
            _buildCustomButton(
              context,
              title: 'Show All Users',
              icon: Icons.people,
              gradient: const LinearGradient(
                colors: [Colors.orange, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              onPressed: () {
            
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShowAllUsersScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCustomButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class ViewProductsScreen extends StatelessWidget {
  const ViewProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Products'),
      ),
      body: const Center(
        child: Text('View Products Screen'),
      ),
    );
  }
}

class ShowAllUsersScreen extends StatelessWidget {
  const ShowAllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show All Users'),
      ),
      body: const Center(
        child: Text('Show All Users Screen'),
      ),
    );
  }
}