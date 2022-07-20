import 'dart:ffi';

import 'package:api_rest_tuto/comunicados/views/comunicados_page.dart';
import 'package:api_rest_tuto/interes/models/interes.dart';
import 'package:api_rest_tuto/interes/services/remote_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Comunicados(),
                  ));
            },
          )
        ],
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
                    style: const TextStyle(
                        fontSize: 25, backgroundColor: Colors.green),
                  ),
                  Image.network(interes![index].fullUrl),
                  Text(interes![index]
                          .fechaInicio
                          .toString() //+ (interes![index].fechaFin.toString()),
                      ),
                  Text(
                    interes![index].fechaFin.toString(),
                  ),
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
