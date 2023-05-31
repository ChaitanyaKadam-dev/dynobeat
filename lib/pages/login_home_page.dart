import 'package:dynobeat/auth.dart';
import 'package:flutter/material.dart';

class LoginHomePage extends StatelessWidget {
  LoginHomePage({required Key key}) : super(key: key);

  final Stream user = Auth().currentUser;

  Future<void> signout() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('DynoBeat Login');
  }

  Widget _userUid() {
    return const Text('User Email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signout,
      child: const Text('Signout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}

