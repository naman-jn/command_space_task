import 'dart:convert';
import 'package:command_space_task/models/movie_model.dart';
import 'package:command_space_task/services/database_service.dart';
import 'package:dio/dio.dart';

class ApiService {
  Future<List<Movie>?> getData(String year) async {
    String url =
        "https://api.themoviedb.org/3/discover/movie?primary_release_year=$year&api_key=487921d70f7cdfa484c1c0c1828443c4";
    try {
      var response = await Dio().get(url).catchError((e) {
        //exception explicitly thrown as dio doesn't do so by default
        throw "http error->$e";
      });

      Map<String, dynamic> result = jsonDecode(response.toString());
      print(Movie.fromMap(result['results'].first));
      List results = result['results'];
      var newRes = results
          .map((movieData) => Movie.fromJson(json.encode(movieData)))
          .toList();

      var finRes = newRes.map((e) => e.toMap()).toList();
      DatabaseService().setData(year, finRes);
      return results
          .map((movieData) => Movie.fromJson(json.encode(movieData)))
          .toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
