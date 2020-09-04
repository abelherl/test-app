import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/services/auth_cubit.dart';
import 'package:test_app/services/counter_bloc.dart';
import 'package:test_app/services/counter_event.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black87,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LoginHeader(),
              SizedBox(height: 40),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image(
            image: NetworkImage('https://s3.amazonaws.com/tasmeemme.project.mi.thumbnails/resize_805x9000/597/442597.png'),
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 25),
        Center(
          child: Text(
            'Login to Al Shami',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  var isAllFilled = false;
  final _formKey = GlobalKey<FormState>();
  final _bloc = CounterBloc();

  void validate() {
    if (isAllFilled) {
      final form = _formKey.currentState;
      if (form.validate()) {
        context.bloc<AuthCubit>().tryLoginEmail(_email.text, _password.text);
      } else {
        print('form invalid');
      }
    }
  }

  void checkIfAllFilled() {
    print("CALLED");
    if (_email.text.isNotEmpty && _email.text.isNotEmpty) {
      isAllFilled = true;
    }
    else {
      isAllFilled = false;
    }
  }

  @override
  void initState() {
    super.initState();
    context.bloc<AuthCubit>().isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
//          Text(
//            "Enter phone number",
//            style: TextStyle(
//              fontSize: 10,
//              color: isPhoneNumberFilled ? Colors.grey[800] : Colors.transparent,
//            ),
//          ),
//          Container(
//            transform: Matrix4.translationValues(0, -5, 0),
//            height: 70,
//            child: TextFormField(
//              controller: _phone,
//              validator: (text) => text.length < 10 ? "Minimum 10 digit number" : null,
//              style: TextStyle(color: Colors.black,),
//              inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly,],
//              keyboardType: TextInputType.number,
//              onChanged: (text) { setState(() => isPhoneNumberFilled = text.isNotEmpty ? true : false); },
//              textAlignVertical: TextAlignVertical.center,
//              decoration: InputDecoration(
//                hintText: "Enter phone number",
//                prefixIcon: Container(
//                  width: 75,
//                  child: Row(
//                    children: [
//                      Icon(Icons.phone_android, color: Colors.grey[400]),
//                      SizedBox(width: 5),
//                      Text("+966", style: TextStyle(fontWeight: FontWeight.bold),),
//                    ],
//                  ),
//                ),
//                border: UnderlineInputBorder(
//                    borderSide: BorderSide(
//                      width: 0.5,
//                    )
//                ),
//              ),
//            ),
//          ),
          TextFormField(
            controller: _email,
            onChanged: (_) => checkIfAllFilled(),
            style: TextStyle(color: Colors.black,),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: "Enter email",
              prefixIcon: Icon(Icons.alternate_email, color: Colors.grey[400]),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.5,
                  )
              ),
            ),
          ),
          Container(
            transform: Matrix4.translationValues(0, -5, 0),
            height: 70,
            child: TextFormField(
              controller: _password,
              onChanged: (_) => checkIfAllFilled(),
              obscureText: true,
              style: TextStyle(color: Colors.black,),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Enter password",
                prefixIcon: Icon(Icons.lock, color: Colors.grey[400]),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                    )
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is FailedState) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(state.errorMessage),
                    );
                  },
                );
              }
              if (state is SuccessState) {
                Navigator.pushReplacementNamed(context, "/home");
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is SuccessState) {
                  return Parent(
                    style: ParentStyle()
                      ..height(40)
                      ..width(MediaQuery.of(context).size.width)
                      ..background.color(Colors.grey[400])
                      ..borderRadius(all: 5),
                    child: FlatButton(
                      child: Text(
                        "LOGGED IN WITH USER NAMED ${state.user.name}",
                        style: TextStyle(
                          color: isAllFilled ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }
                return Parent(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


