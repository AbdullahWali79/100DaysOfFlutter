
// Inheritnace 2 classes k dyrman me hoti

// Superclass   Common Cheezo discuss Data Memebr Function
//Paarnet class base class
// Multipule Inheritacne
class Animal {
  String name = '';

  void eat(String string) {
    print('$string is eating');
  }
  void sleep(String string) {
    print(string + ' is sleeping');
  }
}
//Child Class derived class
// Subclass
class Cat extends Animal {
  void Mewao() {
    print('$name is Meowing');
  }
}
class Dog extends Animal{

  void bark(String s){
    print('$s is barking');
  }
}
//hello????
void main() {
  Dog d = new Dog();
  d.bark("Dog");//dog
  d.eat("Dog");// inherited funiton
  d.sleep("Dog");



}







// import 'dart:io';
// class Car{
//   //using a constructor
//   int price=0;
//   int model=0;
//   void input(){
//     print("Enter the price of car");
//     price=int.parse(stdin.readLineSync()!);
//   }
//   void display(){
//     print("The price of car is $price");
//   }// Same Name of Class and No return type
//   // featuer ye automatically call hota hai jab object create akrty hai
//   // Default constructor (no parameters)
//   Car() {
//     print("Default constructor called: Enter the price and model of the car");
//     price = int.parse(stdin.readLineSync()!);
//     model = int.parse(stdin.readLineSync()!);
//   }
//   Car.one(int p){
//     price=p;
//   }
//   Car.twoparameters(this.price, this.model);
// }
// void main() {
//   // Car simple=new Car();
//   // Car test=new Car.one(100);
//   // Car obj=new Car.twoparameters(2000,3000);
//   // Car objct2=new Car.twoparameters(1000,4000);
//   // // using a constructor
//   // //obj.input();
//   // //objct2.input();
//   // obj.display();
//   // objct2.display();
//   // simple.display();
//   // // simple.input();
// }
//
