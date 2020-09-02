import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _birthdate = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _formattedDate = DateFormat('dd-MM-yyy').format(DateTime.now());
  String errorAt = "";

  bool isAllFilled = false;
  bool isNameFieldError = false;

  void saveData() async {
    print('Saving data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', _name.text);
    prefs.setString('user_email', _email.text);
    prefs.setString('user_address', _address.text);
    prefs.setString('user_birthdate', _birthdate.text);
  }

  void loadData() async {
    print('Loading data');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name.text = prefs.getString('user_name') ?? "";
      _email.text = prefs.getString('user_email') ?? "";
      _address.text = prefs.getString('user_address') ?? "";
      _birthdate.text = prefs.getString('user_birthdate') ?? "";
    });

    context.bloc<AuthCubit>().isLoggedIn();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1940, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _formattedDate = DateFormat('dd-MM-yyy').format(_selectedDate);
        _birthdate.text = _formattedDate;
      });
  }

  void checkIfAllFilled() {
    print("CALLED");
    if (_name.text.isNotEmpty && _email.text.isNotEmpty && _address.text.isNotEmpty) {
      isAllFilled = true;
    }
    else {
      isAllFilled = false;
    }
    saveData();
  }

  void checkErrors(FailedState state) {
    var error = "";
    if (state.field != "name") {
      if (state.field != "email") {
        if (state.field != "address") {
          if (state.field == "birthdate") {
            error = "birthdate";
          }
        }
        else {
          error = "address";
        }
      }
      else {
        error = "email";
      }
    }
    else {
      error = "name";
      setState(() {
        isNameFieldError = true;
      });
    }

    setState(() {
      errorAt = error;
    });

    print("$error ${state.field}");
  }

  bool checkErrorOnField(String field) {
    var error = false;
    if (errorAt == field) {
      error = true;
    }
    print("$error because $errorAt ${field}");
    return error;
  }

  void validate() {
    checkIfAllFilled();
    if (isAllFilled) {
      final form = _formKey.currentState;
      if (form.validate()) {
        print("Validating");
        context.bloc<AuthCubit>().tryRegister(_name.text, _email.text, _address.text, _birthdate.text);
        checkErrors(context.bloc<AuthCubit>().state);
      } else {
        print('form invalid');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    checkIfAllFilled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is FailedState) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                      ));
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is SuccessState) { return SuccessWidget(state: state, isAllFilled: isAllFilled); }
                      if (state is FailedState) {
                        return Column(
                          children: [
                            TextFormField(
                              validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                              onChanged: (_) => checkIfAllFilled(),
                              controller: _name,
                              style: TextStyle(color: Colors.black,),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Enter name",
                                prefixIcon: Icon(Icons.person, color: checkErrorOnField("name") ? Colors.redAccent : Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: isNameFieldError ? Colors.redAccent : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                              onChanged: (_) => checkIfAllFilled(),
                              controller: _email,
                              style: TextStyle(color: Colors.black,),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Enter email",
                                prefixIcon: Icon(Icons.alternate_email, color: checkErrorOnField("email") ? Colors.redAccent : Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: checkErrorOnField("email") ? Colors.redAccent : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                              onChanged: (_) => checkIfAllFilled(),
                              controller: _address,
                              style: TextStyle(color: Colors.black,),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Enter address",
                                prefixIcon: Icon(Icons.home, color: checkErrorOnField("address") ? Colors.redAccent : Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: checkErrorOnField("address") ? Colors.redAccent : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              onChanged: (_) => checkIfAllFilled(),
                              controller: _birthdate,
                              style: TextStyle(color: Colors.black,),
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: "Enter birthdate",
                                prefixIcon: Icon(Icons.date_range, color: checkErrorOnField("birthdate") ? Colors.redAccent : Colors.grey[400]),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 0.5,
                                    color: checkErrorOnField("birthdate") ? Colors.redAccent : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Parent(
                              gesture: Gestures(),
                              style: ParentStyle()
                                ..height(40)
                                ..width(MediaQuery.of(context).size.width)
                                ..background.color(isAllFilled ? Colors.lightGreen[800] : Colors.grey[400])
                                ..borderRadius(all: 5)
                                ..ripple(isAllFilled ? true : false),
                              child: FlatButton(
                                onPressed: () {
                                  validate();
                                },
                                child: Text(
                                  "NEXT",
                                  style: TextStyle(
                                    color: isAllFilled ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          TextFormField(
                            validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                            onChanged: (_) => checkIfAllFilled(),
                            controller: _name,
                            style: TextStyle(color: Colors.black,),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                            hintText: "Enter name",
                            prefixIcon: Icon(Icons.person, color: Colors.grey[400]),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                            onChanged: (_) => checkIfAllFilled(),
                            controller: _email,
                            style: TextStyle(color: Colors.black,),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Enter email",
                              prefixIcon: Icon(Icons.alternate_email, color: Colors.grey[400]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                            onChanged: (_) => checkIfAllFilled(),
                            controller: _address,
                            style: TextStyle(color: Colors.black,),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Enter address",
                              prefixIcon: Icon(Icons.home, color: Colors.grey[400]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            validator: (text) => text.length < 1 ? "Field can't be empty" : null,
                            readOnly: true,
                            onTap: () => _selectDate(context),
                            onChanged: (_) => checkIfAllFilled(),
                            controller: _birthdate,
                            style: TextStyle(color: Colors.black,),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "Enter birthdate",
                              prefixIcon: Icon(Icons.date_range, color: Colors.grey[400]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                          Parent(
                            gesture: Gestures(),
                            style: ParentStyle()
                              ..height(40)
                              ..width(MediaQuery.of(context).size.width)
                              ..background.color(isAllFilled ? Colors.lightGreen[800] : Colors.grey[400])
                              ..borderRadius(all: 5)
                              ..ripple(isAllFilled ? true : false),
                            child: FlatButton(
                              onPressed: () {
                                validate();
                              },
                              child: Text(
                                "NEXT",
                                style: TextStyle(
                                  color: isAllFilled ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({
    Key key,
    @required this.state,
    @required this.isAllFilled,
  }) : super(key: key);

  final SuccessState state;
  final bool isAllFilled;

  @override
  _SuccessWidgetState createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_logged_in', true);
  }

  @override
  void initState() {
    super.initState();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      gesture: Gestures()
        ..onTap(() { context.bloc<AuthCubit>().logout(); }),
      style: ParentStyle()
        ..height(40)
        ..width(MediaQuery.of(context).size.width)
        ..background.color(Colors.grey[400])
        ..borderRadius(all: 5),
      child: FlatButton(
        child: Text(
          "LOGGED IN WITH USER NAMED ${widget.state.user.name}",
          style: TextStyle(
            color: widget.isAllFilled ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
