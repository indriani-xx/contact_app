import 'package:hive_flutter/hive_flutter.dart';
import '../model/contact.dart';

class DbHelper {
  static const String boxName = 'contacts_box';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(
      ContactAdapter(),
    ); // Mendaftarkan adapter untuk model Contact
    await Hive.openBox<Contact>(
      boxName,
    ); // Membuka box untuk menyimpan data Contact
  }

  static Box<Contact> getContactBox() {
    if (!Hive.isBoxOpen(boxName)) {
      throw StateError(
        'Contact box is not open. Call DbHelper.initHive() first.',
      );
    }
    return Hive.box<Contact>(boxName);
  }

  static Future<Box<Contact>> openContactBox() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<Contact>(boxName);
    }
    return Hive.box<Contact>(boxName);
  }

  static Future<void> addContact(Contact contact) async {
    final box = await openContactBox();
    await box.add(contact);
    await box.flush();
  }

  static Future<void> editContact(int index, Contact contact) async {
    final box = await openContactBox();
    await box.putAt(index, contact);
    await box.flush();
  }

  static Future<void> deleteContact(int index) async {
    final box = await openContactBox();
    await box.delete(index);
    await box.flush();
  }
}
