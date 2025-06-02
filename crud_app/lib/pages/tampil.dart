import 'package:crud_app/helper/api.dart';
import 'package:crud_app/helper/openDialog.dart';
import 'package:crud_app/pages/create.dart';
import 'package:crud_app/pages/edit.dart';
import 'package:flutter/material.dart';

class Tampil extends StatefulWidget {
  const Tampil({super.key});

  @override
  State<Tampil> createState() => _TampilState();
}

class _TampilState extends State<Tampil> {
  final api = Api();
  List data = [];
  bool isLoading = false;
  void _getData() async {
    setState(() {
      isLoading = true;
    });
    await api.dio.get("get.php").then((respon) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        data = respon.data["data"];
      });
    });
  }

  void _delete(String id) async {
    Navigator.pop(context);
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

    await api.dio.delete("delete.php?id=" + id).then((respon) {
      if (respon.data["status"] == "success") {
        Navigator.pop(context);
        openDialog(
          context: context,
          title: "Sukses",
          child: Text("DATA BERHASILS DI HAPUS"),
          action: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        );
        _getData();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Create();
                  },
                ),
              ).then((res) {
                print(res);
                if (res == "sukses") {
                  _getData();
                }
              });
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
        title: Text(
          'Data',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? Center(child: Text("Mengmbail data"))
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(item["nama"][0].toString().toUpperCase()),
                  ),
                  title: Text(item["nama"]),
                  subtitle: Text(item["no_handphone"]),
                  trailing: Container(
                    width: 80,
                    height: 100,

                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Edit(data: item);
                                },
                              ),
                            ).then((value) {
                              print(value);
                              if (value == "refresh") {
                                _getData();
                              }
                            });
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            openDialog(
                              context: context,
                              title: "Perhatian",
                              child: Text("Apakah anda ingin hapus data ini"),
                              action: [
                                TextButton(
                                  onPressed: () {
                                    _delete(item["id"]);
                                  },
                                  child: Text("Ya"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Tidak"),
                                ),
                              ],
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
