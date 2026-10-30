import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const StudentProfileScreen(),
    );
  }
}


class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedRole = 'Slytherin';

  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) =>
          Container(
            height: 240,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              onDateTimeChanged: (DateTime newDate) {
                setState(() => _selectedDate = newDate);
              },
            ),
          ),
    );
  }

  void _showCupertinoRolePicker(BuildContext context) {
    final List<String> roles = ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff'];
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoPicker(
          itemExtent: 32,
          onSelectedItemChanged: (int index) {
            setState(() => _selectedRole = roles[index]);
          },
          children: roles.map((role) => Center(child: Text(role))).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const StudentCardSection(),
        const SizedBox(height: 20),
        const ImageSection(imagePath: 'assets/uts.jpg'),
        const SizedBox(height: 20),
        const TitleSection(
          name: 'University of Technology Sarawak',
          location: 'Sibu, Sarawak, Malaysia',
          starCount: 67,
        ),
        const SizedBox(height: 20),
        // Exercise 2.2: Interactive Pickers Card Section
        _buildPickersCard(),
      ],
    );
  }

  Widget _buildLandscapeView() {
    return Row(
      children: [
        const Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: StudentCardSection(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const ImageSection(imagePath: 'assets/uts.jpg'),
              const SizedBox(height: 16),
              const TitleSection(
                name: 'University of Technology Sarawak',
                location: 'Sibu, Sarawak, Malaysia',
                starCount: 67,
              ),
              const SizedBox(height: 16),
              _buildPickersCard(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPickersCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Pickers (Lab 2.2)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 24),
            Text(
              'Selected Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 6),
            Text(
              'Selected House / Role: $_selectedRole',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () => _selectMaterialDate(context),
              icon: const Icon(Icons.calendar_today),
              label: const Text('Material DatePicker'),
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoDatePicker(context),
              icon: const Icon(Icons.calendar_month),
              label: const Text('Cupertino Date Picker (Modal Sheet)'),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Material Dropdown:'),
                DropdownButton<String>(
                  value: _selectedRole,
                  items: ['Gryffindor', 'Slytherin', 'Ravenclaw', 'Hufflepuff']
                      .map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedRole = newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () => _showCupertinoRolePicker(context),
              icon: const Icon(Icons.roller_shades),
              label: const Text('Cupertino House Wheel Picker'),
            ),
          ],
        ),
      ),
    );
  }


}


class StudentCardSection extends StatelessWidget {
  const StudentCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              'Dillon Ryosn anak Donald',
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
                fontSize:15,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      )
    );
  }
}

class ImageSection extends StatelessWidget {
  final String imagePath;
  const ImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        height: 200,
        fit: BoxFit.cover,
      )
    );
  }
}

class TitleSection extends StatelessWidget {
  final String name;
  final String location;
  final int starCount;
  const TitleSection({
    super.key,
    required this.name,
    required this.location,
    required this.starCount,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 4),
          Text('$starCount'),
        ],
      ),
    );
  }
}