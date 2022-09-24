import 'package:flutter/material.dart';
import 'package:x_o_game/board_tile.dart';
import 'package:x_o_game/tile_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();
  var _boardState = List.filled(9, TileState.empty);
  var _currentTurn = TileState.cross;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Stack(children: [
              Image.asset('lib/images/board.png'),
              _boardTiles(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _boardTiles() {
    return Builder(
      builder: (context) {
        final boardDimension = MediaQuery.of(context).size.width;
        final tileDimension = boardDimension / 3;
        return SizedBox(
          width: boardDimension,
          height: boardDimension,
          child: Column(
              children: chunk(_boardState, 3).asMap().entries.map((entry) {
            final chunkIndex = entry.key;
            final tileStateChunk = entry.value;

            return Row(
              children: tileStateChunk.asMap().entries.map((innerEntry) {
                final innerIndex = innerEntry.key;
                final tileState = innerEntry.value;
                final tileIndex = (chunkIndex * 3) + innerIndex;

                return BoardTile(
                  dimension: tileDimension,
                  tileState: tileState,
                  onPressed: () {
                    _updateTileStateForIndex(tileIndex);
                  },
                );
              }).toList(),
            );
          }).toList()),
        );
      },
    );
  }

  void _updateTileStateForIndex(int selectedIndex) {
    if (_boardState[selectedIndex] == TileState.empty) {
      setState(() {
        _boardState[selectedIndex] = _currentTurn;
        if (_currentTurn == TileState.cross) {
          _currentTurn = TileState.circle;
        } else {
          _currentTurn = TileState.cross;
        }
      });
      final winner = _findWinner();
      if (winner != null) {
        //print('Winner is: $winner');
        _showWinnerDialog(winner);
      }
    }
  }

  TileState? _findWinner() {
    winnerForMatch(a, b, c) {
      if (_boardState[a] != TileState.empty) {
        if ((_boardState[a] == _boardState[b]) &&
            (_boardState[b] == _boardState[c])) {
          return _boardState[a];
        }
      }
      return null;
    }

    final checks = [
      winnerForMatch(0, 1, 2),
      winnerForMatch(3, 4, 5),
      winnerForMatch(6, 7, 8),
      winnerForMatch(0, 3, 6),
      winnerForMatch(1, 4, 7),
      winnerForMatch(2, 5, 8),
      winnerForMatch(0, 4, 8),
      winnerForMatch(2, 4, 6),
    ];

    TileState? winner;
    for (int i = 0; i < checks.length; i++) {
      if (checks[i] != null) {
        winner = checks[i];
        break;
      }
    }

    return winner;
  }

  void _showWinnerDialog(TileState tileState) {
    final context = navigatorKey.currentState!.overlay!.context;
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Winner'),
            content: Image.asset(tileState == TileState.cross
                ? 'lib/images/x.png'
                : 'lib/images/o.png'),
            actions: [
              TextButton(
                  onPressed: () {
                    //_resetGame();
                    Navigator.of(context).pop();
                    _resetGame();
                  },
                  child: const Text('New Game'))
            ],
          );
        });
  }

  void _resetGame() {
    setState(() {
      _boardState = List.filled(9, TileState.empty);
      _currentTurn = TileState.cross;
    });
  }
}
