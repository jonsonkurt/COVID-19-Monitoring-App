import 'dart:convert';
import 'package:covid/Model/world_states_model.dart';
import 'package:covid/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;


class StatesServices{

  Future<World_cases> fetchWorledStatesRecords() async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));



    if(response.statusCode== 200)
      {
        var data = jsonDecode(response.body);

        return World_cases.fromJson(data);
      }

    else
      {
        throw Exception('ERROR');
      }

  }



  Future<List<dynamic>> countriesListApi() async{

    var data;

    final response = await http.get(Uri.parse(AppUrl.countriesList));



    if(response.statusCode== 200)
    {
      data = jsonDecode(response.body);
      return data;
    }

    else
    {
      throw Exception('ERROR');
    }

  }

}