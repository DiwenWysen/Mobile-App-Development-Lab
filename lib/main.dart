import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 01',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 01'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    backgroundImage: AssetImage('assets/me.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dillon Ryson anak Donald',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Student ID: BCS23090004',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(height: 32, thickness: 1),
                  const Text(
                    'Personal Life Goal / Quote:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '"I want to be a professional dancer"',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.indigo,
                    ),
                  )
                ]
              ),
            )
          )
        )
      )
    );
  }
}

