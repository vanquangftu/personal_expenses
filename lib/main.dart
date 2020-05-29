import 'package:flutter/material.dart';
import './chart.dart';
import './transaction_list.dart';
import './transaction.dart';
import './new_transaction.dart';

void main() => runApp(
      MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Panton',
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w100,
                ),
                subtitle: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  color: Colors.black,
                ),
                caption: TextStyle(
                  fontFamily: 'Quicksand',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'Panton',
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    letterSpacing: 1.3,
                  ),
                ),
          ),
        ),
        home: MyHomePage(),
      ),
    );

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   title: 'Shoe',
    //   amount: 23124.25,
    //   date: DateTime(2020, 05, 15),
    //   id: '1234',
    // ),
    // Transaction(
    //   title: 'Clothes',
    //   amount: 50.56,
    //   date: DateTime(2020, 05, 15),
    //   id: '2345',
    // ),
    // Transaction(
    //   title: 'Games',
    //   amount: 7.99,
    //   date: DateTime(2020, 05, 16),
    //   id: '3456',
    // ),
    // Transaction(
    //   title: 'Drink',
    //   amount: 7.99,
    //   date: DateTime(2020, 05, 17),
    //   id: '4567',
    // ),
    // Transaction(
    //   title: 'Gasoline',
    //   amount: 3.99,
    //   date: DateTime(2020, 05, 17),
    //   id: '5678',
    // ),
    // Transaction(
    //   title: 'Food',
    //   amount: 5.39,
    //   date: DateTime(2020, 05, 18),
    //   id: '6789',
    // ),
    // Transaction(
    //   title: 'Bag',
    //   amount: 3.00,
    //   date: DateTime(2020, 05, 14),
    //   id: '7891',
    // ),
    // Transaction(
    //   title: 'Tickets',
    //   amount: 2.49,
    //   date: DateTime.now(),
    //   id: '2145',
    // ),
  ];

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      amount: txAmount,
      title: txTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(
      () {
        _transactions.add(newTx);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(
      () {
        _transactions.removeWhere(
          (tx) {
            return tx.id == id;
          },
        );
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _startAddNewTx(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  List<Widget> _buiderLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txList,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Show/Hide Chart'),
          Switch(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txList
    ];
  }

  List<Widget> _buiderPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txList,
  ) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(_recentTransactions),
      ),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      leading: const Icon(Icons.menu),
      title: Text(
        'Personal Expenses',
        style: Theme.of(context).appBarTheme.textTheme.title,
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTx(context),
        )
      ],
    );
    final txList = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.65,
      child: TransactionList(_transactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            ..._buiderLandscapeContent(
              mediaQuery,
              appBar,
              txList,
            ),
          if (!isLandscape)
            ..._buiderPortraitContent(
              mediaQuery,
              appBar,
              txList,
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTx(context),
      ),
    );
  }
}
