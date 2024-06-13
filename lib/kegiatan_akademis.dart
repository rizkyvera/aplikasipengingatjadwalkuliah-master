import 'package:flutter/material.dart';

class AcademicActivityPage extends StatefulWidget {
  @override
  _AcademicActivityPageState createState() => _AcademicActivityPageState();
}

class _AcademicActivityPageState extends State<AcademicActivityPage> {
  TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  TextEditingController _locationController = TextEditingController();
  List<Map<String, String>> _academicActivities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kegiatan Akademis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tambah Kegiatan Akademis',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul Kegiatan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: TextEditingController(
                    text: _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "",
                  ),
                  decoration: InputDecoration(
                    labelText: 'Tanggal',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Lokasi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _simpanKegiatan();
              },
              child: Text('Simpan'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Daftar Kegiatan Akademis',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: _academicActivities.length,
                itemBuilder: (context, index) {
                  return AcademicActivityItem(
                    title: _academicActivities[index]['title']!,
                    date: _academicActivities[index]['date']!,
                    location: _academicActivities[index]['location']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _simpanKegiatan() {
    String title = _titleController.text;
    String date = _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : "";
    String location = _locationController.text;

    if (title.isNotEmpty && date.isNotEmpty && location.isNotEmpty) {
      setState(() {
        _academicActivities.add({
          'title': title,
          'date': date,
          'location': location,
        });
        _titleController.clear();
        _selectedDate = null;
        _locationController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Peringatan'),
            content: Text('Semua kolom harus diisi untuk menyimpan kegiatan.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}

class AcademicActivityItem extends StatelessWidget {
  final String title;
  final String date;
  final String location;

  const AcademicActivityItem({
    required this.title,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Tanggal: $date',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Lokasi: $location',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
