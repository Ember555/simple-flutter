import 'dart:async';

import 'package:flutter/material.dart';
import '../controller/list.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  Future<List<Post>> post;

  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  void handleClick() {
    post = fetchPost();
  }

  MediaQueryData queryData;

  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Page',
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
                Navigator.popAndPushNamed(context, '/first');
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
                Navigator.pushNamed(context, '/forth');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(15.0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'List',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FutureBuilder<List<Post>>(
                      future: post,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(child: Text('no data'));
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        List<Post> postList = snapshot.data;
                        return Table(
                            defaultColumnWidth: FlexColumnWidth(150.0),
                            children: postList.map((item) {
                              return _buildTableRow(item.id.toString() +
                                  "," +
                                  item.name.toString() +
                                  "," +
                                  item.quota.toString());
                            }).toList());
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () {
                          handleClick();
                          setState(() {});
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey,
        gradient: LinearGradient(
            colors: [Colors.grey[200], Colors.grey[300]],
            begin: Alignment.centerRight,
            end: Alignment(1.0, 1.0)),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Text(name, style: TextStyle(fontSize: 15.0)),
          padding: EdgeInsets.all(10.0),
        );
      }).toList(),
    );
  }
}
