import 'dart:io'; // For taking input from the console

void main() {
  // Create an empty map to store student information
  Map<String, String> studentInfo = {};

  // Number of entries we want to add
  int numberOfEntries = 1;

  // Loop to take input and add to the map
  for (int i = 0; i < numberOfEntries; i++) {
    print('Enter key (e.g., name, grade, subject):');
    String key = stdin.readLineSync()!; // Read key from console input

    print('Enter value for $key:');
    String value = stdin.readLineSync()!; // Read value from console input

    // Add the key-value pair to the map
    studentInfo[key] = value;
  }

  // Display the final map
  print('Student Information:');
  studentInfo.forEach((key, value) {
    print('$key: $value');
  });
}
