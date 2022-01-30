import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/new_transaction.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import 'package:personal_expenses/models/transactions.dart';
import 'package:personal_expenses/widgets/chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      debugShowCheckedModeBanner: false,
      title: 'Person Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> userTransactions = [
    //Transactions(
      //id: 't1',
      //title: 'New Shoes',
      //amount: 89.99,
      //date: DateTime.now(),
    //),
    //Transactions(
      //id: 't2',
      //title: 'New Shirt',
      //amount: 99.99,
      //date: DateTime.now(),
    //),
  ];

  List<Transactions> get recentTransactions{
    return userTransactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String txTitle, double txAmount, DateTime changedDate) {
    final newTX = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: changedDate);
    setState(() {
      userTransactions.add(newTX);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: (){},
              child: NewTransaction(addTX: addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTransaction(String id){
    setState(() {
      userTransactions.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Person Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Chart(recentTransactions : recentTransactions),
            TransactionList(transactions: userTransactions,deleteTransaction: deleteTransaction,),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
