import 'package:flutter/material.dart';
import 'package:hive_db/add_new_dialog.dart';
import 'package:hive_db/hive/boxes.dart';
import 'package:hive_db/model/notes_model.dart';
import 'package:hive_db/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive DB Notes'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          if(box.isEmpty) {
            return Center(child: Text('No Data'));

          } else {
            var list = box.values.toList().cast<NotesModel>();
            return ListView.builder(
              itemCount: box.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8,
                  color: Colors.white,
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text(list[index].title.toString(), style: TextStyle(
                                color: Colors.white, fontSize: 20)),
                            Spacer(),
                            IconButton(
                                onPressed: () async {
                                  list[index].title = 'Test';
                                  await list[index].save();
                                },
                                icon: Icon(Icons.edit, color: Colors.white)
                            ),
                            IconButton(
                                onPressed: () async {
                                  await list[index].delete();
                                },
                                icon: Icon(Icons.delete, color: Colors.white)
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${list[index].date}'),
                            Text('Weight : ${list[index].weight}'),
                            Text('Price : ₹${list[index].price}')
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Utils.showDialogAlert(context, AddNewDialog());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
