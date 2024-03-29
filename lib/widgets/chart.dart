import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {

  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>>  get groupTransactionValues {
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (int i =0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
               totalSum += recentTransactions[i].amount;
            }
      }
      return {'day': DateFormat.E().format(weekDay).substring(0, 1 ), 'amount': totalSum };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item){
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6, 
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupTransactionValues.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'], 
                  spendingAmount: data['amount'], 
                  spendingPercentageOfTotal: totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                ),
              ); 
            }) .toList(),
          ),
        ),
      );
  }

}