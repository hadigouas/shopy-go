import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_app/widgets/buyingcard.dart';
import 'package:ecommerce_app/widgets/empty_card.dart';
import 'package:flutter/material.dart';

class latestview extends StatelessWidget {
  const latestview({super.key});
  final bool _empty = false;
  @override
  Widget build(BuildContext context) {
    return _empty
        ? const emptycard(
            pic: 'images/card/bag_wish.png',
            title: 'the card is empty',
            text: 'please buy something to make me happy',
          )
        : Scaffold(
            body: DynamicHeightGridView(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              itemCount: 2,
              builder: (context, index) {
                return const buyingcard();
              },
            ),
          );
  }
}
