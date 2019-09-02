import 'dart:async';

import 'package:flutter_web/material.dart';
import '../helper/post.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  Future<Post> post;
  int count = 1;

  @override
  void initState() {
    super.initState();
    post = fetchPost(count);
  }

  void handleClick() {
    count++;
    post = fetchPost(count);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Admin Console',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ))),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('',
                  style: TextStyle(
                    fontSize: 10,
                  )),
              Text('Table',
                  style: TextStyle(
                    fontSize: 25,
                  )),
              Text('',
                  style: TextStyle(
                    fontSize: 30,
                  )),
              FutureBuilder<Post>(
                future: post,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data.title);
                    return Table(
                      defaultColumnWidth: FixedColumnWidth(250.0),
                      border: TableBorder(
                        horizontalInside: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        verticalInside: BorderSide(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                      ),
                      children: [
                        _buildTableRow("userId, id, title, body"),
                        _buildTableRow(snapshot.data.userId.toString() +
                            "," +
                            snapshot.data.id.toString() +
                            "," +
                            snapshot.data.title.toString() +
                            "," +
                            snapshot.data.body.toString()),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                      onPressed: () {
                        handleClick();
                        setState(() {});
                      },
                      child: Text('Post'))),
            ],
          )
        ],
      ),
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(name, style: TextStyle(fontSize: 20.0)),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}
