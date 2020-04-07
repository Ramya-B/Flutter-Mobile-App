import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tradeleaves/models/classificationGroupAttributeDTOResp.dart';
import 'package:tradeleaves/models/companyType.dart';
import 'package:tradeleaves/models/country.dart';
import 'package:tradeleaves/models/identificationGroups.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/industryType.dart';
import 'package:tradeleaves/models/states.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/tl-services/customs/customServiceImpl.dart';

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
  List<IdentificationGroups> indentificationGroupList;
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
  var businessAttributes = {};
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
      this.indentificationGroupList = List<IdentificationGroups>.from(
          res.map((i) => IdentificationGroups.fromJson(i)));
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
    var response = await crmService.businessType();
    this.businessTypeList =
        ClassificationGroupAttributeDTOResp.fromJson(response);
    print("getBusinessTypes response object {}...........");
    print(response);
    setState(() {
      this.businessTypeList =
          ClassificationGroupAttributeDTOResp.fromJson(response);
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
      address = company.address;
      email = company.email;
      profileAttribute = company.profileAttribute;
      partyIdentificationDTO = company.partyIdentificationDTO;
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
            print("if 2nd");
            for(CompanyType companyTypes in companyTypeList){
              print("second for called");
              print(companyTypes.companyTypeId);
              print(types.attrValue);
              if(companyTypes.companyTypeId == types.attrValue){
                print("if matched");
                companyType = companyTypes;
                print(companyType);
                break;
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


        }
      }

    });
  }

  @override
  void initState() {
    statesList = [];
    countryList = [];
    indentificationGroupList = [];
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
    identificationFieldAttributes.attributeName = "PAN";
    identificationFieldAttributes.attributeValue= "APBPY1234P";
    identificationFieldAttributes.identificationTypeId= "2152f6df-91cd-4fc2-afa7-2baa63ef5016";
    identificationFieldAttributes.identificationGroupId = null;
    identificationAttributes.add(identificationFieldAttributes);
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
    if(businessAttributes!=null){
      ProfileAttribute object = new ProfileAttribute();
      object.attrName = 'BUSINESS_TYPE';
      object.attrValue = "Buying";
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
            details.groupName!=null ? TextFormField(
              initialValue: details.groupName,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "This is your leagally registered name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (String value){
                setState(() {
                  details.groupName = value;
                });
              },
            ): Container(),
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
            details.groupNameLocal!=null ? TextFormField(
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
            ) : Container()
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
                  address.address1!=null ? TextFormField(
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
                  ) : Container(),
                  SizedBox(
                    height: 5,
                  ),
                  address.address2 !=null ? TextFormField(
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
                  )  :Container(),
                  SizedBox(
                    height: 5,
                  ),
                  address.city!=null ? TextFormField(
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
                  ) : Container(),
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
                  address.postalcode!=null ? TextFormField(
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

                  ) : Container(),
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
          child: (this.businessTypeList != null &&
                  this.businessTypeList.classificationGroupAttributeDTO.length >
                      0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                      Text("What's your primary business activity?"),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: this
                            .businessTypeList
                            .classificationGroupAttributeDTO
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return new CheckboxListTile(
                            title: new Text(businessTypeList
                                .classificationGroupAttributeDTO[index]
                                .attributeName),
                            value: values[businessTypeList
                                .classificationGroupAttributeDTO[index]
                                .attributeName],
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            onChanged: (bool value) {
                              setState(() {
                                values[businessTypeList
                                    .classificationGroupAttributeDTO[index]
                                    .attributeName] = value;
                                print(values);
                                 businessAttributes = values;
                                print(value);

                                print("printing business list");
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          );
                        },
                      ),
                    ])
              : Container(),
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
        (this.companyType != null && this.industryType != null)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Identity Number'),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        onChanged: (c) {},
                        underline: Container(),
                        items: [
                          DropdownMenuItem<String>(
                            child: Text(
                              this
                                  .indentificationGroupList[1]
                                  .identificationTypeDTOList[1]
                                  .identificationFieldsList[0]
                                  .name,
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      Flexible(
                          child: TextFormField(
                            initialValue:"",
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          hintText: "Enter PAN Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                            onChanged: (value) {
                              setState(() {
                                print(value);
//                                email.emailAddress = value;
                              });
                            },
                      )),
                    ],
                  ),
                ],
              )
            : Container(),
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
