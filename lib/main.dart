import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter HTTP POST Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Salary'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a salary';
                    }
                    // You can add additional validation for salary if needed
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a age';
                    }
                    // You can add additional validation for salary if needed
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      postData(
                        context,
                        nameController.text,
                        double.parse(salaryController.text),
                        ageController.text,
                      );
                    }
                  },
                  child: const Text('Make POST Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showResultDialog(
    BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> postData(
    BuildContext context, String name, double salary, String age) async {
  // Replace with your API endpoint
  String apiUrl = 'https://dummy.restapiexample.com/api/v1/create';
  // Map<String, String> headers = {
  //   'Content-Type': 'application/json',
  // };

  Map<String, dynamic> data = {
    'name': name,
    'salary': salary,
    'age': age,
  };

  String jsonData = jsonEncode(data);

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      // headers: headers,
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Successful response
      showResultDialog(context, 'Success', 'POST request successful');
      print('Response1: ${response.body}');
    } else {
      // Failure response
      showResultDialog(context, 'Failure',
          'POST request failed with status: ${response.statusCode}');
      print('Response11: ${response.body}');
    }
  } catch (error) {
    // Error making the request
    showResultDialog(context, 'Error', 'Error making POST request: $error');
    print('Error making POST request1: $error');
  }
}
