import 'package:cook_pot/models/recipe.dart';
import 'package:cook_pot/modules/recipes/bloc/recipes_bloc.dart';
import 'package:cook_pot/utils/helpers/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipeCreateForm extends StatefulWidget {
  static var routeName = '/recipeCreateForm';

  @override
  _RecipeCreateFormState createState() => _RecipeCreateFormState();
}

class _RecipeCreateFormState extends State<RecipeCreateForm> {
  final formKey = GlobalKey<FormState>();
  final validator = Validator();

  final _recipeNameController = TextEditingController();
  final _imageUrl = TextEditingController();
  String? _difficultyValue;
  late int _ingredientsQuantity;
  late String _measurement;
  late int _preparationStepsQuantity;
  late List<Map<String, dynamic>> _ingredientsValues;
  late List<Map<String, dynamic>> _preparationStepsValues;
  late double _preparationTime;
  String? _portions;

  @override
  void initState() {
    super.initState();
    _ingredientsQuantity = 1;
    _preparationStepsQuantity = 1;
    _preparationTime = 0;
    _recipeNameController.text = '';
    _imageUrl.text = '';
    _ingredientsValues = [];
    _preparationStepsValues  = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/recipeScreen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Scrollbar(
        key: formKey,
        thickness: 10,
        hoverThickness: 2,
        child: SingleChildScrollView(
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
                TextField(
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.italic),
                  controller: _recipeNameController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  'Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextField(
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
                SizedBox(
                  height: 175,
                  child: Scrollbar(
                    child: ListView.builder(
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
                  onPressed: () => {
                    onButtonPressed(),
                    Navigator.of(context).pushReplacementNamed('/recipeScreen'),
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ingredientRow(int key) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Padding(padding: EdgeInsets.only(left: 10)),
          SizedBox(
            width: 225,
            child: TextField(
              maxLength: 35,
              onChanged: (val) {
                _onIngredientUpdate(key, val);
              },
            ),
          ),
          VerticalDivider(
            width: 20,
            thickness: 1,
            color: Colors.black,
            indent: 30,
            endIndent: 10,
          ),
          SizedBox(
            width: 55,
            child: TextField(
              maxLength: 7,
              onChanged: (val) {
                _onIngredientUpdate(key, val);
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          DropdownButton(
            hint: Text('pcs'),
            items: ['pcs', 'ml', 'g'].map(
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
                  _measurement = val as String;
                },
              );
            },
          )
        ],
      ),
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
  }

  _preparationRow(int key) {
    key = key + 1;
    return Row(
      children: [
        Text(
          'Step $key',
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 30),
        Expanded(
          child: TextField(
            onChanged: (val) {
              _onPreparationUpdate(key, val);
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
  }

  onButtonPressed() {
    BlocProvider.of<RecipesBloc>(context).add(
      AddRecipeEvent(
        Recipe(
          name: _recipeNameController.text,
          image:
              'https://www.thespruceeats.com/thmb/dA8o8EZpjJyeocYZNpzfknoKh2s=/4351x3263/smart/filters:no_upscale()/baked-stuffed-potatoes-482217-hero-01-850f2d87fe80403f923e140dbf5f1bf3.jpg',
          ingredients: _ingredientsValues,
          difficulty: _difficultyValue,
          preparationTime: _preparationTime,
          preparationSteps: _preparationStepsValues,
          type: BlocProvider.of<RecipesBloc>(context).category.toString(),
          portions: _portions,
        ),
      ),
    );
  }
}
