import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cook_pot/utils/services/firestore_save_service.dart';

class AppetizerCreateForm extends StatefulWidget {
  @override
  _AppetizerCreateFormState createState() => _AppetizerCreateFormState();
}

class _AppetizerCreateFormState extends State<AppetizerCreateForm> {
  final formKey = GlobalKey<FormState>();

  final appetizerNameController = TextEditingController();
  String? _difficultyValue;
  late int _ingredientsQuantity;
  late String _result;
  late List<Map<String, dynamic>> _ingredientsValues;
  late int _preparationTime;

  @override
  void initState() {
    super.initState();
    _ingredientsQuantity = 0;
    _result = '';
    _ingredientsValues = [];
    _preparationTime = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Text('Recipe name'),
          TextFormField(
            controller: appetizerNameController,
          ),
          Text('Difficulty'),
          DropdownButton(
            hint: _difficultyValue == null
                ? Text('Dropdown')
                : Text(
                    _difficultyValue!,
                    style: TextStyle(color: Colors.blue),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: Colors.blue),
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
          Text('Ingredients'),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _ingredientsQuantity,
                itemBuilder: (context, index) {
                  return _ingredientRow(index);
                }),
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
                      _ingredientsQuantity = 0;
                      _ingredientsValues.clear();
                    });
                  })
            ],
          ),
          Text('Ingredients'),
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _ingredientsQuantity,
                itemBuilder: (context, index) {
                  return _ingredientRow(index);
                }),
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
                      _ingredientsQuantity = 0;
                      _ingredientsValues.clear();
                    });
                  })
            ],
          ),
          Text('Test Result'),
          Expanded(child: Text(_result)),
          ElevatedButton(
              onPressed: () => (FirestoreSaveService(
                      name: appetizerNameController.text,
                      image:
                          'https://s3.przepisy.pl/przepisy3ii/img/variants/800x0/ziemniaki-faszerowane-po-chlopsku705394.jpg',
                      ingredients: _ingredientsValues,
                      difficulty: _difficultyValue,
                      preparationTime: 60,
                      preparationSteps: [
                        'Cook potatoes and pull out insides',
                        'Mix other ingredients',
                        'Add pepper and salt',
                        'Stuff potatoes with a mix',
                        'Bake for 30 minutes'
                      ],
                      tags: ['Vegetarian', 'Easy'],
                      type: 'appetizer',
                      ratings: 0.0)
                  .saveData()),
              child: Text('Submit'))
        ],
      ),
    );
  }

  _ingredientRow(int key) {
    return Row(
      children: [
        Text('Ingredient $key'),
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

  String _prettyPrint(jsonObject) {
    var encoder = JsonEncoder.withIndent('      ');

    return encoder.convert(jsonObject);
  }
}