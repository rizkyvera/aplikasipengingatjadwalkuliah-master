import 'package:flutter/material.dart';

class UjianPage extends StatefulWidget {
  @override
  _UjianPageState createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  int _jumlahUjian = 0; // Variabel untuk menyimpan jumlah ujian
  List<Map<String, String>> _listJadwalUjian = []; // List untuk menyimpan data jadwal ujian

  // Controller untuk mengelola input pada TextFormField
  List<TextEditingController> _namaMataKuliahControllers = [];
  List<TextEditingController> _tanggalUjianControllers = [];
  List<TextEditingController> _lokasiUjianControllers = [];
  List<TextEditingController> _namaDosenControllers = [];
  DateTime? _selectedDate;

  @override
  void dispose() {
    // Clean up controller ketika widget di dispose
    for (var controller in _namaMataKuliahControllers) {
      controller.dispose();
    }
    for (var controller in _tanggalUjianControllers) {
      controller.dispose();
    }
    for (var controller in _lokasiUjianControllers) {
      controller.dispose();
    }
    for (var controller in _namaDosenControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Ujian'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50], // Warna latar belakang biru muda
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jumlah Ujian:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _jumlahUjian = int.tryParse(value) ?? 0;
                          _namaMataKuliahControllers.clear();
                          _tanggalUjianControllers.clear();
                          _lokasiUjianControllers.clear();
                          _namaDosenControllers.clear();
                          for (int i = 0; i < _jumlahUjian; i++) {
                            _namaMataKuliahControllers.add(TextEditingController());
                            _tanggalUjianControllers.add(TextEditingController());
                            _lokasiUjianControllers.add(TextEditingController());
                            _namaDosenControllers.add(TextEditingController());
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Jumlah Ujian',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Tambah Jadwal Ujian:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Column(
                children: List.generate(
                  _jumlahUjian,
                  (index) {
                    return Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50], // Warna latar belakang biru muda
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ujian ${index + 1}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _namaMataKuliahControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Nama Mata Kuliah',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              _selectDate(context, index);
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: _tanggalUjianControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Tanggal Ujian',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _lokasiUjianControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Lokasi Ujian',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _namaDosenControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Nama Dosen',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lakukan sesuatu ketika tombol "Simpan" ditekan
                  // Contoh: menyimpan data ke database atau melakukan validasi
                  // Anda dapat mengakses data yang diinput melalui controllers
                  setState(() {
                    _listJadwalUjian.clear();
                    for (int i = 0; i < _jumlahUjian; i++) {
                      _listJadwalUjian.add({
                        'Nama Mata Kuliah': _namaMataKuliahControllers[i].text,
                        'Tanggal Ujian': _tanggalUjianControllers[i].text,
                        'Lokasi Ujian': _lokasiUjianControllers[i].text,
                        'Nama Dosen': _namaDosenControllers[i].text,
                      });
                    }
                  });
                },
                child: Text(
                  'Simpan',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Ubah warna button menjadi biru
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Data yang telah disimpan:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              // Menampilkan data yang telah disimpan
              ListView.builder(
                shrinkWrap: true,
                itemCount: _listJadwalUjian.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Ujian ${index + 1}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _listJadwalUjian[index].entries.map((entry) {
                          return Text('${entry.key}: ${entry.value}');
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _tanggalUjianControllers[index].text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";
      });
  }
}