import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:githubevent/models/users_event.dart';
import 'package:githubevent/screens/user_detail.dart';
import 'package:githubevent/widgets/users_selects.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<UsersEvents> _userEvents = List();
  List<UsersEvents> _reversrUserEvents = List();

  @override
  void initState() {
    // TODO: implement initState
    _fetchGithubUsers();
    super.initState();
  }

  Future<void> _fetchGithubUsers() async {
    try {
      await Future.delayed(Duration(milliseconds: 1000));
      var dio = Dio();
      Response response = await dio.get("https://api.github.com/events");
      if (response != null && response.statusCode == 200) {
        for (var item in response.data) {
          UsersEvents users = UsersEvents.fromJson(item);
          setState(() {
            _userEvents.add(users);
          });
        }
        setState(() {
          _reversrUserEvents = _userEvents.reversed.toList();
        });
      }
    } catch (e) {
      print(e);
    }
    print('refresh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        appBar: AppBar(
          title: Align(
            alignment: Alignment.center,
            child: Text("Github Events"),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(),
        body: Column(
          children: <Widget>[
            UsersSelector(),
            Expanded(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .accentColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Fevorite Users",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                          Spacer(),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      padding: EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _userEvents != null ? _userEvents.length : 0,
                        itemBuilder: (BuildContext context, int index) {
                          final user = _userEvents[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      UserDetail(userData: user)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Hero(
                                      tag: _userEvents[index].id,
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                            _userEvents[index].actor.avatarUrl),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      width: 60,
                                      child: Text(
                                        _userEvents[index].actor.displayLogin,
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35.0),
                            topRight: Radius.circular(35.0),
                          ),
                        ),
                        child: RefreshIndicator(
                          onRefresh: _fetchGithubUsers,
                          child: ListView.builder(
                            itemCount: _reversrUserEvents != null
                                ? _reversrUserEvents.length
                                : 0,
                            itemBuilder: (BuildContext context, int index) {
                              final user = _reversrUserEvents[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserDetail(
                                                userData: user,
                                              )));
                                },
                                child: Card(
                                  child: ListTile(
//                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    leading: Hero(
                                      tag: user.id,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage:
                                        NetworkImage(user.actor.avatarUrl),
                                      ),
                                    ),
                                    title: Text(
                                      user.actor.displayLogin,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    subtitle: Text(user.repo.name),
                                    trailing: Icon(Icons.arrow_right),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
