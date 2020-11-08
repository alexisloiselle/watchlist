import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/state/contents_state.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: 192,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "Movies",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Consumer<ContentsState>(
                builder: (context, state, child) => Column(
                  children: state.movies
                      .map(
                        (e) => Text(e.title),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
