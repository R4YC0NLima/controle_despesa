import 'package:flutter/material.dart';
import 'package:despesa_pessoal/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                SizedBox(height: constraint.maxHeight * 0.05),
                Text(
                  'Nenhuma Transação foi cadastrada!',
                  style: theme.textTheme.headline6,
                ),
                SizedBox(
                  height: constraint.maxHeight * 0.05,
                ),
                Container(
                  height: constraint.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/empty.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(tr.title, style: theme.textTheme.headline6),
                  subtitle: Text(
                    DateFormat("d 'de' MMM 'de' y").format(tr.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: mediaQuery.size.width > 480
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Excluir'),
                          textColor: theme.errorColor,
                          onPressed: () => onRemove(tr.id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: theme.errorColor,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin:
              //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: theme.primaryColor,
              //             width: 2,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           'R\$ ${tr.value.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Colors.purple,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             tr.title,
              //             style: theme.textTheme.headline6,
              //             // style: TextStyle(fontSize: 16),
              //             textAlign: TextAlign.start,
              //           ),
              //           Text(
              //             DateFormat("d 'de' MMM 'de' y").format(tr.date),
              //             style: TextStyle(color: Colors.grey),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // );
            },
          );
  }
}
