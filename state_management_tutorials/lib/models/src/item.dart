
const _itemNames = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'Callback',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class Item {
  final int id;
  final String name;

  // ここの記述について( https://dev.classmethod.jp/client-side/about_dart_constructors/ )
  //
  // Class(this.member) : ... Automatic field initialization 
  // Class(this.member) : member2 ... Initializer Lists
  // 
  // new で初期化 => 引数に id を指定 => id を使って name を _itemNames配列 から読み込んで初期化
  // var item = new Item(0); ... name は 'Code Smell'

  Item(this.id) : name = _itemNames[id % _itemNames.length];

  // hashCode プロパティの getter をオーバーライド
  // このオブジェクトの hashCode を返して id に代入
  @override
  int get hashCode => id;

  @override
  bool operator == (other) => other is Item && other.id == id;
}