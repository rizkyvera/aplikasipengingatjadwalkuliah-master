import 'package:flutter/material.dart';

class Jadwal {
  String namaMataKuliah;
  String jamPelajaran;
  String ruangan;
  String namaDosen;

  Jadwal({
    required this.namaMataKuliah,
    required this.jamPelajaran,
    required this.ruangan,
    required this.namaDosen,
  });
}

class JadwalPage extends StatefulWidget {
  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  int _jumlahJadwal = 1;
  List<Widget> _formJadwal = [];
  List<Jadwal> _daftarJadwal = [];

  @override
  void initState() {
    super.initState();
    _generateFormJadwal();
  }

  void _generateFormJadwal() {
    _formJadwal = List.generate(
      _jumlahJadwal,
      (index) => _buildFormJadwal(index),
    );
  }

  Widget _buildFormJadwal(int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlueAccent, Colors.white],
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(width: 10.0),
              Text(
                'Jadwal Kuliah ${index + 1}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nama Mata Kuliah',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              _daftarJadwal[index].namaMataKuliah = value;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Jam Pelajaran',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              _daftarJadwal[index].jamPelajaran = value;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Ruangan',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              _daftarJadwal[index].ruangan = value;
            },
          ),
          SizedBox(height: 10.0),
          TextFormField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Nama Dosen',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            onChanged: (value) {
              _daftarJadwal[index].namaDosen = value;
            },
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Kuliah'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Jumlah Jadwal Kuliah',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _jumlahJadwal = int.tryParse(value) ?? 1;
                  _daftarJadwal.clear();
                  for (int i = 0; i < _jumlahJadwal; i++) {
                    _daftarJadwal.add(Jadwal(
                      namaMataKuliah: '',
                      jamPelajaran: '',
                      ruangan: '',
                      namaDosen: '',
                    ));
                  }
                  _generateFormJadwal();
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Isi Detail Jadwal Kuliah',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            ..._formJadwal,
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _daftarJadwal.forEach((jadwal) {
                    print('Nama Mata Kuliah : ${jadwal.namaMataKuliah}');
                    print('Jam Pelajaran    : ${jadwal.jamPelajaran}');
                    print('Ruangan          : ${jadwal.ruangan}');
                    print('Nama Dosen       : ${jadwal.namaDosen}');
                    print('===============================');
                  });
                });
              },
              child: Text(
                'Insert',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Jadwal Kuliah',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.lightBlueAccent, Colors.white],
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.lightBlueAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _daftarJadwal.length,
                itemBuilder: (context, index) {
                  final jadwal = _daftarJadwal[index];
                  return Card(
                    elevation: 3.0,
                    color: Colors.lightBlueAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jadwal Kuliah ${index + 1}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'Nama Mata Kuliah : ${jadwal.namaMataKuliah}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Jam Pelajaran    : ${jadwal.jamPelajaran}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Ruangan          : ${jadwal.ruangan}',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Nama Dosen       : ${jadwal.namaDosen}',
                            style: TextStyle(color: Colors.white),
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
}

void main() {
  runApp(MaterialApp(
    home: JadwalPage(),
  ));
}
