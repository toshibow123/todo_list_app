import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:todo_list_app/db/database.dart';

import '../main.dart';
import 'edit_screen.dart';

class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  List<Word> _wordList = List();

  @override
  void initState() {
    super.initState();
    _getAllWords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo一覧"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewWord(),
        child: Icon(Icons.add),
        tooltip: "Todoの登録",
      ),
      body: _wordListWidget(),
    );
  }

  _addNewWord() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.ADD,
                )));
  }

  void _getAllWords() async {
    _wordList = await database.allWords;
    setState(() {});
  }

  Widget _wordListWidget() {
    return ListView.builder(
        itemCount: _wordList.length,
        itemBuilder: (context, int position) => _wordItem(position));
  }

  Widget _wordItem(int position) {
    return Card(
      child: ListTile(
        title: Text("${_wordList[position].strToDo}"),
        subtitle: Text("${_wordList[position].strDateandTime}"),
        onTap: () => _editWord(_wordList[position]),
        onLongPress: () => _deleteWord(_wordList[position]),
      ),
    );
  }

  _deleteWord(Word selectedWord) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(selectedWord.strToDo),
        content: Text("削除してもいいですか？"),
        actions: <Widget>[
          FlatButton(
            child: Text("はい"),
            onPressed: () async {
              await database.deleteWord(selectedWord);
              Toast.show("削除が完了しました。", context);
              _getAllWords();
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  _editWord(Word selectedWord) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  status: EditStatus.EXIT,
                  word: selectedWord,
                )));
  }
}
