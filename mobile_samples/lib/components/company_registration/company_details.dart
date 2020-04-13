import 'dart:convert';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/models/IdentityNumberAttributesList.dart';
import 'package:tradeleaves/models/classificationGroupAttributeDTOResp.dart';
import 'package:tradeleaves/models/companyType.dart';
import 'package:tradeleaves/models/country.dart';
import 'package:tradeleaves/models/identificationGroups.dart';
import 'package:tradeleaves/models/identificationTypeDTOList.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/industryType.dart';
import 'package:tradeleaves/models/states.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/tl-services/customs/customServiceImpl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../../service_locator.dart';

class CompanyDetails extends StatefulWidget {
  @override
  _CompanyDetailsState createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  bool isChecked = false;
  CompanyType companyType;
  IndustryType industryType;
  String state;
  String siteId = "1152f6df-91cf-4fc2-afa7-2baa63ef5429";
  int groupId = 1;
  String name = "India";
  bool isActive = true;
  User user;
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  CustomServiceImpl get customService => locator<CustomServiceImpl>();
  UserServiceImpl get userService => locator<UserServiceImpl>();
  ClassificationGroupAttributeDTOResp businessTypeList;
  List<CompanyType> companyTypeList;
  List<IdentificationGroups> identificationGroupList;
  List<Country> countryList;
  List<IndustryType> industryTypeList;
  List<States> statesList;
  Company company = new Company();
  Details details = new Details();
  Telephone telephone = new Telephone();
  Address address = new Address();
  AccountStatus accountStatus= new AccountStatus();
  Email email = new Email();
  PartyIdentificationDTO partyIdentificationDTO = new PartyIdentificationDTO();
  List<ProfileAttribute> profileAttribute = [];
  List<IdentificationAttributes> identificationAttributes = [];
  States states;
  String businessAttributes;
  var businessTypes;
  var identityValue;
  List selectedBusinessTypes;
  List<IdentificationAttributesList> identificationAttributesList = [];
  IdentificationAttributesList identityType;
  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    setState(() {
      this.user = User.fromJson(data);
    });
  }

  getStates() async {
    print('getStates called.....');
    var res = await crmService.getStates(name, isActive);
    print("getStates response object {}...........");
    print(res);
    setState(() {
      this.statesList = List<States>.from(res.map((i) => States.fromJson(i)));
    });
  }

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
          if (types.identificationFieldsList[0].type != 'Attachment') {
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
//            if(identificationAttributesList.length>0){
//              print("printed las if in attributes");
//              for(IdentificationAttributesList attTypes in identificationAttributesList){
//                  if(attTypes.attributeName != types.identificationTypeName){
//                    identificationAttributesList.add(identificationAttributes);
//                    print("list pushed in if");
////                    break;
//                  }
//              }
//            }else{
//              print("list pushed in else");
//              identificationAttributesList.add(identificationAttributes);
//            }
            identificationAttributesList.add(identificationAttributes);
            print("identification attributes");
            print(jsonEncode(identificationAttributesList));

          }
        }
//      }
      print("identificationAttributesList printed");
      print(identificationAttributesList);
      print(jsonEncode(identificationAttributesList));

    });
  }

  defaultCountry() async {
    print('defaultCountry called.....');
    var res = await customService.countryCodes();
    print("defaultCountry response object {}...........");
    print(res);
    setState(() {
      this.countryList =
          List<Country>.from(res.map((i) => Country.fromJson(i)));
    });
  }

  getCompanyTypes(String siteId) async {
    print('getCompanyTypes called.....');
    var res = await crmService.companyTypes(siteId);
    print("getCompanyTypes response object {}...........");
    print(res);
    setState(() {
      this.companyTypeList =
          List<CompanyType>.from(res.map((i) => CompanyType.fromJson(i)));
    });
  }

  Map<String, bool> values = {
    'Buying': false,
    'Selling': false,
    'Service Provider': false,
  };

  getBusinessTypes() async {
    print('getBusinessTypes called.....');
//    var response = await crmService.businessType();
    businessTypes = await crmService.businessType();
    this.businessTypeList =
        ClassificationGroupAttributeDTOResp.fromJson(businessTypes);
    print("getBusinessTypes response object {}...........");
    print(businessTypes);
    setState(() {
      this.businessTypeList =
          ClassificationGroupAttributeDTOResp.fromJson(businessTypes);
    });
  }

  getIndustryTypes(String siteId) async {
    print('getIndustryTypes called.....');
    var res = await crmService.industryType(siteId);
    print("getIndustryTypes response object {}...........");
    print(res);
    setState(() {
      this.industryTypeList =
          List<IndustryType>.from(res.map((i) => IndustryType.fromJson(i)));
    });
    getCompanyDetails();
  }
  getCompanyDetails() async{
    print("getCompanyDetails called");
    var res = await crmService.getCompanyDetails();
    print("getCompanyDetails response object ...........");
    print(res);
//    company = res.company;
    setState(() {
      CompanyRegisterResp companyRegisterResp = CompanyRegisterResp.fromJson(res);
      print(companyRegisterResp);
      company = companyRegisterResp.company;
      print("printing company object");
      print(this.company);
      details = company.details;
      if(company.email!=null){
        email = company.email;
      }
      if(company.address!=null){
        address = company.address;
      }
      if(company.details!=null){
        details = company.details;
      }
      if(company.partyIdentificationDTO!=null){
        partyIdentificationDTO = company.partyIdentificationDTO;
      }
      for(States state in statesList){
        if(state.name == address.state){
          this.states = state;
        }
      }
      if(company.profileAttribute.length>0){
        print("1st if called");
        for(ProfileAttribute types in company.profileAttribute){
          print("1st for called");
          if(types.attrName == "COMPANY_TYPE"){
            for(CompanyType companyTypes in companyTypeList){
              if(companyTypes.companyTypeId == types.attrValue){
                companyType = companyTypes;
              }
            }
          }
          if(types.attrName == "INDUSTRY"){
            for(IndustryType industryTypes in industryTypeList){
              if(industryTypes.industryId == types.attrValue){
                industryType = industryTypes;
              }
            }
          }
          if(types.attrName == "BUSINESS_TYPE"){
            selectedBusinessTypes = types.attrValue.split(",");
            print("Selected businesstypes");
            print(selectedBusinessTypes);
          }

        }
      }
      print("identificationAttributesLists");
      print(jsonEncode(identificationAttributesList));
      if(company.partyIdentificationDTO.identificationAttributes.length>0){
        print("inside if");
//        print();
          for(IdentificationAttributes attributes in company.partyIdentificationDTO.identificationAttributes){
                if(attributes.attributeValue!=null){
                    identityValue = attributes.attributeValue;
                }
                for(IdentificationAttributesList groupValues in identificationAttributesList){
                  print("inside for");
                  print(attributes.attributeName);
                  print(groupValues.attributeName);
                  if(groupValues.attributeName == attributes.attributeName){
                    groupValues.identificationGroupId = attributes.identificationGroupId;
                  }
                }
          }

      }

    });
  }

  @override
  void initState() {
    statesList = [];
    countryList = [];
    identificationGroupList = [];
    companyTypeList = [];
    industryTypeList = [];
    getUserInfo();
    print("Before Calling defaultCountry--**--**--**");
    defaultCountry();
    print("After Calling defaultCountry--**--**--**");
    print("Before Calling getCompanyTypes.................");
    getCompanyTypes(siteId);
    print("After Calling getCompanyTypes.................");
    print("Before Calling getBusinessTypes *********");
    getBusinessTypes();
    print("After Calling getBusinessTypes ***********");
    print("Before Calling getIndustryTypes =========");
    getIndustryTypes(siteId);
    print("After Calling getIndustryTypes ==========");
    print("Before Calling getIdentificationGroups ----------------");
    getIdentificationGroups(groupId);
    print("After Calling getIdentificationGroups ----------------");
    print("Before Calling getStates ----------------");
    getStates();
    print("After Calling getStates ----------------");

    super.initState();
  }



  saveCompanyDetails() async{
    print("save company details called");
    telephone.verified = 'N';
    address.verified = "N";
    address.country = "India";
    email.verified = "N";
    details.partyId = this.user.companyId;
    partyIdentificationDTO.partyId = this.user.companyId;
    identificationAttributes = [];
    IdentificationAttributes identificationFieldAttributes = new IdentificationAttributes();
    identificationFieldAttributes.attributeName = identityType.attributeName;
    identificationFieldAttributes.attributeValue= identityValue;
    identificationFieldAttributes.identificationTypeId= identityType.identificationTypeId;
    identificationFieldAttributes.identificationGroupId = identityType.identificationGroupId;
    identificationAttributes.add(identificationFieldAttributes);
    print(jsonEncode(identificationAttributes));
    print("identirty areve");
    partyIdentificationDTO.identificationAttributes = identificationAttributes;
//    details.groupName = this.user.companyId;
    details.countryCode = "IN";
    details.lobId = "34343e34-7601-40de-878d-01b3bd1f0642";
    company.channel="B2BInternational";
    company.lobId="34343e34-7601-40de-878d-01b3bd1f0641";
    company.countryCode= "IN";
    company.details = details;
    company.telephone = telephone;
    company.address = address;
    profileAttribute = [];
    company.email = email;
    company.status = 'N';
    if(this.industryType !=null){
      ProfileAttribute object = new ProfileAttribute();
      object.attrName = 'INDUSTRY';
      object.attrValue = this.industryType.industryId;
      object.attributeNameForES = this.industryType.name;
      profileAttribute.add(object);
    }
    if(this.companyType !=null){
      ProfileAttribute object = new ProfileAttribute();
      object.attrName = 'COMPANY_TYPE';
      object.attrValue = this.companyType.companyTypeId;
      object.attributeNameForES = this.companyType.name;
      profileAttribute.add(object);
    }
    if(selectedBusinessTypes!=null){
      ProfileAttribute object = new ProfileAttribute();
      object.attrName = 'BUSINESS_TYPE';
      object.attrValue = selectedBusinessTypes.join(",");
      print("business types");
      profileAttribute.add(object);
    }
    print(profileAttribute);
    print(profileAttribute.toList());
    company.profileAttribute = profileAttribute;
    company.partyIdentificationDTO = partyIdentificationDTO;
    print(jsonEncode(company));
    print("printing the object");
    var response = await crmService.saveCompanyDetails(company);
    print("RESPONSE PRINTED");
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Name'),
            SizedBox(
              height: 8,
            ),
//            details.groupName!=null ?
            TextFormField(
              initialValue: details.groupName,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "This is your leagally registered name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (String value){
                setState(() {
                  print(details.groupName);
                  print("group name");
                  details.groupName = value;
                });
              },
            ),
//        : Container(),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Trading/Public/DBA Name'),
            SizedBox(
              height: 8,
            ),
//            details.groupNameLocal!=null ?
            TextFormField(
              initialValue: details.groupNameLocal,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Trading/Public Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (String value){
                setState(() {
                  details.groupNameLocal = value;
                });
              },
            ),
//                : Container()
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Address'),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Column(
                children: <Widget>[
//                  address.address1!=null ?
                  TextFormField(
                    initialValue: address.address1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address1",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value){
                      setState(() {
                        address.address1 = value;
                      });
                    },
                  ),
//                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
//                  address.address2 !=null ?
                  TextFormField(
                    initialValue: address.address2,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address2",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value){
                      setState(() {
                        address.address2 = value;
                      });
                    },
                  )  ,
//                      :Container(),
                  SizedBox(
                    height: 5,
                  ),
//                  address.city!=null ?
                  TextFormField(
                    initialValue: address.city,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "City/Town",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value){
                      setState(() {
                        address.city = value;
                      });
                    },
                  ),
//                      : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    initialValue:
                        (this.user != null && this.user.appsite == 'IN')
                            ? 'India'
                            : 'USA',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),

                  ),
                  SizedBox(
                    height: 5,
                  ),
                  this.statesList.length > 0
                      ? Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              DropdownButton(
                                hint: state == null
                                    ? Text('State')
                                    : Text(
                                        state,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                isExpanded: true,
                                value: states ,
                                iconSize: 30.0,
                                items: this.statesList.map(
                                  (val) {
                                    return DropdownMenuItem<States>(
                                      value: val,
                                      child: Text(
                                        val.name,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      states = val;
                                      address.state = val.name;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      : Container(),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  //     hintText: "State",
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5)),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
//                  address.postalcode!=null ?
                  TextFormField(
                    initialValue: address.postalcode,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Pin Code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                      onChanged: (String value){
                        setState(() {
                          address.postalcode = value;
                        });
                      },

                  ),
//                      : Container(),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        this.companyTypeList.length > 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Company Type'),
                  DropdownButton(
                    hint: companyType == null
                        ? Text('Company type')
                        : Text(
                            this.companyType.name,
                            style: TextStyle(fontSize: 15),
                          ),
                    value: companyType,
                    isExpanded: true,
                    iconSize: 30.0,
                    items: this.companyTypeList.map(
                      (val) {
                        return DropdownMenuItem<CompanyType>(
                          value: val,
                          child: Text(
                            val.name,
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                        () {
                          this.companyType = val;
                        },
                      );
                    },
                  )
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                  //     hintText: "Company Type",
                  //     border:
                  //         OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  //   ),
                  // )
                ],
              )
            : Container(),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Primary Industry/Market'),
            SizedBox(
              height: 8,
            ),
            DropdownButton(
              hint: industryType == null
                  ? Text('Primary industry')
                  : Text(
                      this.industryType.name,
                      style: TextStyle(fontSize: 15),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              items: this.industryTypeList.map(
                (val) {
                  return DropdownMenuItem<IndustryType>(
                    value: val,
                    child: Text(val.name),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    print("industry type");
                    print(val);
                    this.industryType = val;
                  },
                );
              },
            )
            // TextFormField(
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            //     hintText: "Primary Industry",
            //     border:
            //         OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            //   ),
            // )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: MultiSelectFormField(
            autovalidate: false,
            titleText: 'Primary Industry',
            validator: (value) {
              if (value == null || value.length == 0) {
                return 'Please select one or more options';
              }
              return null;
            },
            dataSource: businessTypes["classificationGroupAttributeDTO"],
            textField: 'attributeName',
            valueField: 'attributeName',
            okButtonLabel: 'OK',
            cancelButtonLabel: 'CANCEL',
            // required: true,
            hintText: 'Please choose one or more',
            value: selectedBusinessTypes,
            onSaved: (value) {
              if (value == null) return;
              setState(() {
                selectedBusinessTypes = value;
                print("printing the business types");
                print(selectedBusinessTypes);
                print(selectedBusinessTypes.join(','));
              });
            },
          )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Telephone Number'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue:telephone.contactNumber!=null ? telephone.contactNumber
                  :this.user.personalDetails.profile.telephone[0].contactNumber,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Enter Mobile Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
                  telephone.countryCode = "+91";
                  telephone.contactNumber = value!=null ? value: this.user.personalDetails.profile.telephone[0].contactNumber;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Email'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue:email.emailAddress!=null? email.emailAddress
                      : this.user.personalDetails.profile.email[0].emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Enter your email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
                  email.emailAddress = value!=null ? value : this.user.personalDetails.profile.email[0].emailAddress;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Company Website'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Type your company URL",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
                  email.emailAddress = value;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),

        this.identificationAttributesList.length > 0
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Identity Number'),
            DropdownButton(
              hint: this.identityType!=null ? Text(this.identityType.attributeName) : Text(
    "Identity Number",
    style: TextStyle(fontSize: 15),
    ),
              value: identityType,
              isExpanded: true,
              iconSize: 30.0,
              items: identificationAttributesList.map(
                    (val) {
                  return DropdownMenuItem<IdentificationAttributesList>(
                    value: val,
                    child: Text(
                      val.attributeName,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                   print("selection of identity type");
                   this.identityType = val;
                   print(jsonEncode(val));
                  },
                );
              },
            )

          ],
        )
            : Container(),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Identity Value'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: identityValue,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Type your identity value",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
                  identityValue= value;
                });
              },
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {},
                child: Text(
                  'Save & Exit',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                width: 15,
              ),
              RaisedButton(
                color: Colors.lightGreen,
                onPressed: () {saveCompanyDetails();},
                child: Text(
                  'Save & Continue',
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
