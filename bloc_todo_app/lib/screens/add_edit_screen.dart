import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:bloc_todo_app/models/models.dart';

// typealyas
typedef OnSaveCallBack = Function(String task, String note);

/// Add Edit Screen (Screen)
/// 
/// 新しくTodoを作成、または既存のTodoを編集することができる。
/// 
/// isEditingフラグによって編集なのか新規作成なのかをコントロールするため、
/// StatefullWidgetで作成。
class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Todo todo;
  final OnSaveCallBack onSave;

  AddEditScreen({
    Key key,
    @required this.isEditing,
    @required this.todo,
    @required this.onSave
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);

  @override
  State<StatefulWidget> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  // ?
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  // StateとひもづくWidgetのプロパティへアクセス
  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // App Bar
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editTodo : localizations.addTodo,
        ),
      ),
      // Body
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          // ???
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Task名入力
              TextFormField(
                initialValue: isEditing ? widget.todo.task : '',
                key: ArchSampleKeys.taskField,
                autofocus: !isEditing, // ??
                style: textTheme.headline,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint
                ),
                validator: (val) { // ??
                  return val.trim().isEmpty
                    ? localizations.emptyTodoError
                    : null;
                },
                onSaved: (value) => _task = value,
              ),

              // Taskメモ入力
              TextFormField(
                initialValue: isEditing ? widget.todo.note : '',
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.subhead,
                decoration: InputDecoration(
                  hintText: localizations.notesHint
                ),
                onSaved: (value) => _note = value,
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        key: isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          // ??
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onSave(_task, _note);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}