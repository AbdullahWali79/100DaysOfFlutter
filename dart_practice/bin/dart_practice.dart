// Class representing a Person
class Person {
  String name;
  int age;

  // Constructor
  Person(this.name, this.age);

  // Method to display person info
  void displayInfo() {
    print("Name: $name, Age: $age");
  }
}
// Class with a method that returns a Person object
class PersonFactory {
  //int, String
  // Method that returns an object of type Person
  Person createPerson(String name, int age) {
    // Create a new Person object and return it
    Person obj= new Person("", 0);
    obj.age=age;
    obj.name=name;
    return obj;
    return Person(name, age);
  }
}
// user deifened data type sy banta haiobject= multi type ke values  variable ==single value, predefiend data types sy banta hai
//
void main() {
  // Create an instance of PersonFactory
  PersonFactory factory = PersonFactory();

  // Use the factory to create a new Person object
  Person person = factory.createPerson("John", 25);

  // Call method to display person info
  person.displayInfo(); // Output: Name: John, Age: 25
}
