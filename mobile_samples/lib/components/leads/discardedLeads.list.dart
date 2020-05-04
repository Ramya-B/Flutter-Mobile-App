import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServiceImpl.dart';
import '../../service_locator.dart';

class MyDiscardedLeads extends StatefulWidget {
  @override
  _MyDiscardedLeadsState createState() => _MyDiscardedLeadsState();
}

class _MyDiscardedLeadsState extends State<MyDiscardedLeads> {
  OrmServiceImpl get ormService => locator<OrmServiceImpl>();
  SupplierReceiveCustRequestDTO supplierReceiveCustRequestDTO =
  new SupplierReceiveCustRequestDTO();
  LeadsResponseDto leads;
  List<SupplierResponseListDto>selectedLeads;
  List lobs = [
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0640", "lobName": "All"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0641", "lobName": "Marketplace"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0642", "lobName": "Bliss"}
  ];
  getDiscardedLeadsForP(supplierReceiveCustRequestDTO) async{
    print("getDiscardedLeadsForP caled");
    var res = await ormService.getSupplierReceiveCustRequest(supplierReceiveCustRequestDTO);
    print("getDiscardedLeadsForP response");
    setState(() {
      this.leads = LeadsResponseDto.fromJson(res);
      this.selectedLeads = leads.supplierResponseListDto;
      if (selectedLeads != null &&
          selectedLeads.length > 0 &&
          lobs != null &&
          lobs.length > 0) {
        print("request details are there");
        for (SupplierResponseListDto lead in selectedLeads) {
          if (lead.requestDto.lobId ==
              "34343e34-7601-40de-878d-01b3bd1f0642" ||
              lead.requestDto.lobId ==
                  "34343e34-7601-40de-878d-01b3bd1f0643") {
            lead.requestDto.lobName = "BLISS";
          } else if (lead.requestDto.lobId ==
              "34343e34-7601-40de-878d-01b3bd1f0641" ||
              lead.requestDto.lobId ==
                  "34343e34-7601-40de-878d-01b3bd1f0644") {
            lead.requestDto.lobName = "Marketplace";
          }
        }
      }
    });
  }

  @override
  void initState() {
    supplierReceiveCustRequestDTO.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
    supplierReceiveCustRequestDTO.size = 10;
    supplierReceiveCustRequestDTO.startIndex = 0;
    supplierReceiveCustRequestDTO.supplierStatus = "DISCARDED";
    List<SupplierResponseListDto> selectedLeads = [];
    setState(() {
      getDiscardedLeadsForP(supplierReceiveCustRequestDTO);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Container(
            constraints: new BoxConstraints(
              minHeight: 200.0,
            ),
            child: (selectedLeads != null && selectedLeads.length > 0)
                ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: selectedLeads.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) => Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.grey[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Inquiry Id :',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Container(
                              child: Text(
                                selectedLeads[index]
                                    .requestDto
                                    .newCustRequestId !=
                                    null
                                    ? selectedLeads[index]
                                    .requestDto
                                    .newCustRequestId
                                    : selectedLeads[index]
                                    .requestDto
                                    .customerRequestId,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(width: 1.0, color: Colors.grey),
                          right: BorderSide(width: 1.0, color: Colors.grey),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[
                              Text(
                                selectedLeads[index]
                                    .requestDto
                                    .customerRequestName !=
                                    null
                                    ? selectedLeads[index]
                                    .requestDto
                                    .customerRequestName
                                    : '-',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'order quantity :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .quantity !=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .quantity
                                        .toString()
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Unit Price :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .selectedAmount !=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .selectedAmount
                                        .toString()
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Request Date :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .customerRequestDate
                                        .substring(0, 10) !=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .customerRequestDate
                                        .substring(0, 10)
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Created By :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .createdBy !=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .createdBy
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Response Required Date :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .responseRequiredDate!=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .responseRequiredDate.substring(0,10)
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Delivery Date :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .requiredByDate !=
                                        null
                                        ? selectedLeads[index]
                                        .requestDto
                                        .items[0]
                                        .requiredByDate
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Last Activity :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index].requestDto.fromPartyUpdatedTS !=
                                        null
                                        ? selectedLeads[index].requestDto
                                        .fromPartyUpdatedTS
                                        : '-',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  'Line of Business :',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Container(
                                  child: Text(
                                    selectedLeads[index].requestDto.lobName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ))
                : Container(),
          )
        ]));

  }
}
