import 'package:flutter/material.dart';

class CustomTextField {
  final String title;
  final String placeholder;
  final bool ispass;
  final int line;
  String initialValue;
  String err;
  String _value;
  CustomTextField({this.title="", this.placeholder="", this.ispass=false, this.err="Veuillez remplir ce champ", this.initialValue, this.line=1});
  TextEditingController controller = new TextEditingController();
  int i =0;
  TextFormField textFormField(){
    i++;
    if(i==1){
      controller.text = initialValue;
      _value = initialValue;
    }
    return TextFormField(
      controller: controller,
      maxLines: this.line,
      onChanged: (e){
        _value = e;
      },
      validator: (e)=>e.isEmpty?this.err:null,
      obscureText: this.ispass,
      decoration: InputDecoration(
        hintText: this.placeholder,
        labelText: this.title,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
           color: Colors.green
          ),
        ),
      ),
    );
  }
  String get value{
    return _value;
  }
}