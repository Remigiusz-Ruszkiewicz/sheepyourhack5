import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    return HarmonyPage(
      drawerRoutes: const [
        DrawerRoute.home,
        DrawerRoute.progress,
        DrawerRoute.activityAssign,
        DrawerRoute.statistics,
      ],
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Ranking',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          SvgPicture.asset('assets/svg/Group_12.svg'),
          const Text(
            '255 pkt.',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          const Text(
            'NO.14',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ColoredBox(
              color: const Color.fromRGBO(119, 125, 242, 1),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SvgPicture.asset('assets/svg/Group_13.svg'),
                  const Spacer(),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Text('Karolina K.')),
                  const Spacer(),
                  const Text(
                    '525',
                    style: TextStyle(fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SvgPicture.asset('assets/svg/Group_14.svg'),
                  ),
                ],
              ),
            ),
          ),
          const RankingCard(
            position: 2,
            iconPath: 'assets/svg/Group_15.svg',
            name: 'Marcin Z.',
            points: 501,
          ),
          const RankingCard(
            position: 3,
            iconPath: 'assets/svg/Group_16.svg',
            name: 'Zofia L.',
            points: 473,
          ),
          const RankingCard(
            position: 4,
            iconPath: 'assets/svg/Group_17.svg',
            name: 'Konrad H.',
            points: 457,
            isGoingDown: true,
          ),
          const RankingCard(
            position: 5,
            iconPath: 'assets/svg/Group_18.svg',
            name: 'Rafał P.',
            points: 420,
            isGoingDown: true,
          ),
        ],
      ),
    );
  }
}

class RankingCard extends StatelessWidget {
  const RankingCard({
    required this.position,
    required this.iconPath,
    required this.name,
    required this.points,
    this.isGoingDown = false,
    super.key,
  });

  final int position;
  final String iconPath;
  final String name;
  final int points;
  final bool isGoingDown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color.fromRGBO(248, 248, 254, 1),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  '$position',
                  style: const TextStyle(fontSize: 20, color: Color.fromRGBO(119, 125, 242, 1)),
                ),
              ),
              SvgPicture.asset(iconPath),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 15, color: Color.fromRGBO(119, 125, 242, 1)),
                ),
              ),
              const Spacer(),
              if (isGoingDown)
                const Icon(
                  Icons.arrow_downward_outlined,
                  color: Colors.red,
                )
              else
                const Icon(
                  Icons.arrow_upward_outlined,
                  color: Colors.green,
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '$points',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(119, 125, 242, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
