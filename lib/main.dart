import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Data List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyListPage(),
    );
  }
}

// Dummy function to fetch data instead of Firebase Firestore
Future<List<Map<String, dynamic>>> fetchDocuments() async {
  await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  // Dummy data
  List<Map<String, dynamic>> documents = [
    {'name': 'John Doe', 'age': 30},
    {'name': 'Jane Smith', 'age': 25},
    {'name': 'Alice Johnson', 'age': 40},
    {'name': 'Bob Williams', 'age': 35},
  ];
  return documents;
}

class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  late Future<List<Map<String, dynamic>>> _documentsFuture;

  @override
  void initState() {
    super.initState();
    _documentsFuture = fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _documentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> documents = snapshot.data!;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(documents[index]['name'] ?? ''), // Access data like this
                  // ... other widgets to display the data
                );
              },
            );
          }
        },
      ),
    );
  }
}