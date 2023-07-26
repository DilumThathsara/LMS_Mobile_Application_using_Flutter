import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_moodel/providers/notification_provider.dart';
import 'package:proacademy_moodel/providers/user_provider.dart';
import 'package:proacademy_moodel/screens/main/home/home_screen.dart';
import 'package:proacademy_moodel/screens/main/message/conversation/conversations.dart';
import 'package:proacademy_moodel/screens/main/profile/profile.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    //---since using observer, anthing that is observing must be initilize in the state fubction
    WidgetsBinding.instance.addObserver(this);

    //--- get and update device token
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotification(context);

    //--- handling forground notifications
    Provider.of<NotificationProvider>(context, listen: false)
        .forgroundHandler();

    //--- handling when click on notifications to open the appp from background
    Provider.of<NotificationProvider>(context, listen: false)
        .onClickedOpenedApp(context);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  //---lifecycle in build function to determine if the user is on or closed the screen
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    Logger().w(state);

    switch (state) {
      case AppLifecycleState.resumed:
        Provider.of<userProvider>(context, listen: false)
            .updateUserOnline(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        Provider.of<userProvider>(context, listen: false)
            .updateUserOnline(false);
        break;
    }
  }

  //-------store the active index
  int activeIndex = 0;

  //----trigger when bottom nav item is clicked
  void onItemTapped(int val) {
    setState(() {
      activeIndex = val;
    });
  }

  //-------screen list
  final List<Widget> _screens = [
    const HomeScreen(),
    const Conversations(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _screens.elementAt(activeIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.facebookMessenger,
                    text: 'Chat',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: activeIndex,
                onTabChange: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
