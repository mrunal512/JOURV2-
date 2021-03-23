import 'package:flutter/material.dart';
import 'package:jourv2/views/new_works/schedule_view.dart';
import '../pages.dart';
import 'home_view.dart';
import 'package:jourv2/models/work.dart';
import 'profile_view.dart';
import 'package:jourv2/widget/provider_widget.dart';
import 'package:jourv2/services/auth_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    SchedulePage(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    final newWork = new details(
      null,
      null,
      null,
      null,
      null,
      null,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('JOUR - a personal diary app'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewScheduleLog(
                              detail: newWork,
                            )),
                  );
                },
              ),
            ),

            // IconButton(
            //   icon: Icon(Icons.undo),
            //   onPressed: () async {
            //     try {
            //       AuthService auth = Provider.of(context).auth;
            //       await auth.signOut();
            //       print("Signed Out!");
            //     } catch (e) {
            //       print(e);
            //     }
            //   },
            // )
          ],
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.event),
              title: new Text('Schedule'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text('Profile'),
            ),
          ],
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
