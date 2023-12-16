import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';

class ProgressListView extends StatelessWidget {
  const ProgressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HarmonyPage(
      drawerRoutes: [
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image(
                  image: AssetImage('assets/box.png'),
                  width: 120,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Image(
                    image: AssetImage('assets/box.png'),
                    width: 60,
                  ),
                ),
              ],
            ),
            Text(
              '36%',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
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
            RankingCard(
              title: 'Bon 100 zł do sklepu Nike',
              iconPath: 'assets/svg/nike.svg',
              percentage: 0.22,
            ),
            RankingCard(
              title: 'Bon 100 zł do serwisu Allegro',
              iconPath: 'assets/svg/allegro.svg',
              percentage: 0.55,
            ),
            RankingCard(
              title: 'Bilet do kina',
              //iconPath: 'assets/svg/cinema.svg',
              percentage: 0.88,
            ),
          ],
        ),
      ),
    );
  }
}

class RankingCard extends StatelessWidget {
  const RankingCard({
    required this.title,
    required this.percentage,
    this.iconPath,
    super.key,
  });

  final String title;
  final String? iconPath;
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
                fontSize: 16,
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
              height: 200,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: iconPath != null
                          ? SvgPicture.asset(
                              iconPath!,
                              fit: BoxFit.fitWidth,
                            )
                          : const Image(
                              image: AssetImage('assets/sala.png'),
                              width: 1100,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                          child: LinearProgressIndicator(
                            value: percentage,
                            backgroundColor: const Color.fromRGBO(117, 124, 255, 0.5),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(119, 125, 242, 1)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 4),
                          child: Text(
                            '${(percentage * 100).toStringAsFixed(0)}%',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
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
