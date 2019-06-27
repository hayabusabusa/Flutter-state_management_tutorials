import 'package:flutter/material.dart';
import 'package:flutter_animations_tutorial/models/tutorial_model.dart';
import 'package:flutter_animations_tutorial/widgets/home_list_item.dart';

class Home extends StatelessWidget {
  // Tutorial
  final Tutorials _tutorials = Tutorials([
    Tutorial(title: 'Basic', description: 'BASIC\nFROM FLUTTER ANIMATION TUTORIAL', type: TutorialType.basic),
    Tutorial(title: 'Animated widget', description: 'USING ANIMATED WIDGET\nFROM FLUTTER ANIMATION TUTORIAL', type: TutorialType.animatedWidget),
    Tutorial(title: 'Simple', description: 'SIMPLE ANIMATION\nLIKE SCALE ANIMATION', type: TutorialType.simple),
    Tutorial(title: 'Dot indicator', description: 'DOT INDICATOR WITH ANIMATION', type: TutorialType.dotIndicator),
    Tutorial(title: 'Advance', description: 'ADVANCED ANIMATION EXAMPLE', type: TutorialType.advance),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        itemCount: _tutorials.list.length,
        itemBuilder: (context, index) {
          return HomeListItem(index, _tutorials.list[index]);
        },
      ),
    );
  }
}