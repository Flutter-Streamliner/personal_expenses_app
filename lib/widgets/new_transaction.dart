import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function(String, double) addTransaction;

  NewTransaction({@required this.addTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                    ),
                    FlatButton(
                      child: Text('Add Transaction',),
                      textColor: Colors.purple,
                      onPressed: (){
                        addTransaction(titleController.text, double.parse(amountController.text));
                      },
                    ),
                  ],
                ),
              ),
            );
  }
}