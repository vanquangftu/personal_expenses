import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Quicksand',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/guitar.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : Container(
              height: 510,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      leading: CircleAvatar(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: FittedBox(
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                        radius: 30,
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 27,
                        ),
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
