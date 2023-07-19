import 'package:flutter/material.dart';
import 'package:josenian_quiri/screens/query.dart';

class ReviewPage extends StatefulWidget {
  final String schema;
  final String data;

  ReviewPage(
      {required this.schema,
      required this.data,
      Key? key,
      required String filePath})
      : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController _dataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dataController.text = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Schema: ${widget.schema}'),
            SizedBox(height: 20),
            TextField(
              controller: _dataController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Data',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Upsert'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                print('Schema: ${widget.schema}');
                print('Data: ${_dataController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
