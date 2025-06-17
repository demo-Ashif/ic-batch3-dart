import 'dart:io';

void main() {
  print('📞 Welcome to Contact Book! 📞');
  print('Store and manage your contacts easily.');

  // List to store contacts (name, phone)
  List<Map<String, String>> contacts = [];

  // Main program loop
  while (true) {
    showMenu();
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        addContact(contacts);
        break;
      case '2':
        showAllContacts(contacts);
        break;
      case '3':
        print('👋 Thanks for using Contact Book!');
        return;
      default:
        print('❌ Invalid choice! Please try again.');
    }
  }
}

void showMenu() {
  print('\n--- Contact Book Menu ---');
  print('1. Add Contact');
  print('2. Show All Contacts');
  print('3. Exit');
  print('Enter your choice (1-3): ');
}

void addContact(List<Map<String, String>> contacts) {
  print('\n--- Add New Contact ---');

  // Get contact name
  print('Enter contact name: ');
  String? name = stdin.readLineSync();

  if (name == null || name.trim().isEmpty) {
    print('❌ Name cannot be empty!');
    return;
  }

  // Get contact phone
  print('Enter contact phone: ');
  String? phone = stdin.readLineSync();

  if (phone == null || phone.trim().isEmpty) {
    print('❌ Phone cannot be empty!');
    return;
  }

  // Create contact map
  Map<String, String> contact = {'name': name.trim(), 'phone': phone.trim()};

  // Add to contacts list
  contacts.add(contact);
  print('✅ Contact added successfully!');
}

void showAllContacts(List<Map<String, String>> contacts) {
  print('\n--- All Contacts ---');

  if (contacts.isEmpty) {
    print('📭 No contacts found. Add some contacts first!');
    return;
  }

  // Display all contacts
  for (int i = 0; i < contacts.length; i++) {
    Map<String, String> contact = contacts[i];
    print('${i + 1}. ${contact['name']} - ${contact['phone']}');
  }

  print('\nTotal contacts: ${contacts.length}');
}
