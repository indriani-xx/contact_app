import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database/db_helper.dart';
import 'model/contact.dart';
import 'form_contact.dart';

class ListContact extends StatelessWidget {
  const ListContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact')),
      body: ValueListenableBuilder(
        valueListenable: DbHelper.getContactBox().listenable(),
        builder: (context, Box<Contact> box, _) {
          if (box.isEmpty) {
            return Center(child: Text('No contacts available.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final contact = box.getAt(index);
              return Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                elevation: 2,
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  leading: CircleAvatar(child: Text(contact?.name[0] ?? '')),
                  title: Text(contact?.name ?? ''),
                  subtitle: Text(contact?.phoneNumber ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => DbHelper.deleteContact(index),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: const Color.fromARGB(255, 54, 117, 244),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FormContact(contact: contact, index: index),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormContact()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
