import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'Why is this so empty?!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      height: 300,
                      child: Image.asset(
                        'assets/images/waiting.png',
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical:8, horizontal: 5),
                    child: ListTile(
                      //leading: Container(height: 60, width: 60,(decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle)) or
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding : const EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('₹${transactions[index].amount}'))),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)
                          ),
                      trailing: IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, onPressed: () => deleteTx(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
