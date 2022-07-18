import 'package:api_rest_tuto/models/interes.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Datum>?> getPost() async {
    var client = http.Client();

    var uri = Uri.parse('https://portalempleado.um.edu.mx/API/interes/leer/');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return Datum.map<Datum>(Datum.fromJson).toList();
    }
  }
}
