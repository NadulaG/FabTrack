import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  final ActivityCardState cardState = ActivityCardState();

  ActivityCard({
    super.key,
  });

  @override
  State<ActivityCard> createState() => ActivityCardState();
}

class ActivityCardState extends State<ActivityCard> {
  int _cardLength = 0;

  ActivityCardState() {}

  stateAddCard() {
    _cardLength += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 220,
      child: ListView.builder(
          itemCount: _cardLength, // cardList.length,
          itemBuilder: (BuildContext context, int index) {
            // Build the widget of the CardState[index] and return it

            return Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF80838B),
                  border: Border.all(color: const Color(0xFF80838B)),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  height: 45,
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF4C300),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                      
                ),
              ),
            );
          }),
    );
  }

  // build(context);
}
