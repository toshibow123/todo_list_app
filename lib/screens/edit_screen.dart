import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:moor_ffi/database.dart';
import 'package:toast/toast.dart';
import 'package:todo_list_app/db/database.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/screens/datetime_screen.dart';
import 'package:todo_list_app/screens/word_list_screen.dart';
import 'package:intl/intl.dart';

enum EditStatus { ADD, EXIT }

class EditScreen extends StatefulWidget {
  final EditStatus status;
  final Word word;

  EditScreen({@required this.status, this.word});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController todoController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  String _titleText = "";

  bool _isTodoEnabled;

  @override
  void initState() {
    super.initState();
    if (widget.status == EditStatus.ADD) {
      _isTodoEnabled = true;
      _titleText = "Todoの追加";
      todoController.text = "";
      datetimeController.text = "";
    } else {
      _isTodoEnabled = false;
      _titleText = "登録したTodoの修正";
      todoController.text = widget.word.strToDo;
      datetimeController.text = widget.word.strDateandTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _backToWordListScreen(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_titleText),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              tooltip: "登録",
              onPressed: () => onWordRegistered(),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(
                  "課題と日時を入力してください",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              //課題入力部分
              _todoInputPart(),
              SizedBox(
                height: 50.0,
              ),
              //日時入力部分
              _dateTimePart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _todoInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          Text(
            "課題",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextField(
            decoration: InputDecoration(hintText: "やるべきことを入力しよう！"),
            enabled: _isTodoEnabled,
            controller: todoController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Widget _dateTimePart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(children: <Widget>[
        Text(
          'Todoの期限 (${format.pattern})',
          style: TextStyle(fontSize: 24.0),
        ),
        DateTimeField(
          decoration: InputDecoration(
            hintText: "課題の期日を入力しよう！",
          ),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0),
          controller: datetimeController,
          format: format,
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                locale: const Locale("ja"),
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
          },
        ),
      ]),
    );
  }

  Future<bool> _backToWordListScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WordListScreen()));
    return Future.value(false);
  }

  onWordRegistered() {
    if (widget.status == EditStatus.ADD) {
      _insertWord();
    } else {
      _updateWord();
    }
  }

  _insertWord() async {
    if (todoController.text == "" || datetimeController == "") {
      Toast.show("課題と日時の両方を入力してください。", context, duration: Toast.LENGTH_LONG);
      return;
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("登録"),
              content: Text("登録していいですか？"),
              actions: <Widget>[
                FlatButton(
                  child: Text("はい"),
                  onPressed: () async {
                    var word = Word(
                      strToDo: todoController.text,
                      strDateandTime: datetimeController.text,
                    );

                    try {
                      await database.addWord(word);
                      todoController.clear();
                      datetimeController.clear();
                    } on SqliteException catch (e) {
                      Toast.show("この課題は既に登録されているので登録できません。", context,
                          duration: Toast.LENGTH_LONG);
                      return;
                    }
                    Toast.show("登録が完了しました。", context,
                        duration: Toast.LENGTH_LONG);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                    onPressed: ()=> Navigator.pop(context),
                    child: Text("いいえ"))

              ],
            ));
  }

  void _updateWord() async {
    if (todoController.text == "" || datetimeController == "") {
      Toast.show("課題と日時の両方を入力してください。", context, duration: Toast.LENGTH_LONG);
      return;
    }

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("${todoController.text}の変更"),
              content: Text("変更してもいいですか？"),
              actions: <Widget>[
                FlatButton(
                  child: Text("はい"),
                  onPressed: () async {
                    var word = Word(
                        strToDo: todoController.text,
                        strDateandTime: datetimeController.text,
                        isMemorized: false);
                    try {
                      await database.updateWord(word);
                      Navigator.pop(context);
                      _backToWordListScreen();
                      Toast.show("修正が完了しました", context,
                          duration: Toast.LENGTH_LONG);
                    } on SqliteException catch (e) {
                      Toast.show("何らかの問題が発生して登録できませんでした： $e", context,
                          duration: Toast.LENGTH_LONG);
                      Navigator.pop(context);
                    }
                  },
                ),
                FlatButton(
                  child: Text("いいえ"),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
