import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/models/index.dart';
import '../../service_locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:tradeleaves/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mime;

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String siteId = "1152f6df-91cf-4fc2-afa7-2baa63ef5429";
  CompanyType companyType;
  IndustryType industryType;
  List selectedBusinessTypes;
  String groupName;
  bool isBuying = false;
  bool isSelling = false;
  bool isServiceProvider = false;
  Company company;
  List<ClassificationGroupAttributeDTO> employees;
  List<CompanyType> companyTypeList;
  ClassificationGroupAttributeDTOResp businessTypeList;
  List<IndustryType> industryTypeList;
  var businessTypes;
  CompanyRegisterResp companyRegisterResp;
  ClassificationDetails companyYear = new ClassificationDetails();
  ClassificationDetails employee = new ClassificationDetails();
  ClassificationDetails turnOver = new ClassificationDetails();
  ClassificationDetails currency = new ClassificationDetails();
  Classifications classifications = new Classifications();
  List<ClassificationDetails> details = [];
  String companyImage;

  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  String companyHighLights;
  String companyStatus;

  Future<dynamic> uploadImage(imageFile, int length) async {
    print("image file");
    print(imageFile);
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "${Constants.envUrl}/mongoupload/attachments/?Override=false"));
    print("multipart fiile");
    print(request);
    request.files.add(await http.MultipartFile.fromPath(
      'attachments',
      imageFile.path,
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

  setIdentificationFile() async {
    print("setIdentificationFile called");
    var resultList = await FilePicker.getMultiFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );
    print("printing the uploaded images");
    print(resultList);
    for (var imageFile in resultList) {
      uploadImage(imageFile, resultList.length).then((fileResp) {
        // Get the download URL
        setState(() {
          print("uploadImage resp");
          print(fileResp);
          company.details.logoImageUrl = json.decode(fileResp)["fileName"];
          company.details.base64 = json.decode(fileResp)["base64"];
        });
      }).catchError((err) {
        print(err);
      });
    }
  }

  getCompanyDetails() async {
//    classifications.details = details;
    companyYear.id = null;
    companyYear.value = null;
    companyYear.type = 'NO_OF_YEAR_IN_BUSINESS';
    employee.value = null;
    employee.id = null;
    employee.type = 'NO_OF_EMPLOYEES';
    turnOver.id = null;
    turnOver.value = null;
    turnOver.type = 'TURNOVER';
    currency.id = null;
    currency.value = null;
    currency.type = "COUNTRY_CURRENCY";

    var res = await crmService.getCompanyDetails();
    setState(() {
      companyRegisterResp = CompanyRegisterResp.fromJson(res);
      this.company = companyRegisterResp.company;
      if (company != null &&
          company.accountStatus != null &&
          company.accountStatus.statusId == 'APPROVED') {
        companyStatus = 'APPROVED';
      } else if (company != null &&
          company.accountStatus != null &&
          company.accountStatus.statusId == 'UNDER_APPROVAL') {
        companyStatus = 'UNDER VERIFICATION';
      } else if (company != null &&
          company.accountStatus != null &&
          company.accountStatus.statusId == 'REJECTED') {
        companyStatus = 'REJECTED';
      }
      if (company.profileAttribute != null &&
          company.profileAttribute.length > 0) {
        print("1st if called");
        for (ProfileAttribute types in company.profileAttribute) {
          print("1st for called");
          if (types.attrName == "COMPANY_TYPE") {
            for (CompanyType companyTypes in companyTypeList) {
              if (companyTypes.companyTypeId == types.attrValue) {
                companyType = companyTypes;
              }
            }
          }
          if (types.attrName == "INDUSTRY") {
            for (IndustryType industryTypes in industryTypeList) {
              if (industryTypes.industryId == types.attrValue) {
                industryType = industryTypes;
              }
            }
          }
          if (types.attrName == "BUSINESS_TYPE") {
            selectedBusinessTypes = types.attrValue.split(",");
            print("Selected businesstypes");
            print(selectedBusinessTypes);
          }
          if (types.attrName == 'Company_Highlights') {
            companyHighLights = types.attrValue;
          }
        }
      }
      if (company != null &&
          company.classifications != null &&
          company.classifications.details != null &&
          company.classifications.details.length > 0) {
        for (ClassificationDetails attributes
            in company.classifications.details) {
          if (attributes.type == 'NO_OF_YEAR_IN_BUSINESS') {
            print("no of year in business found");
            companyYear = attributes;
            print(companyYear);
          } else if (attributes.type == 'NO_OF_EMPLOYEES') {
            print("no of employee found");
            employee = attributes;
            print(employee);
//            for (ClassificationGroupAttributeDTO employeeDetails in employees) {
//              if (employee.value == employeeDetails.attributeDescription) {
//                vm.empIndex = j;
//              }
//            }
          } else if (attributes.type == 'TURNOVER') {
            print("turnOver found");
            turnOver = attributes;
            print(turnOver);
          } else if (attributes.type == 'COUNTRY_CURRENCY') {
            currency = attributes;
            print(currency);
          }
        }
      }
    });
  }

  getBusinessTypes() async {
    print('getBusinessTypes called.....');
    businessTypes = await crmService.businessType();
    this.businessTypeList =
        ClassificationGroupAttributeDTOResp.fromJson(businessTypes);
    print("getBusinessTypes response object {}...........");
    print(businessTypes);
    setState(() {
      this.businessTypeList =
          ClassificationGroupAttributeDTOResp.fromJson(businessTypes);
    });
    getCompanyDetails();
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

  getCompanyTypes(String siteId) async {
    print('getCompanyTypes called.....');
    var res = await crmService.companyTypes(siteId);
    print("getCompanyTypes response object {}...........");
    print(res);
    print(jsonEncode(res));
    setState(() {
      this.companyTypeList =
          List<CompanyType>.from(res.map((i) => CompanyType.fromJson(i)));
    });
  }

  getClassificationForEmployees() async {
    print("getClassificationForEmployees cslled");
    var res = await crmService.getClassificationForEmployees();
    print("printing before");
    print(jsonEncode(res));
    setState(() {
      ClassificationGroupAttributeDTOResp employeesResponse = ClassificationGroupAttributeDTOResp.fromJson(res);
      this.employees = employeesResponse.classificationGroupAttributeDTO;
      print("printing employess");
      print(jsonEncode(employees));
    });
  }

  updateCompany() async {
    print('update company called');
    print(jsonEncode(companyYear));
    print(employee);
    if (companyHighLights != null) {
      ProfileAttribute companyHighlights = new ProfileAttribute();
      companyHighlights.attrName = 'Company_Highlights';
      companyHighlights.attrValue = companyHighLights;
      companyHighlights.attrType = 'BLOB';
      company.profileAttribute.add(companyHighlights);
    }

    if (companyYear.value != null) {
      details.add(companyYear);
    }
    if (employee.value != null) {
      employee.value = "11-20";
      details.add(employee);
    }
    if (turnOver.value != null) {
      details.add(turnOver);
    }
    currency.value = 'INR';
    details.add(currency);
    print(jsonEncode(details));
    classifications.details = details;
    company.classifications = classifications;
    AccountStatus accountStatus = new AccountStatus();
    accountStatus.statusId = "UNDER_APPROVAL";
    company.details.rejected = 'N';
    company.details.reason = null;
    var res = await crmService.postCompany(company);
    print("updated successfulyy");
    setState(() {});
  }

  discardChanges() async {
    print("discardChanges called");
    company = null;
    getCompanyDetails();
  }

  @override
  void initState() {
//    getCompanyDetails();
    getCompanyTypes(siteId);
    getIndustryTypes(siteId);
    getBusinessTypes();
    getClassificationForEmployees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.rectangle,
                    border: Border.all(width: 1, color: Colors.grey)),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: Colors.orange,
                      size: 40,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('COMPANY STATUS', style: TextStyle(fontSize: 12)),
                        Text(
                          '$companyStatus',
                          style:
                              TextStyle(color: Colors.green[700], fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Company Name'),
                  SizedBox(
                    height: 8,
                  ),
                  (company != null &&
                          company.details != null &&
                          company.details.groupName != null)
                      ? TextFormField(
                          initialValue: (company != null &&
                                  company.details != null &&
                                  company.details.groupName != null)
                              ? company.details.groupName
                              : '',
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            hintText: "This is your legally registered name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onChanged: (String value) {
                            setState(() {
                              company.details.groupName = value;
                            });
                          },
                        )
                      : Container()
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
                    initialValue: company != null &&
                            company.details != null &&
                            company.details.groupNameLocal != null
                        ? company.details.groupNameLocal
                        : '',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText:
                          "Another name to your full registered trading name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        company.details.groupNameLocal = value;
                      });
                    },
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
                                companyType = val;
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
                  Text('Company Website'),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue: company != null &&
                            company.details != null &&
                            company.details.officeSiteName != null
                        ? company.details.officeSiteName
                        : '',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Enter your website",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        company.details.officeSiteName = value;
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
                  Text('Number of years in business'),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue:
                        companyYear.value != null ? companyYear.value : '',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "How many years since your company was formed?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        companyYear.value = value;
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
                  Text('Number of employees'),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: RaisedButton(
                          color: Colors.grey[200],
                          onPressed: () {},
                          child: Text(
                            '11-20',
                            style: TextStyle(color: Colors.green[700]),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: RaisedButton(
                          color: Colors.green[700],
                          onPressed: () {},
                          child: Text(
                            '21-30',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: RaisedButton(
                          color: Colors.grey[200],
                          onPressed: () {},
                          child: Text(
                            '31-50',
                            style: TextStyle(color: Colors.green[700]),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 70,
                        child: RaisedButton(
                          color: Colors.grey[200],
                          onPressed: () {},
                          child: Text(
                            '50+',
                            style: TextStyle(color: Colors.green[700]),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Turnover'),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue: turnOver.value != null ? turnOver.value : '',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                      hintText: "Your anual turnover",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        turnOver.value = value;
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
                    dataSource:
                        businessTypes["classificationGroupAttributeDTO"],
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
                  )),
//              Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    Text("What's your primary business activity?"),
//                    CheckboxListTile(
//                      activeColor: Colors.green,
//                      checkColor: Colors.white,
//                      value: isBuying,
//                      onChanged: (bool val) => setState(() {
//                        isBuying = val;
//                      }),
//                      title: Text("Buying"),
//                      controlAffinity: ListTileControlAffinity.leading,
//                    ),
//                    CheckboxListTile(
//                      activeColor: Colors.green,
//                      checkColor: Colors.white,
//                      value: isSelling,
//                      onChanged: (bool val) => setState(() {
//                        isSelling = val;
//                      }),
//                      title: Text("Selling"),
//                      controlAffinity: ListTileControlAffinity.leading,
//                    ),
//                    CheckboxListTile(
//                      activeColor: Colors.green,
//                      checkColor: Colors.white,
//                      value: isServiceProvider,
//                      onChanged: (bool val) => setState(() {
//                        isServiceProvider = val;
//                      }),
//                      title: Text("Service Provider"),
//                      controlAffinity: ListTileControlAffinity.leading,
//                    ),
//                  ]),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Company Highlights'),
                  SizedBox(
                    height: 8,
                  ),
//                  Container(
//                      width: MediaQuery.of(context).size.width,
//                      height: 150,
//                      decoration: BoxDecoration(
//                          shape: BoxShape.rectangle,
//                          border:
//                              Border.all(width: 1, color: Colors.grey[200]))
//                  )
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      initialValue:
                          companyHighLights != null ? companyHighLights : '',
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          hintText: 'Company Highlights',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                      validator: (arg1) {
                        return null;
                      },
                      onChanged: (val) {
                        print(val);
                        companyHighLights = val;
                      },
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
                  Text('Upload your logo'),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 135,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border:
                              Border.all(width: 1, color: Colors.grey[200])),
                      child: Column(
                        children: <Widget>[
                          this.company.details.logoImageUrl != null
                              ? Image.network(
                                  '${Constants.envUrl}${Constants.mongoImageUrl}/${this.company.details.logoImageUrl}',
                                  height: 130,
                                  width: 130,
                                )
                              : Container(),
                        ],
                      )),
                  RaisedButton(
                    textColor: Colors.green[900],
                    onPressed: () {
                      setIdentificationFile();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green[900], width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("Attach"),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    InkWell(
                      child: Text('Discard Changes'),
                      onTap: () {
                        discardChanges();
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    RaisedButton(
                      color: Colors.lightGreen,
                      onPressed: () {
                        updateCompany();
                      },
                      child: Text(
                        'Save Settings',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
