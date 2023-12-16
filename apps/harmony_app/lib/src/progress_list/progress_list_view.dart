import 'package:flutter/material.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';

class ProgressListView extends StatelessWidget {
  const ProgressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return HarmonyPage(
      drawerRoutes: const [
        DrawerRoute.statistics,
        DrawerRoute.activityAssign,
        DrawerRoute.progress,
        DrawerRoute.home,
      ],
      body: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFE9E9F2)),
        child: Stack(
          children: [
            Positioned(
              left: -74,
              top: 298,
              child: Container(
                width: 160,
                height: 115,
                decoration: const ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 307,
              top: 22,
              child: SizedBox(
                width: 36,
                height: 22,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF353A70),
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
                            color: const Color(0xFF353A70),
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
                            color: const Color(0xFF353A70),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -129,
              top: -50,
              child: Container(
                width: 429,
                height: 289,
                decoration: const ShapeDecoration(
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
                decoration: const ShapeDecoration(
                  color: Color(0x16777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 193,
              top: 322,
              child: Container(
                width: 311,
                height: 230,
                decoration: const ShapeDecoration(
                  color: Color(0x14777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 38.64,
              top: 738.72,
              child: Opacity(
                opacity: 0.22,
                child: Transform(
                  transform: Matrix4.identity()
                    ..translate(0.0)
                    ..rotateZ(-0.24),
                  child: Container(
                    width: 30.25,
                    height: 28.70,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 253,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0x7F777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 545,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0x7F777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 353,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0x7FE473DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 643,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0x7FE473DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 455,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0x7FFFCA63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 644,
              child: Container(
                width: 325,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE473DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 455,
              child: Container(
                width: 218,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFCA63),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 17,
              top: 253,
              child: Container(
                width: 270,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 546,
              child: Container(
                width: 327,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0xFF777DF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 286,
              top: 257,
              child: SizedBox(
                width: 68,
                height: 40,
                child: Text(
                  '88%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 281,
              top: 357,
              child: SizedBox(
                width: 68,
                height: 40,
                child: Text(
                  '45%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 280,
              top: 460,
              child: SizedBox(
                width: 68,
                height: 40,
                child: Text(
                  '55%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 139,
              top: 112,
              child: SizedBox(
                width: 100,
                height: 43,
                child: Text(
                  '36%',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 86,
              top: 151,
              child: SizedBox(
                width: 189,
                height: 35,
                child: Text(
                  'Postępu w realizacji celu na ten tydzień',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 16,
              top: 235,
              child: SizedBox(
                width: 189,
                height: 18,
                child: Text(
                  'Bilet do kina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 15,
              top: 335,
              child: SizedBox(
                width: 189,
                height: 18,
                child: Text(
                  'Bilet do kina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 16,
              top: 626,
              child: SizedBox(
                width: 189,
                height: 18,
                child: Text(
                  'Bilet do kina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 14,
              top: 436,
              child: SizedBox(
                width: 189,
                height: 18,
                child: Text(
                  'Bilet do kina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 13,
              top: 527,
              child: SizedBox(
                width: 189,
                height: 18,
                child: Text(
                  'Bilet do kina',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 123,
              top: 557,
              child: SizedBox(
                width: 111,
                height: 27,
                child: Text(
                  'odbierz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 121,
              top: 654,
              child: SizedBox(
                width: 111,
                height: 27,
                child: Text(
                  'odbierz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 353,
              child: Container(
                width: 161,
                height: 49,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE473DA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
