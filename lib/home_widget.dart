import 'package:flutter/material.dart';
import 'package:jourv2/views/new_works/schedule_view.dart';
import 'pages.dart';
import 'views/home_view.dart';
import 'package:jourv2/models/work.dart';
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
    LogsPage(),
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
          title: Text('personal diary app'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
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
            IconButton(
              icon: Icon(Icons.undo),
              onPressed: () async {
                try {
                  AuthService auth = Provider.of(context).auth;
                  await auth.signOut();
                  print("Signed Out!");
                } catch (e) {
                  print(e);
                }
              },
            )
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
              icon: new Icon(Icons.collections_bookmark),
              title: new Text('Logs'),
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
