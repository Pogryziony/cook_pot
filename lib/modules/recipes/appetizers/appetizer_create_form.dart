import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cook_pot/utils/services/firestore_save_service.dart';

class AppetizerCreateForm extends StatefulWidget {
  @override
  _AppetizerCreateFormState createState() => _AppetizerCreateFormState();
}

class _AppetizerCreateFormState extends State<AppetizerCreateForm> {
  final formKey = GlobalKey<FormState>();

  final _appetizerNameController = TextEditingController();
  final _imageUrl = TextEditingController();
  String? _difficultyValue;
  late int _ingredientsQuantity;
  late int _preparationStepsQuantity;
  late String _result;
  late List<Map<String, dynamic>> _ingredientsValues;
  late List<Map<String, dynamic>> _preparationStepsValues;
  late double _preparationTime;
  String? _portions;

  @override
  void initState() {
    super.initState();
    _ingredientsQuantity = 1;
    _preparationStepsQuantity = 1;
    _ingredientsValues = [];
    _preparationStepsValues = [];
    _preparationTime = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightGreen.shade100,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Recipe name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
                controller: _appetizerNameController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Image',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
                controller: _imageUrl,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Difficulty',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              DropdownButton(
                hint: _difficultyValue == null
                    ? Text(
                        'Select difficulty',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      )
                    : Text(
                        _difficultyValue!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
                items: ['Easy', 'Medium', 'Hard'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _difficultyValue = val as String;
                    },
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Preparation time',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Slider(
                value: _preparationTime,
                onChanged: (newPreparationTime) {
                  setState(() => _preparationTime = newPreparationTime);
                },
                label: _preparationTime.toStringAsFixed(0),
                min: 0,
                max: 360,
                divisions: 24,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Ingredients',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Scrollbar(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _ingredientsQuantity,
                      itemBuilder: (context, index) {
                        return _ingredientRow(index);
                      }),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        setState(() {
                          _ingredientsQuantity++;
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        setState(() {
                          _ingredientsQuantity = 1;
                          _ingredientsValues.clear();
                        });
                      })
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Preparation steps',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Scrollbar(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _preparationStepsQuantity,
                      itemBuilder: (context, index) {
                        return _preparationRow(index);
                      }),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        setState(() {
                          _preparationStepsQuantity++;
                        });
                      }),
                  IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        setState(() {
                          _preparationStepsQuantity = 1;
                          _preparationStepsValues.clear();
                        });
                      }),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                'Portions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              DropdownButton(
                hint: _portions == null
                    ? Text(
                        'Select number of portions',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      )
                    : Text(
                        _portions!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontStyle: FontStyle.italic),
                items: ['1', '2', '3', '4', '5', '6', '7'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _portions = val as String;
                    },
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  FirestoreSaveService(
                    //mocked data
                    name:
                        'Stuffed potatoesasdadaasdasasdadadadadadadadadasdsadsadada',
                    image:
                        'https://www.thespruceeats.com/thmb/dA8o8EZpjJyeocYZNpzfknoKh2s=/4351x3263/smart/filters:no_upscale()/baked-stuffed-potatoes-482217-hero-01-850f2d87fe80403f923e140dbf5f1bf3.jpg',
                    ingredients: [
                      'Potatoes',
                      'Cream',
                      'Ham',
                      'Onion',
                      'Parsley',
                      'Egg'
                    ],
                    difficulty: _difficultyValue,
                    preparationTime: _preparationTime,
                    preparationSteps: [
                      'Take inside of potato out',
                      'Mix potato with cream, egg and parsley',
                      'Cover drilled potato with ham',
                      'Stuff covered part with mix',
                      'Bake for 30 minutes'
                    ],
                    tags: ['Vegetarian', 'Easy'],
                    type: 'appetizer',
                    ratings: 0.0,
                    portions: _portions,
                    // name: _appetizerNameController.text,
                    // image: _imageUrl.text,
                    // ingredients: _ingredientsValues,
                    // difficulty: _difficultyValue,
                    // preparationTime: _preparationTime as int,
                    // preparationSteps: _preparationStepsValues,
                    // tags: ['Vegetarian', 'Easy'],
                    // type: 'appetizer',
                    // ratings: 0.0,
                    // portions: _portions,
                  ).saveData();
                  Navigator.of(context).pop();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ingredientRow(int key) {
    return Row(
      children: [
        Text(
          'Ingredient $key',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              _onIngredientUpdate(key, val);
            },
          ),
        ),
      ],
    );
  }

  _onIngredientUpdate(int key, String val) {
    int foundKey = -1;
    for (var ingredientsMap in _ingredientsValues) {
      if (ingredientsMap.containsKey('id')) {
        if (ingredientsMap['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _ingredientsValues.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {'id': key, 'value': val};
    _ingredientsValues.add(json);

    setState(() {
      _result = _prettyPrint(_ingredientsValues);
    });
  }

  _preparationRow(int key) {
    return Row(
      children: [
        Text(
          'Step $key',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 30),
        Expanded(
          child: TextFormField(
            onChanged: (val) {
              _onIngredientUpdate(key, val);
            },
          ),
        ),
      ],
    );
  }

  _onPreparationUpdate(int key, String val) {
    int foundKey = -1;
    for (var preparationStepsMap in _preparationStepsValues) {
      if (preparationStepsMap.containsKey('id')) {
        if (preparationStepsMap['id'] == key) {
          foundKey = key;
          break;
        }
      }
    }
    if (-1 != foundKey) {
      _preparationStepsValues.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }
    Map<String, dynamic> json = {'id': key, 'value': val};
    _preparationStepsValues.add(json);

    setState(() {
      _result = _prettyPrint(_preparationStepsValues);
    });
  }

  String _prettyPrint(jsonObject) {
    var encoder = JsonEncoder.withIndent('      ');

    return encoder.convert(jsonObject);
  }
}
