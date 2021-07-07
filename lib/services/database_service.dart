import 'dart:convert';
import 'package:command_space_task/models/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference moviesCollection;
  DatabaseService() {
    firebaseFirestore = FirebaseFirestore.instance;
    moviesCollection = firebaseFirestore.collection("movies");
  }

  ///Method to fetch the required data from api and parse it to [Movie].
  ///
  ///returns `null` value  in case of any `error`
  Future<List<Movie>?> getData(String year) async {
    var docSnapshot = await moviesCollection.doc(year).get();

    Map<String, dynamic> result = docSnapshot.data() as Map<String, dynamic>;
    print(Movie.fromMap(result['results'].first));

    List results = result['results'];
    return results
        .map((movieData) => Movie.fromJson(json.encode(movieData)))
        .toList();
  }

  Future<List<Movie>?> setData(String year, List results) async {
    await moviesCollection.doc(year).set({"results": results});
  }
}
