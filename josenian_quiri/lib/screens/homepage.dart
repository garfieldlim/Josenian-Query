import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'review.dart';

class UpsertingPage extends StatefulWidget {
  @override
  _UpsertingPageState createState() => _UpsertingPageState();
}

class _UpsertingPageState extends State<UpsertingPage> {
  String? _selectedSchema;
  String? _fileContent;
  String _fileName = 'No file uploaded';

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);

    if (result != null) {
      PlatformFile file = result.files.single;
      _fileContent = base64Encode(file.bytes!);
      setState(() {
        _fileName = file.name;
      });
      print('Content of the file: $_fileContent');
    } else {
      print('No file picked');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upserting Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Choose Schema:'),
            DropdownButton<String>(
              value: _selectedSchema,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSchema = newValue!;
                });
              },
              items: <String>['Schema 1', 'Schema 2', 'Schema 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text('Choose Schema'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Upload Data File'),
              onPressed: _pickFile,
            ),
            SizedBox(height: 20),
            Text(_fileName),
            SizedBox(height: 20),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Or paste your data here',
              ),
              onChanged: (value) {
                _fileContent = value;
                print('Content of the text field: $_fileContent');
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                if (_selectedSchema != null && _fileContent != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        schema: _selectedSchema!,
                        data: _fileContent!,
                        filePath: '',
                      ),
                    ),
                  );
                } else {
                  print('Please choose a schema and provide the data');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
