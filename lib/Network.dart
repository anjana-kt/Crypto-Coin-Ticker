import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey='';

class NetworkHelper
{
  final String url;
  NetworkHelper(this.url);
  Future getData() async
  {
    http.Response response= await http.get(Uri.parse(url));

    if (response.statusCode <=250)
    {
      String data = response.body;
      var decodedData = jsonDecode(data);
      print("data fetched from network");
      return decodedData;
    }
    else{
      print(response.statusCode);
    }
  }

}