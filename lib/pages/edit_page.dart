
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';

class EditPage extends StatefulWidget {
  final Book? book;
  const EditPage({super.key, this.book});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final titleCtrl = TextEditingController();
  final authorCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      titleCtrl.text = widget.book!.title;
      authorCtrl.text = widget.book!.author;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? "Thêm sách" : "Sửa sách"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: "Tên sách")),
            const SizedBox(height: 12),
            TextField(controller: authorCtrl, decoration: InputDecoration(labelText: "Tác giả")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.book == null) {
                  provider.addBook(titleCtrl.text, authorCtrl.text);
                } else {
                  provider.updateBook(widget.book!.id, titleCtrl.text, authorCtrl.text);
                }
                Navigator.pop(context);
              },
              child: Text("Lưu"),
            )
          ],
        ),
      ),
    );
  }
}
