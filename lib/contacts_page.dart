import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String number;
  final String description;
  final String imageUrl;

  Contact({required this.name, required this.number, required this.description, required this.imageUrl});
}

class ContactsPage extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor1.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor2.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor3.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor4.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor5.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/counselor/counsellor6.png'),
    
    // Add more contacts here
  ];

  ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(contact: contacts[index]);
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(contact.imageUrl),
        ),
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(contact.number),
            Text(contact.description),
          ],
        ),
      ),
    );
  }
}
