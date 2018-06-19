import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';

class _ContactData {
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
}

createContact(data) {
  Item phone =
      new Item(label: "Phone Number", value: data.phoneNumber.toString());
  Item email = new Item(label: "Email", value: data.email.toString());

  Contact contact = new Contact(
      givenName: data.firstName,
      familyName: data.lastName,
      phones: [phone],
      emails: [email]);
  ContactsService.addContact(contact).catchError((err) {
    print(err);
  });
}

class ContactDetails extends StatelessWidget {
  ContactDetails(this._contact);
  final Contact _contact;
  _ContactData _data = new _ContactData();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(_contact.displayName ?? ""),
          actions: <Widget>[
            new FlatButton(
                child: _contact.givenName != null
                    ? new Icon(Icons.delete)
                    : null,
                onPressed: () {
                  ContactsService.deleteContact(_contact);
                })
          ]),
      body: new Scrollbar(
        child: new ContactDetailsForm(formKey: _formKey, data: _data)
      ),
    );
  }
}

class ContactDetailsForm extends StatelessWidget {
  const ContactDetailsForm({
    Key key,
    @required this.formKey,
    @required this.data,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final _ContactData data;

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: new Form(
        key: formKey,
        autovalidate: false,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                  keyboardType:
                      TextInputType.text, // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: 'John', labelText: 'First Name'),
                  onSaved: (String value) {
                    this.data.firstName = value;
                  }),
              new TextFormField(
                  keyboardType:
                      TextInputType.text, // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: 'Doe', labelText: 'Last Name'),
                  onSaved: (String value) {
                    this.data.lastName = value;
                  }),
              new TextFormField(
                  keyboardType: TextInputType
                      .emailAddress, // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: 'you@example.com', labelText: 'E-mail Address'),
                  onSaved: (String value) {
                    this.data.email = value;
                  }),
              new TextFormField(
                  keyboardType:
                      TextInputType.phone, // Use email input type for emails.
                  decoration: new InputDecoration(
                      hintText: '111-222-3333', labelText: 'Phone Number'),
                  onSaved: (String value) {
                    this.data.phoneNumber = value;
                  }),
              new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new RaisedButton(
                  onPressed: () {
                    formKey.currentState.save();
                    createContact(data);
                  },
                  child: new Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
