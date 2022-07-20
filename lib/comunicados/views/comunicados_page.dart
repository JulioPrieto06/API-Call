import 'package:api_rest_tuto/comunicados/services/remote_services.dart';
import 'package:api_rest_tuto/interes/views/interes_page.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';

import '../models/comunicados.dart';

class Comunicados extends StatefulWidget {
  const Comunicados({Key? key}) : super(key: key);

  @override
  State<Comunicados> createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {
  List<Datum>? comunicados;
  var isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    comunicados = (await RemoteService().getPost());
    if (comunicados != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Comunicados',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
            )
          ]),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: comunicados?.length,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  Text(
                    comunicados![index].titulo,
                    style: const TextStyle(
                        fontSize: 15, backgroundColor: Colors.green),
                  ),
                  Image.network(comunicados![index].fullUrl),
                  SingleChildScrollView(
                    child: Html(
                      data: comunicados![index].contenido,
                    ),
                  )
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
