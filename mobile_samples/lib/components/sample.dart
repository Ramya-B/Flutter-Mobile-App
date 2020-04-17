import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_forms/dynamic_forms.dart';
import 'package:flutter_dynamic_forms/flutter_dynamic_forms.dart';
import 'package:flutter_dynamic_forms_components/flutter_dynamic_forms_components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimpleFormScreen extends StatefulWidget {
  _SimpleFormScreenState createState() => _SimpleFormScreenState();
}

class _SimpleFormScreenState extends State<SimpleFormScreen> {
  FormRenderService _formRenderService;
  FormManager _formManager;
  FormElement _form;
  
  getJsonFromMongo() async{
     SharedPreferences prefs =  await SharedPreferences.getInstance();
     return await http
        .get(
      'http://192.168.60.38:9400/api/cities/flutter/test',
    headers: {HttpHeaders.authorizationHeader: 'Bearer ${prefs.getString("token")}' , 'Content-type': 'application/json; charset=UTF-8'},
     
    )
        .then((data) {
      if (data.statusCode == 200) {
        var res = json.decode(data.body);
        print("getCitiesByCountryCodes came....");
        print(res);
        return res;
      } else {
        return throw Exception('falied to  getCitiesByCountryCodes....');
      }
    });

  }

  @override
  void initState() {
    super.initState();
    _buildForm();
  }

  Future _buildForm() async {
    var parsers = getDefaultParserList(); //Add your custom parsers
    var renderers = getReactiveRenderers(); //Add your custom renderers
    _formRenderService = FormRenderService(
      renderers: renderers,
      dispatcher: _onFormElementEvent,
    );

    //Use JsonFormParserService for the JSON format
    var formManagerBuilder = FormManagerBuilder(XmlFormParserService(parsers));
    var content = await rootBundle.loadString('assets/test_form1.xml'); //Load your form
    _formManager = formManagerBuilder.build(content);
    setState(() {
      _form = _formManager.form;
    });
  }

  //All the events from the form will end up here
  void _onFormElementEvent(FormElementEvent event) {
    print("change event called...and event is...!");
    List<FormItemValue> data = _formManager.getFormData();
    for (var item in data) {
      print("loops..");
      print(item.name);
       print(item.value);
       print(item.property);
    }
    
    
    if (event is ChangeValueEvent) {
      print('ChangeValueEvent...!');
      print(event.elementId);
    print(event.value);
    print(event.propertyName);
      _formManager.changeValue(
          value: event.value,
          elementId: event.elementId,
          propertyName: event.propertyName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: _form == null
              ? CircularProgressIndicator()
              : _formRenderService.render(_form, context),
        ),
      ),
    );
  }
}