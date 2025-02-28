import 'package:flutter/material.dart';

class AdminDashborad extends StatelessWidget {
  const AdminDashborad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddItemSection(),
            const SizedBox(height: 20),
            _buildSectionTitle('All Users'),
            _buildUserList(),
            _buildSectionTitle('All Products'),
            _buildProductList(),
            _buildSectionTitle('Inventory Stocks'),
            _buildInventoryStockList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddItemSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Add New Item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Item Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Item Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Item Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildUserList() {
    final List<String> users = ['User 1', 'User 2', 'User 3'];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(users[index]),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        );
      },
    );
  }

  Widget _buildProductList() {
    final List<Map<String, dynamic>> products = [
      {'name': 'Product 1', 'price': 10.0, 'quantity': 5},
      {'name': 'Product 2', 'price': 20.0, 'quantity': 10},
      {'name': 'Product 3', 'price': 30.0, 'quantity': 15},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]['name']),
          subtitle: Text(
              'Price: \$${products[index]['price']} | Quantity: ${products[index]['quantity']}'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
    );
  }

  Widget _buildInventoryStockList() {
    final List<Map<String, dynamic>> inventory = [
      {'item': 'Item 1', 'stock': 100},
      {'item': 'Item 2', 'stock': 50},
      {'item': 'Item 3', 'stock': 200},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: inventory.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(inventory[index]['item']),
          subtitle: Text('Stock: ${inventory[index]['stock']}'),
        );
      },
    );
  }
}
