import 'dart:collection';

class Stack<T> {
  final stack = Queue<T>();

  T get top => stack.first;

  T get pop => stack.removeFirst();

  void push(T element) => stack.addFirst(element);

  bool isEmpty() => stack.isEmpty;

  bool contains(T element) => stack.contains(element);

  int get size => stack.length;

}
