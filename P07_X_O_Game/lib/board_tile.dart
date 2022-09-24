import 'package:flutter/material.dart';
import 'package:x_o_game/tile_state.dart';

class BoardTile extends StatelessWidget {
  final TileState tileState;
  final double dimension;
  final VoidCallback onPressed;
  const BoardTile(
      {Key? key,
      required this.dimension,
      required this.onPressed,
      required this.tileState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: dimension,
      height: dimension,
      child: ElevatedButton(
        onPressed: onPressed,
        child: _tileStateWidget(),
      ),
    );
  }

  Widget _tileStateWidget() {
    Widget widget;

    switch (tileState) {
      case TileState.empty:
        {
          widget = Container(
            color: Colors.white,
          );
        }
        break;
      case TileState.cross:
        {
          widget = Image.asset('lib/images/x.png');
        }
        break;
      case TileState.circle:
        {
          widget = Image.asset('lib/images/o.png');
        }
        break;
    }
    return widget;
  }
}
