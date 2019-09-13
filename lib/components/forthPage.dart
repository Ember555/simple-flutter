import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase/firestore.dart' as fs;
import 'package:firebase/firebase.dart';

class ForthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForthPageState();
  }
}

class _ForthPageState extends State<ForthPage> with TickerProviderStateMixin {
  final fs.Firestore store = firestore();
  final List<Map<String, dynamic>> rewards = List();
  String _buttonState = "start";

  fetchRewards() async {
    var rewardsRef = await store.collection('rewardItem').get();

    rewardsRef.forEach(
      (doc) {
        rewards.add(doc.data());
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchRewards();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lucky Draw V2',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Header', style: TextStyle(fontSize: 25.0)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('List', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pushNamed(context, '/');
              },
            ),
            ListTile(
              title: Text('Create', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pushNamed(context, '/second');
              },
            ),
            ListTile(
              title: Text('Draw V1', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pushNamed(context, '/third');
              },
            ),
            ListTile(
              title: Text('Draw V2', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.popAndPushNamed(context, '/forth');
              },
            ),
          ],
        ),
      ),
      body: AnimatedBackground(
        behaviour: BubblesBehaviour(),
        vsync: this,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buttonState == "stop"
                ? Center(
                    child: CarouselSlider(
                      height: 150.0,
                      autoPlay: true,
                      autoPlayInterval: Duration(milliseconds: 500),
                      items: rewards.map(
                        (reward) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                constraints: BoxConstraints(
                                  maxWidth: 300.0,
                                  minWidth: 150.0,
                                ),
                                child: Image.asset(
                                  'images/' + reward['name'] + '.png',
                                  height: 50.0,
                                  width: 50.0,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                  )
                : (_buttonState == "back"
                    ? Image.asset(
                        'images/rw1.png',
                        height: 300.0,
                        width: 300.0,
                        fit: BoxFit.cover,
                      )
                    : Text("")),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 100),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  textColor: Colors.white,
                  color: Colors.amber[900],
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    _buttonState,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () => {
                    setState(() {
                      _buttonState = _buttonState == "start"
                          ? "stop"
                          : (_buttonState == "stop" ? "back" : "start");
                    })
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
