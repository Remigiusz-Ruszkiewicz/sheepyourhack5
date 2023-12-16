import 'package:flutter/material.dart';
import 'package:harmony_app/src/home_page/home_page_view.dart';
import 'package:harmony_app/src/progress_list/progress_list_view.dart';

class ActivityListView extends StatelessWidget {
  const ActivityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePageView()));
              },
            ),
            ListTile(
              title: const Text('Activity List'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ActivityListView()));
              },
            ),
            ListTile(
              title: const Text('Progress'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProgressListView()));
              },
            ),
          ],
        ),
      ),
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
              left: 20,
              top: 174,
              child: Container(
                width: 323,
                height: 43,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 85,
              top: 79,
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
                decoration: const ShapeDecoration(
                  color: Color(0x14777DF2),
                  shape: OvalBorder(),
                ),
              ),
            ),
            const Positioned(
              left: 40,
              top: 183,
              child: SizedBox(
                width: 75,
                height: 26,
                child: Text(
                  'szukaj',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 267,
              child: SizedBox(
                width: 253,
                height: 30,
                child: Text(
                  'Pójście do kina',
                  style: TextStyle(
                    color: Color(0xFF303465),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 335,
              child: SizedBox(
                width: 253,
                height: 30,
                child: Text(
                  'Pójście do kina',
                  style: TextStyle(
                    color: Color(0xFF303465),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 403,
              child: SizedBox(
                width: 253,
                height: 30,
                child: Text(
                  'Pójście do kina',
                  style: TextStyle(
                    color: Color(0xFF303465),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 471,
              child: SizedBox(
                width: 253,
                height: 30,
                child: Text(
                  'Pójście do kina',
                  style: TextStyle(
                    color: Color(0xFF303465),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 90,
              top: 539,
              child: SizedBox(
                width: 253,
                height: 30,
                child: Text(
                  'Pójście do kina',
                  style: TextStyle(
                    color: Color(0xFF303465),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 252,
              child: SizedBox(
                width: 51.20,
                height: 55.08,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 51.20,
                        height: 55.08,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF777DF2),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.24,
                      top: 18.72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0)
                            ..rotateZ(-0.27),
                          child: Container(
                            width: 26.84,
                            height: 28.52,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(
                              children: [
                                Icon(Icons.menu_book),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 320,
              child: SizedBox(
                width: 51.20,
                height: 55.08,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 51.20,
                        height: 55.08,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF777DF2),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.24,
                      top: 18.72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0)
                            ..rotateZ(-0.27),
                          child: Container(
                            width: 26.84,
                            height: 28.52,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(
                              children: [
                                Icon(Icons.check),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 388,
              child: SizedBox(
                width: 51.20,
                height: 55.08,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 51.20,
                        height: 55.08,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF777DF2),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.24,
                      top: 18.72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0)
                            ..rotateZ(-0.27),
                          child: Container(
                            width: 26.84,
                            height: 28.52,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(
                              children: [
                                Icon(Icons.menu_book),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 456,
              child: SizedBox(
                width: 51.20,
                height: 55.08,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 51.20,
                        height: 55.08,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF777DF2),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.24,
                      top: 18.72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0)
                            ..rotateZ(-0.27),
                          child: Container(
                            width: 26.84,
                            height: 28.52,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(
                              children: [
                                Icon(Icons.menu_book),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 524,
              child: SizedBox(
                width: 51.20,
                height: 55.08,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 51.20,
                        height: 55.08,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF777DF2),
                          shape: OvalBorder(),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.24,
                      top: 18.72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0)
                            ..rotateZ(-0.27),
                          child: Container(
                            width: 26.84,
                            height: 28.52,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(),
                            child: const Stack(
                              children: [
                                Icon(Icons.menu_book),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 247,
              top: 267,
              child: SizedBox(
                width: 43,
                height: 30,
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 247,
              top: 335,
              child: SizedBox(
                width: 43,
                height: 30,
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 247,
              top: 403,
              child: SizedBox(
                width: 43,
                height: 30,
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 247,
              top: 471,
              child: SizedBox(
                width: 43,
                height: 30,
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 247,
              top: 539,
              child: SizedBox(
                width: 43,
                height: 30,
                child: Text(
                  '+1',
                  style: TextStyle(
                    color: Color(0xFF0D0D0D),
                    fontSize: 20,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            Positioned(
              left: -413,
              top: 623,
              child: Container(
                width: 1179,
                height: 372,
                decoration: const ShapeDecoration(
                  color: Colors.white,
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
              left: 42,
              top: 660,
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
            const Positioned(
              left: 53,
              top: 679,
              child: SizedBox(
                width: 247,
                height: 32,
                child: Text(
                  'Dodaj do moich aktywnosci\n',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 278,
              top: 668,
              child: SizedBox(
                width: 28,
                height: 28,
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Maven Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
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
