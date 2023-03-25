import 'package:cook_pot/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class FilterList extends StatefulWidget {
  FilterList({required this.onFiltered});

  final Function onFiltered;
  final List<String> ingredientList = IngredientList().getIngredientList();

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, bool> difficultyValues = {
    'Easy': false,
    'Medium': false,
    'Hard': false,
  };
  late RangeValues _currentRangeValues = const RangeValues(0, 360);
  late int minPrepValue = 0;
  late int maxPrepValue = 360;
  final Map<String, bool> portionsValues = {
    '1': false,
    '2': false,
    '3': false,
    '4': false,
    '5': false,
    '6': false,
    '7': false,
  };
  late List<String> ingredientList;
  TextfieldTagsController _controller = new TextfieldTagsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade100,
      appBar: AppBar(
        title: Text('Filter list'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.autorenew,
                color: Colors.black,
              ),
              onPressed: () => {
                    setState(() {
                      difficultyValues.forEach((key, value) {
                        difficultyValues[key] = false;
                      });
                      _currentRangeValues = RangeValues(0, 360);
                      portionsValues.forEach((key, value) {
                        portionsValues[key] = false;
                      });
                    }),
                  }),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Difficulty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: difficultyValues.keys.map((String key) {
                  return SizedBox(
                    width: 138,
                    child: CheckboxListTile(
                      title: Text(key),
                      value: difficultyValues[key],
                      onChanged: (bool? value) {
                        setState(() {
                          difficultyValues[key] = value!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Text(
            'Ingredients',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Autocomplete<String>(
            optionsViewBuilder: (context, onSelected, options) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dynamic option = options.elementAt(index);
                          return TextButton(
                            onPressed: () {
                              onSelected(option);
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text(
                                  '#$option',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 74, 137, 92),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return widget.ingredientList.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selectedTag) {
              _controller.addTag = selectedTag;
            },
            fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
              return TextFieldTags(
                textEditingController: ttec,
                focusNode: tfn,
                textfieldTagsController: _controller,
                textSeparators: const [' ', ',', ';'],
                letterCase: LetterCase.normal,
                validator: (String tag) {
                  if (_controller.getTags!.contains(tag)) {
                    return 'you already entered that';
                  } else
                    return null;
                },
                inputfieldBuilder:
                    (context, tec, fn, error, onChanged, onSubmitted) {
                  return ((context, sc, tags, onTagDelete) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: tec,
                        focusNode: fn,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 74, 137, 92),
                                width: 3.0),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightGreen,
                                width: 3.0),
                          ),
                          helperText: 'Enter ingredients...',
                          helperStyle: const TextStyle(
                            color: Colors.lightGreen,
                          ),
                          hintText: _controller.hasTags ? '' : "Enter tag...",
                          errorText: error,
                          prefixIcon: tags.isNotEmpty
                              ? SingleChildScrollView(
                                  controller: sc,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Colors.lightGreen,
                                      ),
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '$tag',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onTap: () {
                                              print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Colors.white54,
                                            ),
                                            onTap: () {
                                              onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                )
                              : null,
                        ),
                        onChanged: onChanged,
                        onSubmitted: onSubmitted,
                      ),
                    );
                  });
                },
              );
            },
          ),
          ElevatedButton(

            onPressed: () {
              _controller.clearTags();
            },
            child: const Text('Clear tags'),
          ),
          Text(
            'Preparation time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 360,
              divisions: 24,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              }),
          Text(
            'Portions',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: portionsValues.keys.map((String key) {
                  return SizedBox(
                    width: 75,
                    child: CheckboxListTile(
                      title: Text(key),
                      value: portionsValues[key],
                      onChanged: (bool? value) {
                        setState(() {
                          portionsValues[key] = value!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                minPrepValue = _currentRangeValues.start.round();
                maxPrepValue = _currentRangeValues.end.round();
                ingredientList = _controller.getTags!;
                Navigator.of(context).pop();
                return widget.onFiltered(
                  difficultyValues,
                  portionsValues,
                  minPrepValue,
                  maxPrepValue,
                );
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
