import 'dart:io'; // For taking input from the console

void main() {
  // Create an empty map to store data
  Map<String, String> myMap = {};

  // Adding some entries to the map
  addEntry(myMap, "name", "John");
  addEntry(myMap, "age", "25");
  addEntry(myMap, "city", "New York");

  // Displaying the map
  displayMap(myMap);

  // Adding entries using user input
  print('Enter the number of entries you want to add:');
  int numberOfEntries = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < numberOfEntries; i++) {
    print('Enter key:');
    String key = stdin.readLineSync()!;

    print('Enter value:');
    String value = stdin.readLineSync()!;

    addEntry(myMap, key, value);
  }

  // Displaying the map after adding user input
  displayMap(myMap);
}

// Function to add a new entry to the map
void addEntry(Map<String, String> map, String key, String value) {
  map[key] = value;
  print('Added: $key -> $value');
}

// Function to display the map
void displayMap(Map<String, String> map) {
  print('\nMap Contents:');
  map.forEach((key, value) {
    print('$key: $value');
  });
}
