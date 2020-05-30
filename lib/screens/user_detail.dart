import 'package:flutter/material.dart';
import 'package:githubevent/models/users_event.dart';
import 'package:githubevent/utility/my_utility.dart';
import 'package:githubevent/widgets/UserDetailOpaImg.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetail extends StatefulWidget {
  final UsersEvents userData;

  const UserDetail({Key key, this.userData}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    flex: 4,
                    child: Stack(
                      children: <Widget>[
                        UserDetailOpaImg(
                          imageUrl: widget.userData.actor.avatarUrl,
                        ),
                        Container(
                          padding: EdgeInsets.only(top:50),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Hero(
                                    tag: widget.userData.id,
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      child: CircleAvatar(
                                        radius: 60.0,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 55.0,
                                          backgroundImage: NetworkImage(
                                              widget.userData.actor.avatarUrl),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.userData.actor.displayLogin}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.verified_user,
                                    color: Colors.white70,
                                  ),
                                  Text(
                                    "${widget.userData.id}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 40.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    )),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35.0),
                        topLeft: Radius.circular(35.0),
                      ),
                      color: MyUtility().mainThemeAccent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Ropositories",
                            style: TextStyle(
                                color: MyUtility().mainThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.arrow_right),
                              Text(
                                widget.userData.repo.name,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.arrow_right),
                              Flexible(
                                child: Text(
                                  widget.userData.repo.url,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Type",
                            style: TextStyle(
                                color: MyUtility().mainThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(children: <Widget>[Icon(Icons.arrow_right),
                            Text(
                              widget.userData.public?"Public":"Private",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )],),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            "Created at",
                            style: TextStyle(
                                color: MyUtility().mainThemeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(children: <Widget>[Icon(Icons.arrow_right),
                            Text(
                              widget.userData.createdAt,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )],),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              child: Text(
                                "Go to Github ${widget.userData.actor.login}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: MyUtility().mainThemeColor,
                              textColor: Colors.white,
                              onPressed: () {
                                _launchURL(widget.userData.actor.login);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String name) async {
    String url = "https://github.com/${name}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
