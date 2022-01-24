import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/appetizers/appetizer_detail_screen.dart';
import 'package:cook_pot/modules/recipes/appetizers/recipes_screen.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterList extends StatefulWidget {
  FilterList({required this.onFiltered});

  Function onFiltered;

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  RangeValues _currentRangeValues = const RangeValues(0, 360);
  bool isEasy = false;
  bool isMedium = false;
  bool isHard = false;
  bool hasOneToThreeIngredients = false;
  bool hasFourToFiveIngredients = false;
  bool hasSixToSevenIngredients = false;
  bool hasMoreThanEightIngredients = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool hasMeat = false;
  String excludedIngredients = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Column(
            children: [
              Text("Difficulty"),
              Row(
                children: [
                  Text('Easy'),
                  Checkbox(
                      value: isEasy,
                      onChanged: (bool? value) {
                        setState(() {
                          isEasy = value!;
                        });
                      }),
                  Text('Medium'),
                  Checkbox(
                      value: isMedium,
                      onChanged: (bool? value) {
                        setState(() {
                          isMedium = value!;
                        });
                      }),
                  Text('Hard'),
                  Checkbox(
                      value: isHard,
                      onChanged: (bool? value) {
                        setState(() {
                          isHard = value!;
                        });
                      }),
                ],
              ),
              Text('Number of ingredients'),
              Row(
                children: [
                  Text('1-3'),
                  Checkbox(
                      value: hasOneToThreeIngredients,
                      onChanged: (bool? value) {
                        setState(() {
                          hasOneToThreeIngredients = value!;
                        });
                      }),
                  Text('4-5'),
                  Checkbox(
                      value: hasFourToFiveIngredients,
                      onChanged: (bool? value) {
                        setState(() {
                          hasFourToFiveIngredients = value!;
                        });
                      }),
                  Text('6-7'),
                  Checkbox(
                      value: hasSixToSevenIngredients,
                      onChanged: (bool? value) {
                        setState(() {
                          hasSixToSevenIngredients = value!;
                        });
                      }),
                  Text('8+'),
                  Checkbox(
                      value: hasMoreThanEightIngredients,
                      onChanged: (bool? value) {
                        setState(() {
                          hasMoreThanEightIngredients = value!;
                        });
                      }),
                ],
              ),
              Text('Tags'),
              Center(
                child: Row(
                  children: [
                    Text('Vegetarian'),
                    Checkbox(
                        value: isVegetarian,
                        onChanged: (bool? value) {
                          setState(() {
                            isVegetarian = value!;
                          });
                        }),
                    Text('Vegan'),
                    Checkbox(
                        value: isVegan,
                        onChanged: (bool? value) {
                          setState(() {
                            isVegan = value!;
                          });
                        }),
                  ],
                ),
              ),
              Text('Preparation time:'),
              RangeSlider(
                values: _currentRangeValues,
                onChanged: (RangeValues values) {
                  setState(() => _currentRangeValues = values);
                },
                min: 0.0,
                max: 360.0,
                divisions: 24,
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  return widget.onFiltered(isEasy);
                },
                //TODO kategoria przekazywana jest z kontekstu, którego używamy na poprzednim ekranie. Zamykanie okna jest robione przez pop.
                child: Text('Submit'),
              )
            ],
          ),
        ],
      ),
    );
  }
}

//
// var recipes = <Recipe>[]; // somehow you would fetch the initial list of items
// Iterator? filtered;
//
// double? lowPrice;
//
// void addLowPrice(double price) {
//   lowPrice = price;
//   rebuildFilter();
// }
//
// double? highPrice;
//
// void addHighPrice(double price) {
//   highPrice = price;
//   rebuildFilter();
// }
//
// var sizeOptions = <String>[];
//
// void addSizeFilter(String size) {
//   sizeOptions.add(size);
//   reubuildFilter();
// }
//
// void rebuildFilter() {
//   filtered = items
//       .where((e) =>
//           e.price >= lowPrice ?? 0 && e.price <= highPrice && double.infinity)
//       .where((e) => sizeOptions.isNotEmpty && sizeOptions.contains(e));
//
//   notifyListeners();
// }
//
// void removeFilters() {
//   lowPrice = null;
//   highPrice = null;
//   sizeOptions.clear();
//   filtered = null;
//
//   notifyListeners();
// }
//
// void getFiltered() => filtered ?? items;
