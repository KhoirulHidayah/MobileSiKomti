import 'package:flutter/material.dart';
import 'package:sikomti_mobile/models/mahasiswa_alpha.dart';
import 'package:sikomti_mobile/services/data_service.dart';

class CreateAlphaScreen extends StatefulWidget {
  @override
  _CreateAlphaScreenState createState() => _CreateAlphaScreenState();
}

class _CreateAlphaScreenState extends State<CreateAlphaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _niController = TextEditingController();
  final _namaController = TextEditingController();
  final _jamAlphaController = TextEditingController();
  final _semesterController = TextEditingController();
  final _jamKompenController = TextEditingController();

  @override
  void dispose() {
    _niController.dispose();
    _namaController.dispose();
    _jamAlphaController.dispose();
    _semesterController.dispose();
    _jamKompenController.dispose();
    super.dispose();
  }

  void _createMahasiswaAlpha() async {
    if (_formKey.currentState!.validate()) {
      final newMahasiswaAlpha = MahasiswaAlpha(
        idAlpha: 0, // Placeholder, will be replaced by server
        ni: _niController.text,
        nama: _namaController.text,
        jamAlpha: int.parse(_jamAlphaController.text),
        semester: _semesterController.text,
        jamKompen: _jamKompenController.text.isNotEmpty
            ? int.parse(_jamKompenController.text)
            : null,
      );

      try {
        final dataService = DataService();
        final response =
            await dataService.createMahasiswaAlpha(newMahasiswaAlpha);

        if (response['message'] ==
            'Data mahasiswa alpha berhasil ditambahkan.') {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Sukses'),
                content: Text(response['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context)
                          .pop(true); // Return to previous page with success
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create data')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create data')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Mahasiswa Alpha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _niController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter NIM';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Nama';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jamAlphaController,
                decoration: InputDecoration(labelText: 'Jam Alpha'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Jam Alpha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _semesterController,
                decoration: InputDecoration(labelText: 'Semester'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Semester';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jamKompenController,
                decoration: InputDecoration(labelText: 'Jam Kompen'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createMahasiswaAlpha,
                child: Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
