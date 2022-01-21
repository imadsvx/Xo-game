

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:x_o_game/Pages/homepage.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email , _password;
  final auth = FirebaseAuth.instance;

  //form key
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
  //email field 
  final emailField = TextFormField(
   autofocus: false,
  
   keyboardType: TextInputType.emailAddress,
validator:(value){
  if(value!.isEmpty)
  {
   return ("s'il vous entrer le email");
  }
   onChanged: (value){
          setState(() {
            _email=value.trim();
          });
        };
//reg expression for email validation
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value!)) {
            return ("s'il vous plait entrer le email");
          }
          return null;

} ,
   onSaved: (value)
   {
  
   },
   textInputAction: TextInputAction.next,
decoration: InputDecoration(
prefixIcon: Icon(Icons.mail,
color: Colors.brown),
contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
hintText: "Email",
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(10),
),
),
  );
  //password field
    final passwordField = TextFormField(
        autofocus: false,
      
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Le mot de passe est requis pour la connexion");
          }
          if (!regex.hasMatch(value!)) {
            return ("Enter Mot de passe valid (Min. 6 Character)");
          }
        },
        onChanged: (value){
          setState(() {
            _password=value.trim();
          });
        },
      
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key,
          color: Colors.brown,),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
  //Button field
final loginButton =Material(
elevation: 5,
borderRadius: BorderRadius.circular(30),
color: Colors.brown[500],
child: MaterialButton(
  padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
  minWidth: MediaQuery.of(context).size.width,
  
  child: Text("Login",
  textAlign: TextAlign.center,
  style: TextStyle(fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  ),
  ),
  onPressed: (){
    auth.signInWithEmzilAndPassword(email:_email,password:_password);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>HomePage()));
  },
  ),
);
    var mail;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
           color: Colors.white,
           child: Padding(
             padding: const EdgeInsets.all(36.0),
             child: Form(
               key: _formKey,
               child:Column (
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[

                   SizedBox(
                        height: 200,
                        child: Image.asset("assets/images/xo.jpg",
                        fit: BoxFit.contain,
                        ),
                   ),
                   SizedBox(
                    height: 45,
                   ),
                   emailField,
                    SizedBox(
                    height: 25,
                   ),
                   passwordField,
                    SizedBox(
                    height: 35,
                   ),
                   loginButton,
                    SizedBox(
                    height: 15,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children:<Widget> [
                       Text("Don't have an Account?"),
                       GestureDetector(
                         onTap: (){
                               auth.createUserWithEmailAndPassword(email:_email,password:_password);
                         },
                         
                         child: Text("Sign Up",
                         style: TextStyle(
                           color:Colors.brown[400],
                           fontWeight: FontWeight.w600,
                           fontSize: 15),
                          )
                         ),
                     ],
                   ),
                   SizedBox(
                     width: 200,
                     child:RaisedButton(
                       child: Row(
                         children:<Widget>[
                           Icon(Icons.thumb_up,size: 25),
                           Text(
                             'Sign up with Facebook',
                             style: TextStyle(fontSize: 15),
                           ),
                         ],
                       ),
                       textColor: Colors.white,
                       color: Colors.blue[900],
                       padding: EdgeInsets.all(10),
                       onPressed: (){
                      
                       },
                     )
                   ),
                   SizedBox(
                     width: 200,
                     child:RaisedButton(
                       child: Row(
                         children:<Widget>[
                           Icon(Icons.toys,size: 25),
                           Text(
                             'Sign up with Google',
                             style: TextStyle(fontSize: 15),
                           ),
                         ],
                       ),
                       textColor: Colors.black,
                       color: Colors.white,
                       padding: EdgeInsets.all(10),
                       onPressed: (){
                      
                       },
                     )
                   ),
                 ],) ,
               ),
           ),
          ),
        ),
      ),
    );
  }
   
    
    
}

class FirebaseAuth {
  static var instance;
}
