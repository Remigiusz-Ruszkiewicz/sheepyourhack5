import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';

class ProgressListView extends StatelessWidget {
  const ProgressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return HarmonyPage(
      drawerRoutes: const [
        DrawerRoute.home,
        DrawerRoute.progress,
        DrawerRoute.activityAssign,
        DrawerRoute.statistics,
      ],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/svg/trace.svg'),
                SvgPicture.asset(
                  'assets/svg/trace.svg',
                  width: 60,
                ),
              ],
            ),
            const Text(
              '36%',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                'Postępu w realizacji celu \nna ten miesiąc',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const RankingCard(
              title: 'Bilet do kina',
              iconPath: 'assets/svg/cinema.svg',
              percentage: 0.88,
            ),
            const RankingCard(
              title: 'Bon 100 zł do serwisu Allegro',
              iconPath: 'assets/svg/allegro.svg',
              percentage: 0.55,
            ),
          ],
        ),
      ),
    );
  }
}

class RankingCard extends StatelessWidget {
  const RankingCard({
    required this.iconPath,
    required this.title,
    required this.percentage,
    super.key,
  });

  final String title;
  final String iconPath;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: const Color.fromRGBO(248, 248, 254, 1),
            child: SizedBox(
              height: 90,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: SvgPicture.asset(
                        iconPath,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: const Color.fromRGBO(117, 124, 255, 0.5),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(119, 125, 242, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
