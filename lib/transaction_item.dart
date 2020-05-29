import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './transaction.dart';


class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
        leading: CircleAvatar(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          radius: 30,
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: Theme.of(context).textTheme.subtitle,
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 27,
          ),
          onPressed: () => deleteTx(transaction.id),
        ),
      ),
    );
  }
}