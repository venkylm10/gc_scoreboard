import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/src/globals/enums.dart';
import '../../globals/colors.dart';
import '../../stores/common_store.dart';
import '../../widgets/common/bottom_navigation_bar.dart';
import '../../widgets/common/coming_soon.dart';
import '../../widgets/common/home_app_bar.dart';
import '../../widgets/common/restricted_page.dart';
import '../../widgets/schedule_page/add_button.dart';
import '../kriti/kriti_results_page.dart';
import '../kriti/kriti_schedule_page.dart';
import '../kriti/kriti_standings_page.dart';
import 'forms/add_manthan_event_form.dart';

class ManthanHome extends StatefulWidget {
  const ManthanHome({Key? key}) : super(key: key);

  @override
  State<ManthanHome> createState() => _ManthanHomeState();
}

class _ManthanHomeState extends State<ManthanHome> {
  Map<Pages, Widget> tabs = {
    Pages.schedule: const KritiSchedulePage(),
    Pages.standings: const KritiStandingsPage(),
    Pages.results: const KritiResultsPage(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: Themes.backgroundColor,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56), child: AppBarHomeComponent()),
        body: commonStore.viewType == ViewType.user
            ? tabs[commonStore.page]
            : (commonStore.isManthanAdmin
                ? tabs[commonStore.page]
                : const RestrictedPage()),
                
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: commonStore.viewType == ViewType.admin &&
            commonStore.isManthanAdmin &&
            commonStore.page == Pages.schedule
            ? GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddManthanEventForm()));
          },
          child: const AddButton(
            text: 'Add event',

            width: 130,
          ),
        )
            : Container(),
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
