import 'package:api_rest_tuto/models/interes.dart';
import 'package:api_rest_tuto/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Interes>? interes;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    //fetch data from API
    getData();
  }

  getData() async {
    interes = (await RemoteService().getIntereces()) as List<Interes>?;
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
                  child: Text(interes![index].message),
                );
              }),
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
