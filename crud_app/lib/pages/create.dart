import 'package:crud_app/helper/api.dart';
import 'package:crud_app/helper/openDialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final api = Api();
  final _key = GlobalKey<FormState>();
  String nama = "";
  String no_handphone = "";

  void _simpan() async {
    if (_key.currentState!.validate()) {
      openDialog(
        context: context,
        title: "LOADING",
        child: Row(
          children: [
            SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
            SizedBox(width: 10),
            Text("Menyimpan data..."),
          ],
        ),
        action: [],
      );

      await api.dio
          .post(
            "simpan.php",
            data: FormData.fromMap({
              "nama": nama,
              "no_handphone": no_handphone,
            }),
          )
          .then((respon) {
            Navigator.pop(context);
            if (respon.data["status"] == "success") {
              openDialog(
                context: context,
                title: "Sukses",
                child: Text("Data berhasil di simpan"),
                action: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, "refresh");
                      Navigator.pop(context, "refresh");
                    },
                    child: Text("Ok"),
                  ),
                ],
              );
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
        title: Text(
          'Tambah Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (e) {
                    setState(() {
                      nama = e;
                    });
                  },
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Nama tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text("Nama"),
                    hint: Text("Masukkan nama lengkap anda..."),
                  ),
                ),
                SizedBox(height: 10),

                TextFormField(
                  onChanged: (e) {
                    setState(() {
                      no_handphone = e;
                    });
                  },
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Nama tidak boleh kosong";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    label: Text("No Handphone"),
                    hint: Text("Masukkan nomor hp anda..."),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      _simpan();
                    },
                    child: Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
