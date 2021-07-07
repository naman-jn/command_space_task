import 'package:command_space_task/constants.dart';
import 'package:command_space_task/provider/data_provider.dart';
import 'package:command_space_task/views/movies_list_page.dart';
import 'package:command_space_task/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final yearController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final moviesProvider = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(minWidth: 240),
          width: screenWidth * 0.5,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field can't be empty";
                    }
                    try {
                      if (int.parse(value) > 2021) {
                        return "PLease enter a valid year";
                      }
                    } catch (e) {
                      return "PLease enter a valid year";
                    }
                    return null;
                  },
                  controller: yearController,
                  decoration: InputDecoration(
                    hintText: 'Enter a year',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 2, color: kNavy)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kNavy)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kNavy.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: "Fetch Movies from API",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      moviesProvider.year = yearController.text.trim();
                      moviesProvider.fetchData();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieListPage()));
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  text: "Fetch Movies from Firestore",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      moviesProvider.year = yearController.text.trim();
                      moviesProvider.fetchDatafromFirestore();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieListPage()));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
