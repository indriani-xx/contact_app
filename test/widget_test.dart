import 'package:contact_app/form_contact.dart';
import 'package:contact_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('edit form pre-fills existing contact data', (tester) async {
    final contact = Contact(name: 'Alice', phoneNumber: '08123456789');

    await tester.pumpWidget(
      MaterialApp(home: FormContact(contact: contact, index: 0)),
    );

    expect(find.text('Edit Contact'), findsOneWidget);
    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('08123456789'), findsOneWidget);
  });
}
