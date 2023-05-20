import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ActivityCard extends StatelessWidget {
  List cardsList = [];
  ActivityCard(List cardsInput, {Key? key}) : super(key: key) {
    cardsList = cardsInput;
  }

  /// Adds a card to the list of cards.
  void addCard(var card) {
    cardsList.add(card);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 220,
      child: ListView.builder(
          itemCount: cardsList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF80838B),
                  border: Border.all(color: const Color(0xFF80838B)),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Row(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text(
                              cardsList[index]["name"],
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          cardsList[index]["time"],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
