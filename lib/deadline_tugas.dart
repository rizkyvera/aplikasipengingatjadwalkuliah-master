import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeadlineTugasPage extends StatefulWidget {
  @override
  _DeadlineTugasPageState createState() => _DeadlineTugasPageState();
}

class _DeadlineTugasPageState extends State<DeadlineTugasPage> {
  TextEditingController _deskripsiController = TextEditingController();
  DateTime? _selectedDate;
  List<Map<String, String>> _deadlines = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deadline Tugas'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tambah Deadline Tugas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Tugas',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                _selectedDate != null
                    ? 'Tanggal Deadline: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                    : 'Pilih Tanggal Deadline',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _tambahDeadline();
              },
              child: Text('Tambah'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Daftar Deadlines',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _deadlines.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deskripsi Tugas:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(_deadlines[index]['deskripsi'] ?? ''),
                          SizedBox(height: 10),
                          Text(
                            'Tanggal Deadline:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(_deadlines[index]['tanggal'] ?? ''),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _addEventToCalendar(_deadlines[index]);
                            },
                            child: Text('Tambah ke Kalender'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

  void _tambahDeadline() {
    String deskripsi = _deskripsiController.text;
    String? tanggal = _selectedDate != null
        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
        : null;

    if (deskripsi.isNotEmpty && tanggal != null) {
      setState(() {
        _deadlines.add({'deskripsi': deskripsi, 'tanggal': tanggal});
        _deskripsiController.clear();
        _selectedDate = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deskripsi dan Tanggal Deadline harus diisi.'),
        ),
      );
    }
  }

  Future<void> _addEventToCalendar(Map<String, String> deadline) async {
    String deskripsi = deadline['deskripsi'] ?? '';
    String tanggal = deadline['tanggal'] ?? '';
    String url = 'webcal://example.com/?action=TEMPLATE&text=$deskripsi&dates=$tanggal/$tanggal';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: DeadlineTugasPage(),
  ));
}
