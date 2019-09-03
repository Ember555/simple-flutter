import 'package:flutter_web/material.dart';
import 'package:flutter_web/services.dart';

import '../controller/draw.dart';

class ThirdScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdScreen();
  }
}

class _ThirdScreen extends State<ThirdScreen> {
  Future<Post> post;

  @override
  void initState() {
    super.initState();
  }

  void handleDraw() {
    post = drawPost();
  }

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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 250),
                child: FutureBuilder<Post>(
                  future: post,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.result.reward.id);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return Text('???', style: TextStyle(fontSize: 20.0));;
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 300),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.limeAccent[700],
                  padding: EdgeInsets.all(8.0),
                  child: Text('Draw'),
                  onPressed: () {
                    handleDraw();
                    setState(() {});
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
