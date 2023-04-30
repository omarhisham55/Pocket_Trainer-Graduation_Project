import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'ExistExercise.dart';

openDialogFilterise(context) => showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(builder: (context, StateSetter setState){
      return Dialog(
        backgroundColor: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                const Text(
                  """Filterise your equipement""",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            MultiSelectContainer(
                showInListView: true,
                itemsPadding: const EdgeInsetsDirectional.all(10),
                itemsDecoration: MultiSelectDecorations(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
                items: [
                  MultiSelectCard(value: 'Barbells', label: 'Barbells'),
                  MultiSelectCard(value: 'Dumbbells', label: 'Dumbbells'),
                  MultiSelectCard(value: 'Cables', label: 'Cables'),
                  MultiSelectCard(value: 'Machines', label: 'Machines'),
                  MultiSelectCard(value: 'BodyWeight', label: 'BodyWeight'),
                ], onChange: (allSelectedItems, selectedItem) {}

            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    })
);