import 'dart:async';

import 'package:flutter_web/material.dart';
import '../controller/post.dart';

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
  Future<List<Post>> post;
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

  MediaQueryData queryData;

  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    print(queryData);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Console',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.border_all),
        //     onPressed: () => setState(() {}),
        //   )
        // ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Admin Header', style: TextStyle(fontSize: 25.0)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pushNamed(context, '/second');
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
                    Text('Table',
                        style: TextStyle(
                          fontSize: 25,
                        )),
                    FutureBuilder<List<Post>>(
                      future: post,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        List<Post> postList = snapshot.data;
                        return Table(
                            defaultColumnWidth: FlexColumnWidth(150.0),
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            children: postList.map((item) {
                              return _buildTableRow(item.id.toString() +
                                  "," +
                                  item.name.toString() +
                                  "," +
                                  item.username.toString() +
                                  "," +
                                  item.email.toString());
                            }).toList());
                      },
                    ),
                    Container(
                        margin: EdgeInsets.all(0),
                        child: RaisedButton(
                            onPressed: () {
                              handleClick();
                              setState(() {});
                            },
                            child: Text('Post',
                                style: TextStyle(fontSize: 20.0)))),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String listOfNames) {
    return TableRow(
      children: listOfNames.split(',').map((name) {
        return Container(
          alignment: Alignment.centerLeft,
          child: Text(name, style: TextStyle(fontSize: 15.0)),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }
}
