import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      home: FuelForm(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.amber,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.blueGrey
      ),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  _FuelFormState createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String result = '';
  final _currencies = ['Dollars', 'Euro', 'Pound'];
  String _currency = 'Dollars';
  final double _formDistance = 5.0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Calculator'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: distanceController,
                decoration: InputDecoration(
                    labelText: 'Distance (Mile/KM)',
                    hintText: 'e.g. 123',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: TextField(
                controller: avgController,
                decoration: InputDecoration(
                    labelText: 'Distance per Unit (Ltr/Gallon)',
                    hintText: 'e.g. 12',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _formDistance, bottom: _formDistance),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: 'e.g. 1.23',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(width: _formDistance * 5,),
                  Expanded(
                    child: DropdownButton<String>(
                        items: _currencies.map((String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        )).toList(),
                        value: _currency,
                        onChanged: (String value) => _onCurrencyChanged(value)
                    ),
                  )
                ],
              )
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Submit', textScaleFactor: 1.5,),
                    onPressed: () => _handleSubmit(),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text('Reset', textScaleFactor: 1.5,),
                    onPressed: () => _handleReset(),
                  ),
                )
              ],
            ),
            Text(result)
          ],
        ),
      ),
    );
  }

  _onCurrencyChanged(String value) {
    setState(() {
      _currency = value;
    });
  }

  _handleSubmit() {
    setState(() {
      result = _calculate();
    });
  }

  _handleReset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = _calculate();
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    String _totalCost = (_distance / _consumption * _fuelCost).toStringAsFixed(2);
    String _result = 'The total cost for your trip is: $_totalCost $_currency';
    return _result;
  }
}
