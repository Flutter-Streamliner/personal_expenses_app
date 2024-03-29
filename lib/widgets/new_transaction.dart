import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {

  final Function(String, double, DateTime) addTransaction;

  NewTransaction({@required this.addTransaction});

  @override
  State<StatefulWidget> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  

  void _submitData() { 
    if (_amountController.text.isEmpty) return; 
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) return;
    widget.addTransaction(enteredTitle, enteredAmount, _selectedDate );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now())
      .then((pickedDate){
         if (pickedDate == null) return;
         setState(() {
           _selectedDate = pickedDate;
         });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            labelText: 'Amount',
                          ),
                          keyboardType:  TextInputType.number,
                          onSubmitted: (_) => _submitData ,
                        ),
                        Container(
                          height: 70,
                          child: Row(
                            children: <Widget>[
                              Expanded (
                                child: Text(_selectedDate == null ? 
                                  'No Date Chosen!' 
                                  : 'Picked Date ${DateFormat.yMd().format( _selectedDate)}'),
                              ),
                              AdaptiveFlatButton(text: 'Choose Date', handler: _presentDatePicker,),
                            ],
                          ),
                        ),
                        RaisedButton(
                          child: Text('Add Transaction',),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).textTheme.button.color,
                          onPressed: _submitData,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}