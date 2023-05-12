import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      padding: const EdgeInsets.all(4),
                      height: 45,
                      width: 120,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF4C300),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text(
                          'yooo',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  // build(context);
}
