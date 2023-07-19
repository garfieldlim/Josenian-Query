import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String responseText = '';
  TextEditingController questionController = TextEditingController();

  Future<void> search(String question) async {
    final url = Uri.parse('http://172.30.13.219:7999/search');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'question': question});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final responseData = data['response'] as String;
        setState(() {
          responseText = responseData;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flask Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final question = questionController.text;
                search(question);
              },
              child: Text('Search'),
            ),
            SizedBox(height: 5),
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                hintText: 'Enter your question',
              ),
            ),
            SizedBox(height: 5),
            Text(
              responseText,
              style: TextStyle(
                color: Colors.black, // Set the text color to black
              ),
            ),
          ],
        ),
      ),
    );
  }
}
