// Tutorial type
enum TutorialType {
    simple,
    advance,
}

class Tutorial {
  String title;
  String description;
  TutorialType type;

  Tutorial({
    this.title,
    this.description,
    this.type
  });
}

class Tutorials {
  List<Tutorial> list;

  Tutorials(
    this.list
  );
}