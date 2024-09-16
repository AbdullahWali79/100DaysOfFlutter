import 'dart:io';

class Task1{
  late int id;
  void input(){
    print("Enter id");
    id = int.parse(stdin.readLineSync()!);
  }
  void display(){
    print("id = $id");
  }
}
class Task2 extends Task1{
 @override// decorator
  void input(){
   super.input();
   print("I can add further detail in this fucntion");

  }
}
void main(){
  Task2 t = new Task2();
  t.input();
  t.display();
}