import 'package:flutter/material.dart';
import './transaction_item.dart';
import './transaction.dart';


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
                  const SizedBox(height: 20),
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
                  return TransactionItem(
                    transaction: transactions[index],
                    deleteTx: deleteTx,
                  );
                },
              ),
            ),
    );
  }
}
