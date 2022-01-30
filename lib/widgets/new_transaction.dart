import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final void Function(String,double,DateTime) addTX;

  NewTransaction({required this.addTX});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void submitData(){
    var enteredTitle = titleController.text;
    var enteredAmount = double.parse(amountController.text);

    if(enteredTitle.isEmpty || enteredAmount <=0 ){
      return;
    }
    widget.addTX(enteredTitle,enteredAmount,selectedDate);
    Navigator.of(context).pop();
  }

  void presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now(),
    ).then((value){
      if(value == null){
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_){
                submitData();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_){
                submitData();
              },
            ),
            Container(
              height: 70.0,
              child: Row(
                children: [
                  Expanded(
                      child: Text(selectedDate == null ? 'No Date Chosen!!' : 'PickedDate : ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  TextButton(
                      onPressed: (){
                        presentDatePicker();
                      },
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                submitData();
              },
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
