import 'package:flutter_web/material.dart';
import 'dart:async';
import '../controller/draw.dart';

class DrawPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DrawPage();
  }
}

class _DrawPage extends State<DrawPage> with TickerProviderStateMixin {
  Future<Post> post;
  AnimationController _controller, animationController;
  Animation animation, sizeAnimation;
  String _buttonState = 'Draw';
  bool _isButtonDisabled;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = false;
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0, end: 60).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    sizeAnimation = Tween(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  // void dispose() {
  //   _controller.dispose();
  // }

  void handleDraw() {
    post = drawPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lucky Draw',
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
              title: Text('Third', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 150),
                child: FutureBuilder<Post>(
                  future: post,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.code == 200) {
                        return Column(
                          children: <Widget>[
                            Image.asset(
                              'images/' +
                                  snapshot.data.result.reward.id +
                                  '.png',
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top:8.0),
                              child: Image.asset(
                                'images/error.jpg',
                                height: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top:8.0),
                                child: Text(snapshot.data.message,
                                    style: TextStyle(fontSize: 20.0)))
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Column(
                        children: <Widget>[
                          Image.asset(
                            'images/error.jpg',
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Text("${snapshot.error}")
                        ],
                      );
                    }

                    // By default, show a loading spinner.
                    return AnimatedBuilder(
                      animation: _controller,
                      child: Column(children: <Widget>[
                        Image.asset(
                          'images/wheel.png',
                          width: 200.0,
                          fit: BoxFit.cover,
                        )
                      ]),
                      builder: (BuildContext context, Widget child) {
                        return Transform.rotate(
                          angle: _controller.value * 2.0 * 3.14,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 400),
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
                  onPressed: _isButtonDisabled
                      ? null
                      : () async {
                          if (_buttonState == 'Back') {
                            await Navigator.pushNamed(context, '/third');
                          }
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          _controller..repeat();
                          await Future.delayed(const Duration(seconds: 3));
                          handleDraw();
                          await Future.delayed(const Duration(seconds: 3));
                          setState(() {
                            _buttonState =
                                _buttonState == 'Draw' ? 'Back' : 'Draw';
                            _isButtonDisabled = false;
                          });
                        },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
