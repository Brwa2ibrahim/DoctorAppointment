import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> mockDoctors = [
    {
      'docName': 'Dr. John Doe',
      'docCategory': 'Cardiology',
      'docImage': 'assets/images/3.png',
      'docPhone': '123-456-7890',
      'docAbout': 'Experienced in heart surgeries.',
      'docAddress': '123 Main St, City',
      'docTiming': '9 AM - 5 PM'
    },
    {
      'docName': 'Dr. Jane Smith',
      'docCategory': 'Dermatology',
      'docImage': 'assets/images/3.png',
      'docPhone': '987-654-3210',
      'docAbout': 'Expert in skin diseases.',
      'docAddress': '456 Elm St, City',
      'docTiming': '10 AM - 6 PM'
    },
    // Add more mock doctors as needed
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> searchResults = mockDoctors
        .where((doctor) =>
            doctor['docName'].toLowerCase().contains(widget.query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: searchResults.isEmpty
            ? Center(child: Text('No doctors found for "${widget.query}"'))
            : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  var doctor = searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(doctor['docImage']),
                    ),
                    title: Text(doctor['docName']),
                    subtitle: Text(doctor['docCategory']),
                    onTap: () {
                    },
                  );
                },
              ),
      ),
    );
  }
}
