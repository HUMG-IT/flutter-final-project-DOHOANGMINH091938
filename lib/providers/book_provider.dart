
import 'package:flutter/material.dart';
import '../models/book.dart';
import 'dart:math';

class BookProvider extends ChangeNotifier {
  final List<Book> _books = [];

  List<Book> get books => _books;

  void addBook(String title, String author) {
    _books.add(Book(
      id: Random().nextInt(999999).toString(),
      title: title,
      author: author,
    ));
    notifyListeners();
  }

  void deleteBook(String id) {
    _books.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  void updateBook(String id, String title, String author) {
    final index = _books.indexWhere((b) => b.id == id);
    if (index != -1) {
      _books[index].title = title;
      _books[index].author = author;
      notifyListeners();
    }
  }

  List<Book> searchBooks(String keyword) {
    return _books
        .where((b) => b.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
  }

  List<Book> filterByAuthor(String author) {
    return _books
        .where((b) => b.author.toLowerCase().contains(author.toLowerCase()))
        .toList();
  }
}
