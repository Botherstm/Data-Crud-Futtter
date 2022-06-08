// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:belajar_data_crud_flutter/models/http_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// import 'package:rest_api_dart/models/get_provider.dart';

// ignore: must_be_immutable
class GetData extends StatelessWidget {
  late Uri apiUrl = Uri.parse("http://localhost:8080/restapi_server/index.php");

  GetData({Key? key}) : super(key: key);
  Future<List<dynamic>> _fecthDataUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['data'];
  }

  @override
  Widget build(BuildContext context) {
    // memanggil provider untuk delete
    final dataProvider = Provider.of<HttpProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          RaisedButton(
            onPressed: () {
              Route route = MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (context) => HttpProvider(), child: GetData()));
              Navigator.push(context, route);
            },
            color: Colors.green,
            child: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _fecthDataUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Route route = MaterialPageRoute(
                          builder: (context) => const SingleUser());
                      Navigator.push(context, route);
                    },
                    child: ListTile(
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  dataProvider.deleteData(
                                    snapshot.data[index]["id"].toString(),
                                  );
                                  Route route = MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (context) =>
                                                  HttpProvider(),
                                              child: const Tambah()));
                                  Navigator.push(context, route);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Data Berhasil Dihapus"),
                                    ),
                                  );
                                }),
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Route route = MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (context) =>
                                                  HttpProvider(),
                                              child: const Ubah()));
                                  IdSingleUser.id =
                                      snapshot.data[index]["id"].toString();
                                  IdSingleUser.nim =
                                      snapshot.data[index]["nim"].toString();
                                  IdSingleUser.nama =
                                      snapshot.data[index]["nama"].toString();
                                  IdSingleUser.jk =
                                      snapshot.data[index]["jk"].toString();
                                  IdSingleUser.alamat =
                                      snapshot.data[index]["alamat"].toString();
                                  IdSingleUser.jurusan = snapshot.data[index]
                                          ["jurusan"]
                                      .toString();
                                  Navigator.push(context, route);
                                }),
                          ],
                        ),
                      ),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://i.postimg.cc/x8kRSrZY/lipan.jpg"),
                      ),
                      title: Text(snapshot.data[index]['nama']),
                      subtitle: Text(snapshot.data[index]['nim']),
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Tambah extends StatefulWidget {
  const Tambah({Key? key}) : super(key: key);

  @override
  State<Tambah> createState() => _Tambah();
}

class _Tambah extends State<Tambah> {
  @override
  Widget build(BuildContext context) {
    // membuat file dataProvider
    final dataProvider = Provider.of<HttpProvider>(context, listen: false);

    final formKey = GlobalKey<FormState>();

    // instasiasi class
    InputData dataValue = InputData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Method"),
      ),
      body: Form(
        key: formKey, // key form like id
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "masukan nim lengkap anda",
                    labelText: "NIM",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NIM tidak boleh kosong';
                    }
                    dataValue.nim = value.toString();
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "masukan nama lengkap anda",
                    labelText: "Nama Lengkap",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    dataValue.nama = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "masukan jenis kelamin anda",
                    labelText: "Jenis Kelamin",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jenis Kelamin tidak boleh kosong';
                    }
                    dataValue.jk = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "masukan alamat anda",
                    labelText: "Alamat",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    dataValue.alamat = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  decoration: InputDecoration(
                    hintText: "masukan jurusan anda",
                    labelText: "Jurusan",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jurusan tidak boleh kosong';
                    }
                    dataValue.jurusan = value;
                    return null;
                  }),
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    dataProvider.connectAPI(
                      dataValue.nim,
                      dataValue.nama,
                      dataValue.jk,
                      dataValue.alamat,
                      dataValue.jurusan,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data Berhasil Ditambahkan"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Tambahkan Data",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

// // get data ListUser
// ignore: must_be_immutable, use_key_in_widget_constructors

// Class Update Data
class Ubah extends StatefulWidget {
  const Ubah({Key? key}) : super(key: key);

  @override
  State<Ubah> createState() => _UbahState();
}

class _UbahState extends State<Ubah> {
  @override
  Widget build(BuildContext context) {
    // membuat file dataProvider
    final dataProvider = Provider.of<HttpProvider>(context, listen: false);

    final formKey = GlobalKey<FormState>();

    // instasiasi class
    InputData dataValue = InputData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("UBAH DATA"),
      ),
      body: Form(
        key: formKey, // key form like id
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                  //untuk menimpa data lama
                  initialValue: IdSingleUser.nim,
                  decoration: InputDecoration(
                    hintText: "masukan nim lengkap anda",
                    labelText: "NIM",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'NIM tidak boleh kosong';
                    }
                    dataValue.nim = value.toString();
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  //untuk menimpa data lama
                  initialValue: IdSingleUser.nama,
                  decoration: InputDecoration(
                    hintText: "masukan nama lengkap anda",
                    labelText: "Nama Lengkap",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    dataValue.nama = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  //untuk menimpa data lama
                  initialValue: IdSingleUser.jk,
                  decoration: InputDecoration(
                    hintText: "masukan jenis kelamin anda",
                    labelText: "Jenis Kelamin",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jenis Kelamin tidak boleh kosong';
                    }
                    dataValue.jk = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  //untuk menimpa data lama
                  initialValue: IdSingleUser.alamat,
                  decoration: InputDecoration(
                    hintText: "masukan alamat anda",
                    labelText: "Alamat",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                    dataValue.alamat = value;
                    return null;
                  }),
              const SizedBox(height: 20),
              TextFormField(
                  //untuk menimpa data lama
                  initialValue: IdSingleUser.jurusan,
                  decoration: InputDecoration(
                    hintText: "masukan jurusan anda",
                    labelText: "Jurusan",
                    // icon: Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Jurusan tidak boleh kosong';
                    }
                    dataValue.jurusan = value;
                    return null;
                  }),
              const SizedBox(height: 30),
              RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    dataProvider.updateData(
                      IdSingleUser.id,
                      dataValue.nim,
                      dataValue.nama,
                      dataValue.jk,
                      dataValue.alamat,
                      dataValue.jurusan,
                    );
                    // ignore: unused_local_variable
                    Route route = MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) => HttpProvider(),
                            child: GetData()));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Data Berhasil Update!"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Update Data",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dalam Perkembangan! - Anom Mudita Ganteng
class SingleUser extends StatefulWidget {
  const SingleUser({Key? key}) : super(key: key);

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET - Maintenance"),
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: [
              const FittedBox(
                  child: Text("ID : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["id"] == null)
                        ? "Belum ada data"
                        : value.data["id"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const FittedBox(
                  child: Text("NIM : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["nim"] == null)
                        ? "Belum ada data"
                        : value.data["id"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const FittedBox(
                  child: Text("Nama : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["nama"] == null)
                        ? "Belum ada data"
                        : value.data["nama"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const FittedBox(
                  child:
                      Text("Jenis Kelamin : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["jk"] == null)
                        ? "Belum ada data"
                        : value.data["jk"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const FittedBox(
                  child: Text("Alamat : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["alamat"] == null)
                        ? "Belum ada data"
                        : value.data["alamat"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const FittedBox(
                  child: Text("Jurusan : ", style: TextStyle(fontSize: 20))),
              FittedBox(
                child: Consumer<HttpProvider>(
                  builder: (context, value, child) => Text(
                    (value.data["jurusan"] == null)
                        ? "Belum ada data"
                        : value.data["jurusan"],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 50),
              OutlinedButton(
                onPressed: () {
                  // String value = "1";
                  // HttpStateful.connectAPI(value.toString()).then(
                  //   (value) {
                  //     setState(() {
                  //       dataResponse = value;
                  //     });
                  //   },
                  // );
                },
                child: const Text(
                  "GET DATA 1",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
