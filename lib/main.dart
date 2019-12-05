import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple, 
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          ), 
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans', 
              fontSize: 20,
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
    //Transaction(id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    //Transaction(id: 't2', title: 'Weekly Grociers', amount: 16.53, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTransaction = Transaction(title: title, amount: amount, date: chosenDate, id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_){
        return GestureDetector(
          child:NewTransaction(addTransaction: _addNewTransaction),
          onTap: (){},
          behavior: HitTestBehavior.opaque,
        );
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction){
      return transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList( );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add), 
          onPressed: () => _startAddNewTransaction(context),
        ), 
      ],
    );
    
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.4, 
                child: Chart(_recentTransactions),
              ),
              Container(
                height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.6, 
                child: TransactionList(transactions: _userTransactions, deleteTransaction: _deleteTransaction),
              ),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

}

