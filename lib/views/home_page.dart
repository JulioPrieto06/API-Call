import 'dart:ffi';

import 'package:api_rest_tuto/models/interes.dart';
import 'package:api_rest_tuto/services/remote_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Datum>? interes;
  var isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    interes = (await RemoteService().getPost());
    if (interes != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interes'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: interes?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Text(
                    interes![index].titulo,
                    style:
                        TextStyle(fontSize: 25, backgroundColor: Colors.green),
                  ),
                  Image.network(interes![index].fullUrl),
                ],
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
