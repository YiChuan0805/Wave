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
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'moon.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'sun.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'yy.png'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S0.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S1.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S2.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S3.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S4.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S5.jpg'),
    Contact(name: 'Yeet', number: '1234567890', description: 'Friend', imageUrl: 'S6.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S7.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'S8.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg'),
    Contact(name: 'John Doe', number: '1234567890', description: 'Friend', imageUrl: 'assets/images/john_doe.jpg')
    
    // Add more contacts here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
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

  ContactCard({required this.contact});

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
            Text('${contact.number}'),
            Text('${contact.description}'),
          ],
        ),
      ),
    );
  }
}
