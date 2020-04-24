import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/models/uomDTO.dart';
import 'package:tradeleaves/podos/suppliers/supplier.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/tl-services/customs/customServiceImpl.dart';
import 'package:intl/intl.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServiceImpl.dart';
import '../../constants.dart';
import '../../service_locator.dart';

class ContactSupplier extends StatefulWidget {
  final ProductDTO productDTO;
  final SupplierDTO supplierDTO;

  ContactSupplier({this.productDTO, this.supplierDTO});

  @override
  _ContactSupplierState createState() => _ContactSupplierState();
}

class _ContactSupplierState extends State<ContactSupplier> {
  final _formKey = GlobalKey<FormState>();
  CustomServiceImpl get customService => locator<CustomServiceImpl>();
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();
  OrmServiceImpl get ormService => locator<OrmServiceImpl>();
  List<UomDTO> uomsList;
  CustomerRequestDTO customerRequestDTO;
  var supplierData;
  String supplierEmail;
  UomDTO uom;
  getUomList() async {
    var uoms = await customService.getUoms();
    print(uoms);
    setState(() {
      uomsList =
          List<UomDTO>.from(uoms.map((data) => UomDTO.fromJson(data))).toList();
    });
  }

  getSupplierInfo() async {
    supplierData =
        await crmService.getSupplierById(widget.supplierDTO.supplierId);
    supplierEmail =
        supplierData["partyDetailsDTO"]["company"]["email"]["emailAddress"];
  }

  @override
  void initState() {
    this.uomsList = [];
    customerRequestDTO = new CustomerRequestDTO();
    customerRequestDTO.items = [];
    customerRequestDTO.items.add(new ItemsListDto());
    getSupplierInfo();

    getUomList();
    super.initState();
  }

  validateForm() async {
     
    var form = _formKey.currentState;
    if (form.validate()) {
      sendInquiry();
      setState(() {
        print("set state of save form");
        Navigator.pop(context);
      });
    }
 

  }
  sendInquiry() async {
    customerRequestDTO.categoryId = widget.productDTO.categoryIds[0].toString();
    customerRequestDTO.countryCd =
        widget.productDTO.productLobCountryStatusDTO[0].countryId;
    customerRequestDTO.customerRequestAttributeListDto = [];
    customerRequestDTO.lobId =
        widget.productDTO.productLobCountryStatusDTO[0].lobId;
    customerRequestDTO.priority = 0;
    customerRequestDTO.serviceRequest = false;

    customerRequestDTO.supplierListDto = [];
    SupplierListDto supplierDto = new SupplierListDto();
    supplierDto.email = supplierEmail;
    supplierDto.productId = widget.productDTO.productId;
    supplierDto.productLobId =
        widget.productDTO.productLobCountryStatusDTO[0].lobId;
    supplierDto.productName = widget.productDTO.productName;
    supplierDto.supplierStatus = widget.supplierDTO.supplierStatus;
    supplierDto.toPartyId = widget.supplierDTO.supplierId;
    supplierDto.toPartyName = widget.supplierDTO.supplierName;
    customerRequestDTO.supplierListDto.add(supplierDto);
    customerRequestDTO.supplierStatus = "WAITING_FOR_SUPPLIER_ACCEPTANCE";
    var resp = ormService.createBuyrequest(customerRequestDTO);
    setState(() {
      if (resp != null) {
        // final snackBar = SnackBar(
        //   content: Text('Inquiry sent successfully.'),
        //   action: SnackBarAction(
        //     label: 'Ok',
        //     onPressed: () {},
        //   ),
        // );
        // Scaffold.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Contact Supplier'),
        backgroundColor: Constants.toolbarColor,
      ),
          body: Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Title'),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: 'Title',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                        validator: (title) {
                          customerRequestDTO.customerRequestName = title;
                          return null;
                        },
                        onChanged: (title) {
                          setState(() {
                            customerRequestDTO.customerRequestName = title;
                          });
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Notes'),
                  ),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        maxLines: 4,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            hintText: 'Notes',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                        validator: (desc) {
                          customerRequestDTO.customerRequestDesc = desc;
                          return null;
                        },
                        onChanged: (desc) {
                          setState(() {
                            customerRequestDTO.customerRequestDesc = desc;
                          });
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Order Quantity'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        this.uomsList.length > 0
                            ? Expanded(
                                child: DropdownButton(
                                  hint: Text('select UOM'),
                                  isExpanded: true,
                                  value:  uom!=null ? uom :null,
                                  iconSize: 30.0,
                                  items: this.uomsList.map(
                                    (val) {
                                      return DropdownMenuItem<UomDTO>(
                                        value: val,
                                        child: Text(val.unit),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        print(jsonEncode(val));
                                        uom = val;
                                        customerRequestDTO
                                            .items[0].globalPriceFlag = "N";
                                        customerRequestDTO.items[0].quantityType =
                                            val.unit;
                                        customerRequestDTO.maximumAmountUOMId =
                                            val.unit;
                                      },
                                    );
                                  },
                                ),
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.all(10),
                        ),
                        Expanded(
                            child: TextFormField(
                               keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: 'Order Quantity',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          validator: (arg1) {
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              print(val);
                              customerRequestDTO.items[0].quantity =
                                  num.parse(val);
                            });
                          },
                        )),
                      ],
                    ),
                  ),
                  Container(
                      height: 100,
                      padding: EdgeInsets.all(10.0),
                      child: DateTimeField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                          hintText: 'Response Date',
                        ),
                        onChanged: (DateTime val) {
                          setState(() {
                            print(DateFormat('yyyy-MM-dd').format(val));
                            customerRequestDTO.responseRequiredDate =
                                DateFormat('yyyy-MM-dd').format(val);
                          });
                        },
                        validator: (val) {
                          print("date is");

                          return null;
                        },
                        format: DateFormat("yyyy-MM-dd"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      )),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          print("validating ....!");
                          validateForm();
                        }),
                  ),
                ],
              ),
            )),
          ),
    );
  }
}
