import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Tip Calculator',
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  dynamic amount = 0.00, tip = 0.00, person = 1, tempTip = 0.00, tempAmount = 0.0;
  double total = 0.00;

  double percent = 0;

  void amountUpdate() {
    setState(() {
      amount = double.parse((tempAmount).toStringAsFixed(2));
      total = (amount + tip) / person;
      total = double.parse((total).toStringAsFixed(2));
    });
  }

  void tipUpdate() {
    setState(() {
      tip = tempTip;
      total = (amount + tip) / person;
      total = double.parse((total).toStringAsFixed(2));
    });
  }

  void decrement()
  {
    setState(() {
      if(person > 1)
      {
        person--;
        total = (amount + tip) / person;
        total = double.parse((total).toStringAsFixed(2));
      }
    });
  }

  void increment()
  {
    setState(() {
      person++;
      total = (amount + tip) / person;
      total = double.parse((total).toStringAsFixed(2));
    });
  }

  @override
  Widget build(BuildContext context) {

    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    setState(() {
      if(person == 0) {
        total = 0.00;
      }
      total = (amount + tip) / person;
      total = double.parse((total).toStringAsFixed(2));
    });

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: keyboardOpen ? 40 : 100,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo[50],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Total Per Person',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    '\$$total',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo[50]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10, top: 10),
                        prefixText: 'Bill Amount : \$ ',
                        prefixStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                      ),
                      onChanged: (String value) {
                        try{
                          tempAmount = double.parse(value);
                        }
                        catch(exception){
                          tempAmount = 0.0;
                        }
                        amountUpdate();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 30.0, left: 15.0, bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Split',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  decrement();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Text('-',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              Text('$person',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 10)),
                              GestureDetector(
                                onTap: () {
                                  increment();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Text('+',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top : 30.0, left: 15.0, bottom: 20.0, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Tip',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.deepPurple,
                              )
                          ),
                          Text(
                            '\$$tip',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurple,
                            )
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      value: percent,
                      onChanged: (newTip) {
                        tempTip =  (newTip * amount/100);
                        percent = newTip;
                        tipUpdate();
                      },
                      min: 0,
                      max: 100,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.purple[200],
                      divisions: 5,
                      label: '${percent.round()} %',
                    )
                  ],
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
