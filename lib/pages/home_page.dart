
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';
import 'edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = "";
  String filterAuthor = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    List<Book> result = provider.books;

    if (search.isNotEmpty) {
      result = provider.searchBooks(search);
    }
    if (filterAuthor.isNotEmpty) {
      result = result.where((b) => b.author.toLowerCase().contains(filterAuthor.toLowerCase())).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Book Manager")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EditPage()));
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), labelText: "Tìm kiếm"),
              onChanged: (v) => setState(() => search = v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.filter_alt), labelText: "Lọc theo tác giả"),
              onChanged: (v) => setState(() => filterAuthor = v),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (_, i) {
                final book = result[i];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.author),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.deleteBook(book.id),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => EditPage(book: book)));
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
