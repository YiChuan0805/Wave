import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String number;
  final String description;
  final String imageUrl;

  Contact({
    required this.name,
    required this.number,
    required this.description,
    required this.imageUrl,
  });
}

class ContactsPage extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: 'Dr. Zainudin Omar', number: '04-9284060', description: 'Pengarah Pusat Kaunseling', imageUrl: 'assets/counselor/Dr.ZainudinOmar.png'),
    Contact(name: 'Mdm. Faezah Nayan', number: '019-4288666', description: 'Pengawai Psikologi Kanan', imageUrl: 'assets/counselor/Dr.FaezahNayan.png'),
    Contact(name: 'Mr. Shahrin Ahmad', number: '010-4581706', description: 'Pengawai Psikologi Kanan', imageUrl: 'assets/counselor/Dr.ShahrinAhmad.png'),
    Contact(name: 'Mdm. Noorul Adilah Che Hamzah', number: '017-5415194', description: 'Pengawai Psikologi Kanan', imageUrl: 'assets/counselor/Dr.NoorulAdilah.png'),
    Contact(name: 'Mr. Mohd. Khairone MD Khatidin', number: '013-3923277', description: 'Pengawai Psikologi Kanan', imageUrl: 'assets/counselor/Dr.MohdKhairone.png'),
    
    // Add more contacts here
  ];

  ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(95, 37, 37, 37), // Set app bar background color to black
        title: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.white, // Set title color to white
            fontSize: 30, // Set font size to 30
            fontWeight: FontWeight.bold, // Set font weight to bold
            fontFamily: 'Inter', // Set font family to Inter
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Change back button color to white
        bottom: PreferredSize(
          child: Container(
            color: Colors.white, // Add white line under the app bar
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: Container(
        color: Color.fromARGB(95, 37, 37, 37), // Set background color of the body
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Reach out to our counsellors for support.',
                style: TextStyle(
                  color: Colors.white, // Set text color to white
                  fontSize: 18, // Set font size
                  fontWeight: FontWeight.bold, // Set font weight to bold
                  fontFamily: 'Inter', // Set font family to Inter
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(contact: contacts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add shadow effect
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Add margin
      child: ListTile(
        contentPadding: EdgeInsets.all(16), // Add padding
        leading: CircleAvatar(
          radius: 45, // Increase size of avatar
          child: ClipOval(
            child: Image.asset(
              contact.imageUrl,
              width: 100, // Adjust width
              height: 100, // Adjust height
              fit: BoxFit.cover, // Ensure image covers the circle
            ),
          ),
        ),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            Text(
              'Phone: ${contact.number}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Position: ${contact.description}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
