import 'package:flutter/material.dart';
import 'package:flutter_animations_tutorial/models/tutorial_model.dart';

class HomeListItem extends StatelessWidget {
  int _index;
  Tutorial _tutorial;

  HomeListItem(
    this._index,
    this._tutorial,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Space
        SizedBox(height: _index == 0 ? 40.0 : 20.0,),

        // Header
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            _tutorial.description,
            style: TextStyle(
              color: Colors.grey[700]
            ),
          ),
        ),

        // Cell
        Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              // Navigation
              switch (_tutorial.type) {
                case TutorialType.simple:
                  print('Did you tapped Simple ?');
                  break;
                case TutorialType.dotIndicator:
                  print('Did you tapped Dot indicator ?');
                  break;
                case TutorialType.advance:
                  print('Did you tapped Advance ?');
                  break;
                default:
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Divider(height: 1.0, color: Colors.grey[350],),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _tutorial.title,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[400],
                        size: 16.0,
                      ),
                    ],
                  )
                ),

                Divider(height: 1.0, color: Colors.grey[350],),
              ],
            ),
          ),
        ),
      ],
    );
  }
}