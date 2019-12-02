import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {

  final Function(String, double) addTransaction;

  NewTransaction({@required this.addTransaction});

  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  

  void _submitData() { 
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) return;
    widget.addTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop();
  }

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
                      keyboardType:  TextInputType.number,
                      onSubmitted: (_) => _submitData ,
                    ),
                    FlatButton(
                      child: Text('Add Transaction',),
                      textColor: Colors.purple,
                      onPressed: _submitData,
                    ),
                  ],
                ),
              ),
            );
  }
}