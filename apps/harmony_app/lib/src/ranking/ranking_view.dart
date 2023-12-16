import 'package:flutter/material.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

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
              left: 271,
              top: 176,
              child: Container(
                width: 124,
                height: 84,
                decoration: ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 260,
              child: Container(
                width: 360,
                height: 480,
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
              left: 21,
              top: 684,
              child: Container(
                width: 318,
                height: 66,
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 9.80,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 253,
              top: 715,
              child: Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 191,
              top: 698,
              child: SizedBox(
                width: 215,
                child: Text(
                  '420',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 29,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 704,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Rafał P.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 21,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -59,
              top: 701,
              child: SizedBox(
                width: 215,
                child: Text(
                  '5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 27,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 21,
              top: 586,
              child: Container(
                width: 318,
                height: 66,
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 9.80,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 253,
              top: 620,
              child: Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 191,
              top: 601,
              child: SizedBox(
                width: 215,
                child: Text(
                  '457',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 29,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 604,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Konrad H.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 21,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -59,
              top: 603,
              child: SizedBox(
                width: 215,
                child: Text(
                  '4',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 27,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 21,
              top: 488,
              child: Container(
                width: 318,
                height: 66,
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 9.80,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 253,
              top: 496,
              child: Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 191,
              top: 504,
              child: SizedBox(
                width: 215,
                child: Text(
                  '473',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 29,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 62,
              top: 511,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Zofia L.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 21,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -59,
              top: 505,
              child: SizedBox(
                width: 215,
                child: Text(
                  '3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 27,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 21,
              top: 390,
              child: Container(
                width: 318,
                height: 66,
                decoration: ShapeDecoration(
                  color: Color(0xFFF8F8FE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 9.80,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 191,
              top: 406,
              child: SizedBox(
                width: 215,
                child: Text(
                  '501',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 29,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 66,
              top: 413,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Marcin Z.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 21,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -59,
              top: 407,
              child: SizedBox(
                width: 215,
                child: Text(
                  '2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777DF2),
                    fontSize: 27,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
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
              left: 77,
              top: 52,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Ranking',
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
              left: 76,
              top: 208,
              child: SizedBox(
                width: 215,
                child: Text(
                  'NO.14',
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
              left: -158,
              top: -100,
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
              left: 139,
              top: 110,
              child: Container(
                width: 91.06,
                height: 85,
                child: Stack(
                  children: [
                    Positioned(
                      left: 30.80,
                      top: 0,
                      child: Container(
                        width: 29.45,
                        height: 76.35,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 15.92,
                      top: 37.64,
                      child: Container(
                        width: 59.20,
                        height: 17.30,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: -15,
              top: 292,
              child: Container(
                width: 397,
                height: 66,
                decoration: ShapeDecoration(
                  color: Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x26424242),
                      blurRadius: 9.80,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    ),BoxShadow(
                      color: Color(0x26424242),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),BoxShadow(
                      color: Color(0x26414141),
                      blurRadius: 7.90,
                      offset: Offset(3, -6),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 164,
              top: 305,
              child: SizedBox(
                width: 215,
                child: Text(
                  '525',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 29,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 59,
              top: 313,
              child: SizedBox(
                width: 215,
                child: Text(
                  'Karolina K.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 21,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -77,
              top: 309,
              child: SizedBox(
                width: 215,
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 27,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 54,
              top: 303,
              child: Container(
                width: 44.79,
                height: 44.06,
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 306,
              top: 303.36,
              child: Container(
                width: 37,
                height: 38.39,
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 66,
              top: 392,
              child: Container(
                width: 52,
                height: 52,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 7.14,
                      top: 12.77,
                      child: Container(
                        width: 41.80,
                        height: 28.07,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 70,
              top: 499,
              child: Container(
                width: 44,
                height: 44,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 69,
              top: 596,
              child: Container(
                width: 45,
                height: 45,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 71,
              top: 697,
              child: Container(
                width: 42,
                height: 42,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(children: [
      
                    ]),
              ),
            ),
            Positioned(
              left: 253,
              top: 403,
              child: Container(
                width: 24,
                height: 24,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        child: Stack(children: [
      
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
