import 'package:flutter/material.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 360,
        height: 740,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Color(0xFFE9E9F2),
          shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: -74,
              top: 298,
              child: Container(
                width: 160,
                height: 115,
                decoration: ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 307,
              top: 22,
              child: Container(
                width: 36,
                height: 22,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: ShapeDecoration(
                          color: Color(0xFF353A70),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 9,
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: ShapeDecoration(
                          color: Color(0xFF353A70),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 18,
                      child: Container(
                        width: 36,
                        height: 4,
                        decoration: ShapeDecoration(
                          color: Color(0xFF353A70),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: -129,
              top: -50,
              child: Container(
                width: 429,
                height: 289,
                decoration: ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 234,
              top: 144,
              child: Container(
                width: 91,
                height: 65,
                decoration: ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 159,
              child: Container(
                width: 323,
                height: 96,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 150,
              top: 180,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Dzień',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 125,
              child: Container(
                width: 323,
                height: 43,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 147,
              top: 134,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Tydzień',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 300,
              top: 131,
              child: Container(
                width: 28,
                height: 28,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 77,
              top: 52,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Statystyki',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 22,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 99,
              top: 866,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Wybierz aktywność z listy ',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 22,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 193,
              top: 322,
              child: Container(
                width: 311,
                height: 230,
                decoration: ShapeDecoration(
                  color: Color(0x14777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 147,
              top: 219,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Miesiąc',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 38.64,
              top: 738.72,
              child: Opacity(
                opacity: 0.22,
                child: Transform(
                  transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.24),
                  child: Container(
                    width: 30.25,
                    height: 28.70,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 304,
              child: Container(
                width: 360,
                height: 436,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 69,
              top: 646,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Relaks',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 69,
              top: 620,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Praca',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 41,
              top: 653,
              child: Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 147,
              top: 134,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'Tydzień',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 22,
              top: 322,
              child: Container(
                width: 315,
                height: 275,
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 293,
              top: 500,
              child: Container(
                width: 13,
                height: 32,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 293,
              top: 413,
              child: Container(
                width: 13,
                height: 55,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 239,
              top: 489,
              child: Container(
                width: 13,
                height: 22,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 239,
              top: 424,
              child: Container(
                width: 13,
                height: 43,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 175,
              top: 511,
              child: Container(
                width: 13,
                height: 43,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 175,
              top: 386,
              child: Container(
                width: 13,
                height: 82,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 114,
              top: 500,
              child: Container(
                width: 13,
                height: 32,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 44,
              top: 551,
              child: SizedBox(
                width: 283,
                height: 26,
                child: Text(
                  'Pon       Wtr        Śr          Czw       Pt  ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 100,
              top: 330,
              child: SizedBox(
                width: 170,
                height: 40,
                child: Text(
                  '12.06 - 19.06. 2023',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 71,
              top: 659,
              child: Container(
                width: 417,
                height: 228,
                decoration: ShapeDecoration(
                  color: Color(0x0C777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 539,
              child: Container(
                width: 13,
                height: 71,
                decoration: ShapeDecoration(
                  color: Color(0xFF2F3273),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 397,
              child: Container(
                width: 13,
                height: 71,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 114,
              top: 413,
              child: Container(
                width: 13,
                height: 55,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 41,
              top: 626,
              child: Container(
                width: 14,
                height: 14,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
