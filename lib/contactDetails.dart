import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactDetails extends StatelessWidget {
  ContactDetails(this._contact);
  final Contact _contact;
  final firstNameCtrl = new TextEditingController();
  final lastNameCtrl = new TextEditingController();
  final phoneCtrl = new TextEditingController();
  final emailCtrl = new TextEditingController();

  createContact() {
    String firstName = firstNameCtrl.value.toString();
    String lastName = lastNameCtrl.value.toString();
    Item phone =
        new Item(label: "Phone Number", value: phoneCtrl.value.toString());
    Item email = new Item(label: "Email", value: emailCtrl.value.toString());
    Contact contact = new Contact(
        givenName: firstName,
        familyName: lastName,
        phones: [phone],
        emails: [email]);
    print(contact);
    ContactsService.addContact(contact);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(_contact.displayName ?? ""),
            actions: <Widget>[
              new FlatButton(
                  child: _contact.givenName != null
                      ? new Icon(Icons.delete)
                      : new Icon(Icons.save),
                  onPressed: () {
                    _contact.givenName != null
                        ? ContactsService.deleteContact(_contact)
                        : createContact();
                  })
            ]),
        body: new SafeArea(
          child: _contact.givenName != null
              ? new ListView(children: <Widget>[
                  new ListTile(
                      title: new Text("First Name"),
                      trailing: new Text(_contact.givenName ?? "")),
                  new ListTile(
                      title: new Text("Last name"),
                      trailing: new Text(_contact.familyName ?? "")),
                  new ListTile(
                      title: new Text("Phone Number"),
                      trailing: new Text(_contact.phones.toList()[0] ?? "")),
                  new ListTile(
                      title: new Text("Email"),
                      trailing: new Text(_contact.emails.toList()[0] ?? "")),
                ])
              : new Form(
                  key: new GlobalKey<FormState>(),
                  autovalidate: false,
                  child: new SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new TextFormField(
                            controller: firstNameCtrl,
                            decoration:
                                const InputDecoration(labelText: "First Name")),
                        new TextFormField(
                            controller: lastNameCtrl,
                            decoration:
                                const InputDecoration(labelText: "Last Name")),
                        new TextFormField(
                            controller: phoneCtrl,
                            keyboardType: TextInputType.phone,
                            decoration:
                                const InputDecoration(labelText: "Phone Number")),
                        new TextFormField(
                            controller: emailCtrl,
                            decoration:
                                const InputDecoration(labelText: "Email")),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
