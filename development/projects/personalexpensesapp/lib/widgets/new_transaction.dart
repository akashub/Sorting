// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //we changed NewTransaction from Stateless to Stateful because when we introduced modalscrollwindow it was not remembering title when we were switching to amount. This is because flutter reevaluates it's widgets time to time and data of the Stateless widget is reset when this changed. State class is detached from this, data is not lost.
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle,
        enteredAmount, _selectedDate); // 'widget.' is used to access properties/methods from the widget class in our state class. We can use addTx that is in a different class in state claass.

    Navigator.of(context)
        .pop(); //context is a property that is automatically made available when we call State and gives you context to the widget.
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2003),
        lastDate: DateTime.now(),
        builder: ((context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                primary: Colors.purple,
                onPrimary: Colors.white, //colour of big date and day
                onSurface: Colors.purple, //colour of text in white part
              )),
              child: child!);
        })).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) =>
                  _submitData(), //onSubmitted requires us to accept a value anonymous func with (_) is a convention that we use to specify that the we don't care about whatever value the user puts in. If we didn't do this then we would have had to add 'String val' in 'void _submitData()' and would have had to put in values in onSubmitted and onPressed.
              //onChanged: (val) => titleInput = val,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              //onChanged: (val) => amountInput = val
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMd().format(_selectedDate!),
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              onPressed:
                  _submitData, // because of (_) we didn't had to write something like 'onPressed: () => _submitData('DUMMYYY'),'
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button!.color,
            ),
          ],
        ),
      ),
    );
  }
}
