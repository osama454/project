import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dummy Data List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Simulate fetching documents with dummy data
  Future<List<Map<String, dynamic>>> fetchDocuments() async {
    // Simulated delay
    await Future.delayed(Duration(seconds: 2));

    // Dummy data
    List<Map<String, dynamic>> documents = [
      {'field1': 'Document 1', 'field2': 'Extra info 1'},
      {'field1': 'Document 2', 'field2': 'Extra info 2'},
      {'field1': 'Document 3', 'field2': 'Extra info 3'},
    ];

    return documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Data List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchDocuments(),
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
                  title: Text(documents[index][
                      'field1']), // Replace 'field1' with your actual field name
                  // Add more widgets to display other fields as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}
