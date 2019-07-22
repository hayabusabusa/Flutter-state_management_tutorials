/// Todoの完了状態に応じたフィルター
/// 
/// all: デフォルトの状態で全てのTodoを表示、
/// active: 完了にされていないTodoのみを表示、
/// completed: 完了されたTodoのみ表示
enum VisibilityFilter {
  all,
  active,
  completed
}