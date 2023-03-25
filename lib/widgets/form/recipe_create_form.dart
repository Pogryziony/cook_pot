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
  final GlobalKey<FormState>_recipeCreateFormKey = GlobalKey();
  final validator = Validator();

  final _recipeNameController = TextEditingController();
  final _imageUrl = TextEditingController();
  late String _difficultyValue;
  late double _preparationTime;
  late String _portions;
  var ingredientNameTECs = <TextEditingController>[];
  var ingredientQuantityTECs = <TextEditingController>[];
  var preparationStepTECs = <TextEditingController>[];
  var ingredientCards = <Card>[];
  var preparationStepCards = <Card>[];

  @override
  void initState() {
    super.initState();
    _preparationTime = 0;
    _recipeNameController.text = '';
    _imageUrl.text = '';
    _portions = '';
    _difficultyValue = '';
    ingredientCards.add(createIngredientCard());
    preparationStepCards.add(createPreparationStepCard());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _recipeCreateFormKey,
      backgroundColor: Colors.lightGreen.shade100,
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
        title: Text('Add new recipe'),
      ),
      body: Scrollbar(
        thickness: 10,
        hoverThickness: 2,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: _recipeNameController,
                  validator:(value) => validator.isNotEmpty(value),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Recipe name',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    focusColor: Colors.black,
                  ),
                ),
                TextFormField(
                  controller: _imageUrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Image URL',
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    focusColor: Colors.black,
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.lightGreen.shade100,
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
                  hint: _difficultyValue == ''
                      ? Text(
                          'Select difficulty',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        )
                      : Text(
                          _difficultyValue,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
                ),
                Text(
                  'Preparation time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
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
                Text(
                  'Ingredients',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Scrollbar(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: ingredientCards.length,
                            itemBuilder:
                                (BuildContext context, int ingredientIndex) {
                              return ingredientCards[ingredientIndex];
                            },
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                child: Text('Add new ingredient'),
                                onPressed: () => setState(() => ingredientCards
                                    .add(createIngredientCard())),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  child: Text('Clear ingredients'),
                                  onPressed: () => {
                                        setState(() => ingredientCards.clear()),
                                        setState(() => ingredientCards
                                            .add(createIngredientCard())),
                                      }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Preparation steps',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Scrollbar(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: preparationStepCards.length,
                            itemBuilder: (BuildContext context,
                                int preparationStepIndex) {
                              return preparationStepCards[preparationStepIndex];
                            },
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                child: Text('Add new step'),
                                onPressed: () => setState(() =>
                                    preparationStepCards
                                        .add(createPreparationStepCard())),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                child: Text('Clear steps'),
                                onPressed: () => {
                                  setState(() => preparationStepCards.clear()),
                                  setState(() => preparationStepCards
                                      .add(createPreparationStepCard()))
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DropdownButton(
                  isExpanded: true,
                  dropdownColor: Colors.lightGreen.shade50,
                  hint: _portions == ''
                      ? Text(
                          'Select number of portions',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        )
                      : Text(
                          _portions,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        ),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                      onPressed: onButtonPressed, child: Text('Submit')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card createIngredientCard() {
    var ingredientName = TextEditingController();
    var ingredientQuantity = TextEditingController();
    ingredientNameTECs.add(ingredientName);
    ingredientQuantityTECs.add(ingredientQuantity);
    return Card(
      color: Colors.lightGreen.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Ingredient ${ingredientCards.length + 1}'),
          TextField(
              controller: ingredientName,
              decoration: InputDecoration(
                hintText: 'Ingredient name',
                hintStyle: TextStyle(color: Colors.blueGrey),
              )),
          TextField(
              controller: ingredientQuantity,
              decoration: InputDecoration(
                hintText: 'Ingredient quantity',
                hintStyle: TextStyle(color: Colors.blueGrey),
              )),
        ],
      ),
    );
  }

  Card createPreparationStepCard() {
    var preparationStep = TextEditingController();
    preparationStepTECs.add(preparationStep);
    return Card(
      color: Colors.lightGreen.shade50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Step ${preparationStepCards.length + 1}'),
          TextField(
              controller: preparationStep,
              decoration: InputDecoration(
                hintText: 'Preparation step',
                hintStyle: TextStyle(color: Colors.blueGrey),
              )),
        ],
      ),
    );
  }

  onButtonPressed() {
      List<Ingredient> entries = [];
      for (int i = 0; i < ingredientCards.length; i++) {
        var ingredientNames = ingredientNameTECs[i].text;
        var ingredientQuantities = ingredientQuantityTECs[i].text;
        entries.add(
            Ingredient(name: ingredientNames, quantity: ingredientQuantities));
      }

      List<PreparationStep> preparationStepEntries = [];
      for (int j = 0; j < preparationStepCards.length; j++) {
        var preparationSteps = preparationStepTECs[j].text;
        preparationStepEntries.add(PreparationStep(step: preparationSteps));
      }

      BlocProvider.of<RecipesBloc>(context).add(
        AddRecipeEvent(
          Recipe(
            name: _recipeNameController.text,
            image:_imageUrl.text,
              //  'https://www.thespruceeats.com/thmb/dA8o8EZpjJyeocYZNpzfknoKh2s=/4351x3263/smart/filters:no_upscale()/baked-stuffed-potatoes-482217-hero-01-850f2d87fe80403f923e140dbf5f1bf3.jpg',
            ingredients: entries,
            difficulty: _difficultyValue,
            preparationTime: _preparationTime,
            preparationSteps: preparationStepEntries,
            type: BlocProvider.of<RecipesBloc>(context).category.toString(),
            portions: _portions,
            // portions: _portions,
          ),
        ),
      );
    }
  }

