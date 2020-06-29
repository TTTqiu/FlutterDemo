import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavouriteStar extends StatefulWidget {
  @override
  _FavouriteStarState createState() => new _FavouriteStarState();
}

class _FavouriteStarState extends State<FavouriteStar> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: new IconButton(
        icon: new Icon(
          selected ? Icons.star : Icons.star_border,
        ),
        iconSize: 32.0,
        color: Colors.white,
        onPressed: () {
          setState(() {
            selected = !selected;
          });
        },
      ),
    );
  }
}

class FavouriteStar2 extends StatelessWidget {
  FavouriteStar2(this.selected, this.onClick);

  final bool selected;
  final onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: new IconButton(
        icon: new Icon(
          selected ? Icons.star : Icons.star_border,
        ),
        iconSize: 32.0,
        color: Colors.white,
        onPressed: onClick,
      ),
    );
  }
}
