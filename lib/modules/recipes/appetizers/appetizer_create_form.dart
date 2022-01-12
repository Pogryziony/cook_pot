import 'dart:convert';

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
    _ingredientsQuantity = 0;
    _preparationStepsQuantity = 0;
    _result = '';
    _ingredientsValues = [];
    _preparationStepsValues = [];
    _preparationTime = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Scrollbar(
        child: Column(
          children: [
            Text('Recipe name'),
            TextFormField(
              controller: _appetizerNameController,
            ),
            Text('Image'),
            TextFormField(
              controller: _imageUrl,
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
            Text('Portions'),
            DropdownButton(
              hint: _portions == null
                  ? Text('Dropdown')
                  : Text(
                      _portions!,
                      style: TextStyle(color: Colors.blue),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(color: Colors.blue),
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
            Text('Preparation time:'),
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
            Text('Preparation steps'),
            Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _preparationStepsQuantity,
                  itemBuilder: (context, index) {
                    return _preparationRow(index);
                  }),
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
                        _preparationStepsQuantity = 0;
                        _preparationStepsValues.clear();
                      });
                    })
              ],
            ),
            Text('Test Result'),
            Expanded(child: Text(_result)),
            ElevatedButton(
                onPressed: () {
                  FirestoreSaveService(
                    //mocked data
                    name: 'Stuffed potatoes',
                    image: 'https://www.thespruceeats.com/thmb/dA8o8EZpjJyeocYZNpzfknoKh2s=/4351x3263/smart/filters:no_upscale()/baked-stuffed-potatoes-482217-hero-01-850f2d87fe80403f923e140dbf5f1bf3.jpg',
                    ingredients: ['Potatoes','Cream','Ham','Onion','Parsley','Egg'],
                    difficulty: _difficultyValue,
                    preparationTime: _preparationTime,
                    preparationSteps: ['Take inside of potato out','Mix potato with cream, egg and parsley','Cover drilled potato with ham','Stuff covered part with mix','Bake for 30 minutes'],
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
                child: Text('Submit'))
          ],
        ),
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

  _preparationRow(int key) {
    return Row(
      children: [
        Text('Step $key'),
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
