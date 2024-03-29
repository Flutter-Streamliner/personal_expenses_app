import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;

  final Function deleteTransaction;

  TransactionList({@required this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty ?  
        Column(
          children: <Widget>[
            Text('No transactions added yet!', style: Theme.of(context).textTheme.title,),
            SizedBox(height: 20,),
            Container(
              height: 200,
              child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover,),
            ),
          ],
        )
        : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, int index){
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(child: Text('\$${transactions[index].amount}')),
                ),
              ),
              title: Text(transactions[index].title, style: Theme.of(context).textTheme.title,),
              subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
              trailing: MediaQuery.of(context).size.width > 460 
                ?  FlatButton.icon(
                    label: Text('Delete'),
                    icon: Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    onPressed: () => deleteTransaction(transactions[index].id),
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTransaction(transactions[index].id),
                  ),
            ),
          );
        },
      ),
    );
  }
}