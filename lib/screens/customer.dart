import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<dynamic> providers = [];
  String? selectedRegion; // No default value; user must select

  final List<String> regions = ["Patti"]; // Add more if needed

  fetchProviders(String region) async {
    setState(() {
      providers = []; // Clear the previous list
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:3001/providers/$region'));


      if (response.statusCode == 200) {
        setState(() {
          providers = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load providers');
      }
    } catch (e) {
      print('Error fetching providers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Providers')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  hint: Text("Select Region"),
                  value: selectedRegion,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRegion = newValue;
                    });
                  },
                  items: regions.map<DropdownMenuItem<String>>((String region) {
                    return DropdownMenuItem<String>(
                      value: region,
                      child: Text(region),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: selectedRegion == null
                      ? null
                      : () {
                    fetchProviders(selectedRegion!);
                  },
                  child: Text("Search"),
                ),
              ],
            ),
          ),
          Expanded(
            child: providers.isEmpty
                ? Center(child: Text("No providers found. Select a region and search."))
                : ListView.builder(
              itemCount: providers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(providers[index]['name']),
                  subtitle: Text(providers[index]['phone']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
