import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/enums/drawer_route.dart';
import 'package:harmony_app/src/enums/statistics_period.dart';
import 'package:harmony_app/src/statistics/statistics_bloc.dart';
import 'package:harmony_app/src/widgets/harmony_page.dart';
import 'package:library_pkg/library_pkg.dart';

final _getIt = GetIt.instance;

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvider<StatisticsBloc>(
      instance: StatisticsBloc.new,
      child: HarmonyPage(
        drawerRoutes: [
          DrawerRoute.home,
          DrawerRoute.progress,
          DrawerRoute.activityAssign,
          DrawerRoute.rewards,
        ],
        body: _PageBody(),
      ),
    );
  }
}

class _PageBody extends StatelessWidget {
  const _PageBody();

  @override
  Widget build(BuildContext context) {
    final bloc = _getIt.get<StatisticsBloc>();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text(
            'Statystyki',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        AsyncBuilder<StatisticsPeriod>(
          stream: bloc.statisticsPeriodStream,
          initial: StatisticsPeriod.daily,
          builder: (context, value) {
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: DropdownButton<StatisticsPeriod>(
                  icon: const Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.black,
                  ),
                  underline: const ColoredBox(color: Colors.transparent),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: value,
                  items: const [
                    DropdownMenuItem<StatisticsPeriod>(
                      value: StatisticsPeriod.daily,
                      child: Center(
                          child: Text(
                        'Dzień',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                    DropdownMenuItem<StatisticsPeriod>(
                      value: StatisticsPeriod.weekly,
                      child: Center(
                          child: Text(
                        'Tydzień',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                    DropdownMenuItem<StatisticsPeriod>(
                      value: StatisticsPeriod.monthly,
                      child: Center(
                          child: Text(
                        'Miesiąc',
                        style: TextStyle(color: Colors.black),
                      )),
                    ),
                  ],
                  onChanged: (StatisticsPeriod? value) => bloc.setStatisticsPeriodValue(value!),
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
            child: AsyncBuilder<StatisticsPeriod>(
              stream: bloc.statisticsPeriodStream,
              builder: (context, statisticsPeriod) {
                switch (statisticsPeriod) {
                  case StatisticsPeriod.daily:
                    return SvgPicture.asset('assets/svg/Group_25.svg');
                  case StatisticsPeriod.weekly:
                    return SvgPicture.asset('assets/svg/Group_27.svg');
                  case StatisticsPeriod.monthly:
                    return SvgPicture.asset('assets/svg/Group_26.svg');
                  case null:
                    return SvgPicture.asset('assets/svg/Group_25.svg');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
