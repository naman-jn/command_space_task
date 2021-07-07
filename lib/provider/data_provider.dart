import 'package:command_space_task/models/movie_model.dart';
import 'package:command_space_task/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:command_space_task/services/api_service.dart';

/// Creates a `DataProvider`.
///
///A `state-management` solution for providing the `data` once it's fetched from the api.
///
/// This class creates an instance of [ChangeNotifier].
///
/// The `data` argument may be `null` in case there is http request error or parsing of the data to map.

class DataProvider with ChangeNotifier {
  bool loading = false;
  String year = '';
  List<Movie>? data;

  void fetchData() {
    loading = true;
    notifyListeners();
    if (int.parse(year) < 1919) {
      data = [];
      loading = false;
      notifyListeners();
      return;
    }
    ApiService().getData(year).then((value) {
      data = value;
      loading = false;
      notifyListeners();
    });
  }

  void fetchDatafromFirestore() {
    loading = true;
    notifyListeners();
    if (int.parse(year) < 2011) {
      data = [];
      loading = false;
      notifyListeners();
      return;
    }
    DatabaseService().getData(year).then((value) {
      data = value;
      loading = false;
      notifyListeners();
    });
  }
}
