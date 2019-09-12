import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SecondScreen();
  }
}

class _SecondScreen extends State<SecondScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Page',
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Third', style: TextStyle(fontSize: 20.0)),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                setState(() {});
                Navigator.pushNamed(context, '/third');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your first and last name',
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  hintText: 'Enter your date of birth',
                  labelText: 'Dob',
                ),
                keyboardType: TextInputType.datetime,
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter a phone number',
                  labelText: 'Phone',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter a email address',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Container(
                  padding: EdgeInsets.only(left: 40.0, top: 20.0),
                  child: RaisedButton(
                    child: Text('Submit'),
                    onPressed: null,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
