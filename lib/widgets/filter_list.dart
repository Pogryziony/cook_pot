import 'package:flutter/material.dart';

class FilterList extends StatefulWidget {
  FilterList({required this.onFiltered});

  final Function onFiltered;

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
        children: [
          Text(
            'Difficulty',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: difficultyValues.keys.map((String key) {
                return new CheckboxListTile(
                  title: Text(key),
                  value: difficultyValues[key],
                  onChanged: (bool? value) {
                    setState(() {
                      difficultyValues[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
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
            child: ListView(
              shrinkWrap: true,
              children: portionsValues.keys.map((String key) {
                return new CheckboxListTile(
                  title: Text(key),
                  value: portionsValues[key],
                  onChanged: (bool? value) {
                    setState(() {
                      portionsValues[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                minPrepValue = _currentRangeValues.start.round();
                maxPrepValue = _currentRangeValues.end.round();
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
