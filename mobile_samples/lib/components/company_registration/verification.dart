import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:tradeleaves/components/company_settings/companysettings.dart';
import 'package:tradeleaves/constants.dart';
import 'package:tradeleaves/models/identificationAttributesList.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import '../../service_locator.dart';
import 'package:tradeleaves/models/identificationGroups.dart';
import 'package:tradeleaves/models/identificationTypeDTOList.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';

class VerficationPage extends StatefulWidget {
  @override
  _VerficationPageState createState() => _VerficationPageState();
}

class _VerficationPageState extends State<VerficationPage> {
  IdentificationAttributesList identyType;
  IdentificationAttributesList ownerIdentyType;
  String type;
  int groupId = 1;
  int selectedRadioTile;
  int selectedRadio;
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  List<IdentificationGroups> identificationGroupList;
  List<IdentificationAttributesList> identificationAttributesList = [];
  List<IdentificationTypeDTOList> identificationDocuments =[];
  List<IdentificationAttributes> postIdentificationAttributes = [];
  User user;
  UserServiceImpl get userService => locator<UserServiceImpl>();
  OwnerParty ownerParty = new OwnerParty();
  Company company = new Company();
  Telephone telephoneDTO = new Telephone();
  Email emailContactDTO = new Email();
  String name = '';
  String email = '';
  OwnerAndRoleDTO ownerAndRoleDTO = new OwnerAndRoleDTO();
  getIdentificationGroups(int groupId) async {
    print('getIdentificationGroups called.....');
    var res = await crmService.getIdentificationGroyp(groupId);
    print("getIdentificationGroups response object {}...........");
    print(res);
    setState(() {
      this.identificationGroupList = List<IdentificationGroups>.from(
          res.map((i) => IdentificationGroups.fromJson(i)));
      print("identification documents");
      print(json.encode(this.identificationGroupList));


//      for(IdentificationGroups groups in this.identificationGroupList){
      for(IdentificationTypeDTOList types in this.identificationGroupList[0].identificationTypeDTOList){
        if (types.identificationFieldsList[0].type == 'Attachment') {
          print("matched if");
          print(types.identificationTypeName);
          print(types.identificationFieldsList[0].type);
          IdentificationAttributesList identificationAttributes = new IdentificationAttributesList();
          identificationAttributes.attributeName = types.identificationTypeName;
          identificationAttributes.attributeType = types.identificationFieldsList[0].type;
          identificationAttributes.attributeValidation = types.identificationFieldsList[0].validation;
          if(types.identificationFieldsList[0].required == "Y"){
            identificationAttributes.isRequired = true;
          }else{
            identificationAttributes.isRequired = false;
          }
          identificationAttributes.anyOneFilled = true; // Require one from many fields
          identificationAttributes.identificationTypeId = types.identificationTypeId;
          identificationAttributesList.add(identificationAttributes);
          print("identification attributes");
          print(jsonEncode(identificationAttributesList));

        }
      }
      print("identificationAttributesList printed");
      print(identificationAttributesList);
      print(jsonEncode(identificationAttributesList));
      getCompanyDetails();

    });
  }

  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    setState(() {
      this.user = User.fromJson(data);
    });
  }
  getCompanyDetails() async{
    var res = await crmService.getCompanyDetails();
    CompanyRegisterResp companyRegisterResp = CompanyRegisterResp.fromJson(res);
    print(companyRegisterResp);
    company = companyRegisterResp.company;
    if (company.ownerAndRoleDTO != null && company.ownerAndRoleDTO.length > 0) {
      name = company.ownerAndRoleDTO[0].ownerParty.firstName;
      if (company.ownerAndRoleDTO[0].ownerParty.middleName != null){
        name = name + ' ' + company.ownerAndRoleDTO[0].ownerParty.middleName;

      }
      if (company.ownerAndRoleDTO[0].ownerParty.lastName != null){
        name = name + ' ' + company.ownerAndRoleDTO[0].ownerParty.lastName;
      }
      if (company.ownerAndRoleDTO[0]!=null && company.ownerAndRoleDTO[0].emailContactDTO!=null && company.ownerAndRoleDTO[0].emailContactDTO.emailAddress!=null) {
         email = company.ownerAndRoleDTO[0].emailContactDTO.emailAddress;
      }
      ownerParty = company.ownerAndRoleDTO[0].ownerParty;
      if (company.ownerAndRoleDTO[0].telephoneDTO!=null) {
        telephoneDTO = company.ownerAndRoleDTO[0].telephoneDTO;
      }
      if (company.ownerAndRoleDTO[0].emailContactDTO!=null) {
        emailContactDTO = company.ownerAndRoleDTO[0].emailContactDTO;
      }
      if (ownerParty.partyId == user.partyId) {
        selectedRadioTile= 1;
        print('Found Authorization');
      } else {
        selectedRadioTile = 2;
        print('Found IDENTIFICATION');

      }
    }

    if(company.partyIdentificationDTO!=null && company.partyIdentificationDTO.identificationAttributes!=null && company.partyIdentificationDTO.identificationAttributes.length>0){
          for(IdentificationAttributes attributes in company.partyIdentificationDTO.identificationAttributes){
            print("fst for loop");
            for(IdentificationTypeDTOList types in this.identificationGroupList[0].identificationTypeDTOList){
              print("secod for loop");
              print(types.identificationFieldsList[0].type);
              print(types.identificationTypeName);
              print(attributes.attributeName);
                  if(types.identificationFieldsList[0].type == 'Attachment' && types.identificationTypeName == attributes.attributeName && attributes.attributeValue!=null){
                    print("matched the if");
                    IdentificationTypeDTOList identificationDocument = new  IdentificationTypeDTOList();
                    identificationDocument.attributeName = attributes.attributeName;
                    identificationDocument.attributeValue = attributes.attributeValue;
                    identificationDocument.attributeType = types.attributeType;
                    var nameSplit = [];
                    nameSplit = attributes.attributeValue.split('/');
                    if (nameSplit!=null && nameSplit.length > 1) {
                      identificationDocument.attributeNameWithOutBucketName = nameSplit[1];
                    }
                    identificationDocument.identificationGroupId = attributes.identificationGroupId;
                    identificationDocument.identificationTypeId = attributes.identificationTypeId;
                    identificationDocument.identificationTypeName = types.identificationTypeName;
                    identificationDocuments.add(identificationDocument);
                  }
            }
            if (attributes.attributeName == 'Authorization Letter') {
              print("matched the authorization");
              IdentificationTypeDTOList identificationDocument = new IdentificationTypeDTOList();
              identificationDocument.attributeName = attributes.attributeName;
              identificationDocument.attributeValue = attributes.attributeValue;
              identificationDocument.attributeType = 'Attachment';
              var nameSplit = [];
              nameSplit = attributes.attributeValue.split('/');
              if (nameSplit != null && nameSplit.length > 1) {
                identificationDocument.attributeNameWithOutBucketName = nameSplit[1];
              }
              identificationDocument.identificationGroupId = attributes.identificationGroupId;
              identificationDocument.identificationTypeId = attributes.identificationTypeId;
              identificationDocument.identificationTypeName = attributes.attributeName;
              identificationDocuments.add(identificationDocument);
              break;
            }
          }

          print("printing identification documents");
          print(jsonEncode(identificationDocuments));
    }
  }
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    getIdentificationGroups(groupId);
    getUserInfo();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  setAuthorizationFile() async{
    print("setAuthorizationFile called");
    var resultList = 
     await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    ); 
    /* await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    ); */
    for (var imageFile in resultList) {
      uploadImage(imageFile, resultList.length).then((fileResp) {
        // Get the download URL
        setState(() {
          print("uploadImage resp");
          print(fileResp);
          IdentificationTypeDTOList identificationDocument = new IdentificationTypeDTOList();

          identificationDocument.identificationTypeName= "Authorization Letter";
          identificationDocument.attributeName =  "Authorization Letter";
          identificationDocument.attributeType =  "Attachment";
          identificationDocument.attributeValue = json.decode(fileResp)["fileName"];
          var nameSplit = [];
          nameSplit = json.decode(fileResp)["fileName"].split('/');
          if (nameSplit!=null && nameSplit.length > 1) {
            identificationDocument.attributeNameWithOutBucketName = nameSplit[1];
          }
          identificationDocuments.add(identificationDocument);
        });
      }).catchError((err) {
        print(err);
      });
    }
  }

  _uploadFileList() async{
    print("_uploadFileList called");
    var resultList = 
    await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    /* await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
    ); */
    print("printing the uploaded images");
    print(resultList);
    for (var imageFile in resultList) {
      uploadImage(imageFile, resultList.length).then((fileResp) {
        // Get the download URL
        setState(() {
          print("uploadImage resp");
          print(fileResp);
          IdentificationTypeDTOList identificationDocument = new IdentificationTypeDTOList();
          for (IdentificationTypeDTOList types in this.identificationGroupList[0].identificationTypeDTOList) {
            print('identification document before elseif');
            print(types);
            print(json.encode(ownerIdentyType));
            print(json.encode(types));
            print(types.attributeType);
            if (ownerIdentyType != null &&  types.identificationTypeName == ownerIdentyType.attributeName && ownerIdentyType.attributeType!=null) {
              identificationDocument = types;
              identificationDocument.attributeName = types.identificationTypeName;
              identificationDocument.attributeValue = json.decode(fileResp)["fileName"];
              identificationDocument.attributeType = ownerIdentyType.attributeType;
              var nameSplit = [];
              nameSplit = json.decode(fileResp)["fileName"].split('/');
              if (nameSplit!=null && nameSplit.length > 1) {
                identificationDocument.attributeNameWithOutBucketName = nameSplit[1];
              }
              identificationDocuments.add(identificationDocument);
            }

          }
        });
      }).catchError((err) {
        print(err);
      });
    }
  }


  deleteIdentificationDocuments(element, index) async{
      print("deleteIdentificationDocuments calle");
      print(jsonEncode(element));
      print(index);
      if(element.identificationGroupId!=null){
        PartyIdentificationDTO partyIdentificationDTOObject = new PartyIdentificationDTO();
        partyIdentificationDTOObject.partyId = user.companyId;
        partyIdentificationDTOObject.identificationAttributes = [];
        IdentificationAttributes postAttributes = new IdentificationAttributes();
        postAttributes.attributeName = element.attributeName;
        postAttributes.attributeValue = element.attributeValue;
        postAttributes.identificationTypeId = element.identificationTypeId;
        postAttributes.identificationGroupId = element.identificationGroupId;
        partyIdentificationDTOObject.identificationAttributes.add(postAttributes);
        identificationDocuments.removeAt(index);
        var identificationResponse = await crmService.deleteIdentificationDocuments(partyIdentificationDTOObject);
        print("printing the documents");
        print(identificationResponse);
//        print(jsonEncode(identificationDocuments.removeAt(index)));
//        this.identificationDocuments = identificationDocuments.removeAt(index);
        print(identificationDocuments.length);
        print(jsonEncode(identificationDocuments));
      }else{
//        identificationDocuments.removeWhere(element);
        identificationDocuments.removeAt(index);

      }
  }
  Future<dynamic> uploadImage( imageFile, int length) async {
    print("image file");
    print(jsonEncode(imageFile.identifier));  var path = await FlutterAbsolutePath.getAbsolutePath(imageFile.identifier);
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              "${Constants.envUrl}/mongoupload/attachments/?Override=false"));
      print("multipart fiile");
      print(request);
      request.files.add(await http.MultipartFile.fromPath(
        'attachments',
        path,
        contentType: mime.MediaType('image', 'jpg'),
      ));

      print("request is...!");
      print(request);
      var res = await request.send();
      final respStr = await res.stream.bytesToString();
      print("image upload ...");
      print(respStr);
      return respStr;
    }

  performStartVerify(company) async{
    print("performStartVerify called");
    var response = await crmService.performStartVerify(company);
    print(response);
     Navigator.push(
         context, MaterialPageRoute(builder: (context) => CompanySettings()));

  }
    saveCompanyVerification() async{
      print("saveCompanyVerification called");
      PartyIdentificationDTO partyIdentificationDTO = new PartyIdentificationDTO();
      OwnerParty userAsOwner = new OwnerParty();
      userAsOwner.partyId = user.partyId;
      ownerAndRoleDTO.ownerParty = userAsOwner;
      partyIdentificationDTO.partyId = user.companyId;

      if(selectedRadioTile == 1){
        ownerAndRoleDTO.telephoneDTO = null;
        ownerAndRoleDTO.emailContactDTO = null;
        ownerAndRoleDTO.roleDTO = null;
      }
      if(selectedRadioTile== 2){
        var nameSplit = [];
        var fullname = name;
        nameSplit = fullname.split(' ');
        var firstName = nameSplit[0];
        var middleName = "";
        var lastName = "";
        if (nameSplit.length > 1) {
          lastName = nameSplit[nameSplit.length - 1];
          if (nameSplit.length > 2) {
            var middle = [];
            for (var i = 1; i < nameSplit.length - 1; i++) {
              middle.add(nameSplit[i]);
            }
            middleName = middle.join(' ');
          }
        }
        ownerParty.firstName = firstName;
        ownerParty.lastName = lastName;
        ownerParty.middleName = middleName;
        ownerAndRoleDTO.telephoneDTO = telephoneDTO;
        ownerAndRoleDTO.emailContactDTO = emailContactDTO;
        if (ownerParty.partyId != null && ownerParty.partyId == user.partyId) {
          if (telephoneDTO.contactNumber != null) {
            telephoneDTO.id = null;
          }
          if (emailContactDTO.emailAddress != null) {
            emailContactDTO.id = null;
          }
        }

      }
      var response = await crmService.createOwnerAndRole(ownerAndRoleDTO);
      print("response of create owner and role service");
      print(response);
      print(identificationDocuments.length);
      postIdentificationAttributes = [];
      for (IdentificationTypeDTOList attributes in identificationDocuments) {
        IdentificationAttributes postAttributes = new IdentificationAttributes();
        postAttributes.attributeName = attributes.attributeName;
        postAttributes.attributeValue = attributes.attributeValue;
        postAttributes.identificationTypeId = attributes.identificationTypeId;
        postAttributes.identificationGroupId = attributes.identificationGroupId!=null ? attributes.identificationGroupId : null;
        postIdentificationAttributes.add(postAttributes);
      }
      partyIdentificationDTO.identificationAttributes = postIdentificationAttributes;
      var identificationResponse = await crmService.createCompanyIdentification(partyIdentificationDTO);
      print("create identification attributes response");
      print(identificationResponse);
      performStartVerify(company);
    }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'To verify your company we need you to provide some documents.',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Verification is an important part of the TradeLeaves experience. It’s your assurance that you’re doing business with legitimate business entities. To verify your business, we’ll need some basic business information, along with business documents corresponding to your type of business. Please have these documents available beforehand to speed up your registration process.',
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "What's your role in the company?",
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("What's your primary business activity?"),
                ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: RadioListTile(
                    activeColor: Colors.green,
                    groupValue: selectedRadioTile,
                    dense: true,
                    title: Text(
                        "I am an owner, director, administrator or other senior officer."),
                    subtitle: Text(
                        'Please provide a valid document showing that you are the owner of this business.'),
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        setSelectedRadioTile(value);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
                ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: RadioListTile(
                    activeColor: Colors.green,
                    groupValue: selectedRadioTile,
                    dense: true,
                    title: Text(
                        "I am an authorized member of the companies staff."),
                    subtitle: Text(
                        'Please provide a letter, on company letterhead, authorizing you to perform these actions, signed by an owner, director, CEO or CFO of the company.'),
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        setSelectedRadioTile(value);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.black,
        ),
        SizedBox(
          height: 20,
        ),
        //First CheckBox
        (selectedRadioTile == 1)
            ? Card(
                child: Container(
                    child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                    ),
                    Text(
                      'Verification Document Required',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Personal Identication',
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Please upload one of the following required documents.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text('Type'),
                              SizedBox(
                                height: 8,
                              ),
                              DropdownButton(
                                hint: ownerIdentyType == null
                                    ? Text('Type')
                                    : Text(
                                  ownerIdentyType.attributeName,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                items: identificationAttributesList.map(
                                  (val) {
                                    return DropdownMenuItem<IdentificationAttributesList>(
                                      value: val,
                                      child: Text(val.attributeName),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                   FocusScope.of(context).requestFocus(FocusNode());
                                  setState(
                                    () {
                                      print("öwner identity file name");
                                      print(val);
                                      ownerIdentyType = val;
                                    },
                                  );
                                },
                              )
                              // TextFormField(
                              //   decoration: InputDecoration(
                              //     contentPadding:
                              //         EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              //     hintText: "Password",
                              //     border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5)),
                              //   ),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                              child: Container(
                            child: RaisedButton(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: Colors.green, width: 1)),
                              onPressed: () {
                                _uploadFileList(); // 2
                              },
                              child: Text(
                                'Attach',
                                style: TextStyle(color: Colors.green[900]),
                              ),
                              color: Colors.white,
                              padding: EdgeInsets.only(left: 30, right: 30),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
              )
            :
            // Second CheckBox
            (selectedRadioTile == 2)
                ? Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Owner Information',
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Name'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            initialValue: name!=null? name : null,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('Email'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            initialValue:emailContactDTO.emailAddress!=null? emailContactDTO.emailAddress
                                : this.user.personalDetails.profile.email[0].emailAddress,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('Contact Number'),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            initialValue:telephoneDTO.contactNumber!=null? telephoneDTO.contactNumber
                                : null,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                              hintText: "Enter owner contact number",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                            ),
                            Text(
                              'Verification Document Required',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Company Authorization',
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'To confirm your identity as an officer or authorized representative, select a document type and attach supporting file here.',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text('Type'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      DropdownButton(
                                        hint: identyType == null
                                            ? Text('Type')
                                            : Text(
                                                identyType.attributeName,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        items: identificationAttributesList.map(
                                              (val) {
                                            return DropdownMenuItem<IdentificationAttributesList>(
                                              value: val,
                                              child: Text(val.attributeName),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                           FocusScope.of(context).requestFocus(FocusNode());
                                          setState(
                                            () {
                                              identyType = val;
                                            },
                                          );
                                        },
                                      )
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.fromLTRB(
                                      //         20.0, 5.0, 20.0, 5.0),
                                      //     hintText: "Password",
                                      //     border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Container(
                                    child: RaisedButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 1)),
                                      onPressed: () {
                                        _uploadFileList();//3
                                      },
                                      child: Text(
                                        'Attach',
                                        style:
                                            TextStyle(color: Colors.green[900]),
                                      ),
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text('Type'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      DropdownButton(
                                        hint: type == null
                                            ? Text('Type')
                                            : Text(
                                                type,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                        isExpanded: true,
                                        iconSize: 30.0,
                                        items: [
                                          'Authorization Letter',
                                        ].map(
                                          (val) {
                                            return DropdownMenuItem<String>(
                                              value: val,
                                              child: Text(val),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (val) {
                                           FocusScope.of(context).requestFocus(FocusNode());
                                          setState(
                                            () {
                                              type = val;
                                            },
                                          );
                                        },
                                      )
                                      // TextFormField(
                                      //   decoration: InputDecoration(
                                      //     contentPadding: EdgeInsets.fromLTRB(
                                      //         20.0, 5.0, 20.0, 5.0),
                                      //     hintText: "Authorization Letter",
                                      //     border: OutlineInputBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(5)),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                      child: Container(
                                    // alignment: Alignment.center,
                                    child: RaisedButton(
                                      shape: StadiumBorder(
                                          side: BorderSide(
                                              color: Colors.green, width: 1)),
                                      onPressed: () {
                                        setAuthorizationFile();//1
                                      },
                                      child: Text(
                                        'Attach',
                                        style:
                                            TextStyle(color: Colors.green[900]),
                                      ),
                                      color: Colors.white,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                : Container(),
        Divider(
          color: Colors.black,
        ),
//    Container(
        identificationDocuments!=null && identificationDocuments.length>0 ? DataTable(
            dataRowHeight: 30,
            headingRowHeight: 30,
            columnSpacing: 20,
        columns: [
    DataColumn(label: Expanded(child: Text('File Name'))),
    DataColumn(label: Expanded(child: Text('Verification Type'))),
    DataColumn(label: Text('Action')),
    ],
    rows:
    identificationDocuments!=null && identificationDocuments.length>0 ? // Loops through dataColumnText, each iteration assigning the value to element
    identificationDocuments.asMap()
    .map(
    ((i,element) => MapEntry(i,DataRow(
    cells: <DataCell>[
      DataCell(
          Container(
              width: 100, //SET width
              child: Text(element.attributeNameWithOutBucketName))),
      DataCell(
          Container(
              width: 100, //SET width
              child: Text(element.attributeName))),//Extracting from Map element the value
    DataCell(
      InkWell(
      child: Text(
        'Delete',
        style: TextStyle(color: Colors.red),
      ),
      onTap: () {
        setState(() {
          deleteIdentificationDocuments(element,i);
        });
      },
    ),),
    ],
    )
    )),
    ).values.toList() :
    [],
    ): Container(),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
//              InkWell(
//                child: Text(
//                  'Skip this step',
//                  style: TextStyle(color: Colors.green),
//                ),
//                onTap: () {},
//              ),
//              SizedBox(
//                width: 15,
//              ),
//              RaisedButton(
//                color: Colors.lightGreen,
//                onPressed: () {},
//                child: Text(
//                  'Save & Exit',
//                  style: TextStyle(color: Colors.white),
//                ),
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(20)),
//              ),
              SizedBox(
                width: 15,
              ),
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {
                  saveCompanyVerification();
                },
                child: Text(
                  'Create Company',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )
            ],
          ),
        )
      ],
    );
  }
}
