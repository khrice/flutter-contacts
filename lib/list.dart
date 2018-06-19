// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import './contact.dart';
import 'package:contacts_service/contacts_service.dart';
import './contactDetails.dart';

enum _MaterialListType {
  /// A list tile that contains a single line of text.
  oneLine,

  /// A list tile that contains a [CircleAvatar] followed by a single line of text.
  oneLineWithAvatar,

  /// A list tile that contains two lines of text.
  twoLine,

  /// A list tile that contains three lines of text.
  threeLine,
}

class ListDemo extends StatefulWidget {
  const ListDemo({Key key}) : super(key: key);

  static const String routeName = '/material/list';

  @override
  _ListDemoState createState() => new _ListDemoState();
}

class _ListDemoState extends State<ListDemo> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  PersistentBottomSheetController<Null> _bottomSheet;
  Iterable<Contact> _contacts;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  initPlatformState() async {
    var contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Contacts'),
      ),
      body: new Scrollbar(
        child: new SafeArea(
          child: _contacts != null
              ? new ListView.builder(
                  itemCount: _contacts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Contact c = _contacts?.elementAt(index);
                    return new ListTile(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ContactDetails(c)));
                      },
                      leading: (c.avatar != null && c.avatar.length > 0)
                          ? new CircleAvatar(
                              backgroundImage: new MemoryImage(c.avatar))
                          : new CircleAvatar(
                              child: new Text(c.displayName?.length > 1
                                  ? c.displayName?.substring(0, 2)
                                  : "")),
                      title: new Text(c.displayName ?? ""),
                    );
                  },
                )
              : new Center(child: new CircularProgressIndicator()),
        ),
      ),
    );
  }
}
