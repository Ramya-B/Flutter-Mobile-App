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
  String companyType;
  String industryType;
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
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "This is your leagally registered name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
            Text('Trading/Public/DBA Name'),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Trading/Public Name",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
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
            Text('Company Address'),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address1",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Address2",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "City/Town",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
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
                                iconSize: 30.0,
                                items: this.statesList.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val.name,
                                      child: Text(
                                        val.name,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      this.state = val;
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
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Pin Code",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  )
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
                            companyType,
                            style: TextStyle(fontSize: 15),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    items: this.companyTypeList.map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val.name,
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
                      industryType,
                      style: TextStyle(fontSize: 15),
                    ),
              isExpanded: true,
              iconSize: 30.0,
              items: this.industryTypeList.map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val.name,
                    child: Text(val.name),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
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
              initialValue: this
                          .user
                          .personalDetails
                          .profile
                          .telephone[0]
                          .contactNumber !=
                      null
                  ? this.user.personalDetails.profile.telephone[0].contactNumber
                  : 0,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Enter Mobile Number",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
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
              initialValue:
                  this.user.personalDetails.profile.email[0].emailAddress !=
                          null
                      ? this.user.personalDetails.profile.email[0].emailAddress
                      : null,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                hintText: "Enter your email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (value) {
                setState(() {
                  print(value);
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
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          hintText: "Enter PAN Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
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
                onPressed: () {},
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
