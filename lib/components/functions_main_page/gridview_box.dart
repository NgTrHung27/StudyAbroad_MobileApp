import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/functions/alert_dialog.dart';
import 'package:kltn_mobile/components/functions_main_page/boxgradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/authentication/auth_notify.dart';
import 'package:provider/provider.dart';

class BoxGridView extends StatelessWidget {
  const BoxGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    // final isLoggedIn = Provider.of<bool>(context);
    final isLoggedIn = context.watch<AuthNotifier>().isLoggedIn;
    final actionS1 = localizations != null
        ? localizations.home_action_orange_Score1
        : 'Default Text';
    final actionS2 = localizations != null
        ? localizations.home_action_orange_Score2
        : 'Default Text';
    final actionNews1 = localizations != null
        ? localizations.home_action_green_News1
        : 'Default Text';
    final actionNews2 = localizations != null
        ? localizations.home_action_green_News2
        : 'Default Text';
    final actionComments1 = localizations != null
        ? localizations.home_action_blue_Comments1
        : 'Default Text';
    final actionComments2 = localizations != null
        ? localizations.home_action_blue_Comments2
        : 'Default Text';

    int crossAxisCount =
        MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 3;
    double childAspectRatio =
        MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2.3;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? 330
          : 330, // Điều chỉnh chiều cao khi thiết bị xoay

      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 17,
        mainAxisSpacing: 17,
        childAspectRatio: height * childAspectRatio / 755,
        children: [
          BoxGradient(
            color1: const Color(0xffFF9736),
            color2: const Color(0xffC41010),
            smallText: actionS1,
            bigText: actionS2,
            onTap: () {
              isLoggedIn
                  ? Navigator.pushNamed(context, '/news')
                  : showCustomDialog(
                      context: context,
                      onConfirm: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    );
            },
            image: const AssetImage('assets/icons_3d/icon_3d_medal.png'),
          ),
          BoxGradient(
            color1: const Color(0xff86E0D0),
            color2: const Color(0xff3A9571),
            smallText: actionNews1,
            bigText: actionNews2,
            onTap: () {
              Navigator.pushNamed(context, "/news");
            },
            image: const AssetImage('assets/icons_3d/icon_3d_newspaper.png'),
          ),
          BoxGradient(
            color1: const Color(0xff80E8FF),
            color2: const Color(0xff297BC5),
            smallText: actionComments1,
            bigText: actionComments2,
            onTap: () {
              Navigator.pushNamed(context, "/contactus");
            },
            image: const AssetImage('assets/icons_3d/icon_3d_contact.png'),
          ),
        ],
      ),
    );
  }
}
