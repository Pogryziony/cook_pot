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

  final Map<String, bool> difficultyValues = {
    'Easy': false,
    'Medium': false,
    'Hard': false,
  };

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
              onPressed: () => null)
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
                Navigator.of(context).pop();
                return widget.onFiltered(
                  difficultyValues,
                  portionsValues,
                );
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
