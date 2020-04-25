import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServiceImpl.dart';
import '../../service_locator.dart';

class MyInquiries extends StatefulWidget {
  @override
  _MyInquiriesState createState() => _MyInquiriesState();
}

class _MyInquiriesState extends State<MyInquiries> {
  OrmServiceImpl get ormService => locator<OrmServiceImpl>();
  ActiveBuyRequestInputDTO activeBuyRequestInputDTO =
      new ActiveBuyRequestInputDTO();
  InquiriesResponseDto inquiries;
  List<RequestDetails> selectedInquiries = [];
  int perPageCount = 10;
  int chosenPage = 1;
  List countArray = [];
  List pagesCount = [];
  int showPaginationTo = 5;
  int previousIndex = -1;
  bool showReqDetails;
  List requestDetails;
  int parentCustomerRequestId;
  bool isHasChildRequests;
  bool hasMultipleRequests;
  bool hasResponse = false;
  List lobs = [
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0640", "lobName": "All"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0641", "lobName": "Marketplace"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0642", "lobName": "Bliss"}
  ];

  getInquiriesForParty(activeBuyRequestInputDTO) async {
    print("getInquiriesForParty called");
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getInquiriesForParty response");
    setState(() {
      this.inquiries = InquiriesResponseDto.fromJson(res);
    });
    print(jsonEncode(inquiries));
    selectedInquiries = inquiries.requestDetails;
    if (inquiries != null &&
        inquiries.requestDetails != null &&
        inquiries.requestDetails.length > 0 &&
        lobs != null &&
        lobs.length > 0) {
      print("request details are there");
      for (RequestDetails inquiry in inquiries.requestDetails) {
        if (inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0642" ||
            inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0643") {
          inquiry.requestDTO.lobName = "BLISS";
        } else if (inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0641" ||
            inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0644") {
          inquiry.requestDTO.lobName = "Marketplace";
        }
      }
    }
  }

  getBuyRequestsForParty(
      activeBuyRequestInputDTO, hasMultipleRequests, index) async {
    print("getBuyRequestsForParty called");
    print(hasMultipleRequests);
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getBuyRequestsForParty response");
    print(res);
    print("after response");
    InquiriesResponseDto inquiriesResponse = InquiriesResponseDto.fromJson(res);
    print(jsonEncode(inquiries));
    if (hasMultipleRequests) {
      print("went to if");
      setState(() {
        inquiries.requestDetails[index].childRequests = inquiriesResponse.requestDetails;
        if (hasResponse) {
          inquiries.requestDetails[index].hasChildRequestsResponse = true;
        } else {
          inquiries.requestDetails[index].hasChildRequests = true;
        }
      });

    }
    if (inquiries != null &&
        inquiries.requestDetails != null &&
        inquiries.requestDetails.length > 0 &&
        lobs != null &&
        lobs.length > 0) {
      for (RequestDetails inquiry in inquiries.requestDetails) {
        if (inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0642" ||
            inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0643") {
          inquiry.requestDTO.lobName = "BLISS";
        } else if (inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0641" ||
            inquiry.requestDTO.lobId ==
                "34343e34-7601-40de-878d-01b3bd1f0644") {
          inquiry.requestDTO.lobName = "Marketplace";
        }
      }
    }
  }

  checkHasChildRequests(parentCustomerRequestId) async {
    print("checkHasChildRequests called");
    if (inquiries.requestDetails != null &&
        inquiries.requestDetails.length > 0) {
      for (RequestDetails req in inquiries.requestDetails) {
        if (parentCustomerRequestId == req.requestDTO.customerRequestId) {
          if (req.childRequests != null && req.childRequests.length > 0) {
            if (hasResponse) {
              req.hasChildRequestsResponse = !req.hasChildRequestsResponse;
            } else {
              req.hasChildRequests = !req.hasChildRequests;
            }
            isHasChildRequests = true;
          }
          break;
        }
      }
    }
  }

  getRequestDetails(index, inquiry, showChildRequests, response) async {
    print("get Request deatisl called");
    if (previousIndex == index && inquiry.supplierRequestCount != 0) {
      showReqDetails = false;
      previousIndex = -1;
      hasResponse = response;
      checkHasChildRequests(parentCustomerRequestId);
    } else {
      previousIndex = index;
      requestDetails = [];
      parentCustomerRequestId = inquiry.requestDTO.customerRequestId;
      if (inquiry.supplierRequestCount == 0) {
        previousIndex = -1;
      } else {
        isHasChildRequests = false;
        checkHasChildRequests(parentCustomerRequestId);
        if (!isHasChildRequests) {
          ActiveBuyRequestInputDTO activeBuyRequestInputDTO =
              new ActiveBuyRequestInputDTO();
          activeBuyRequestInputDTO.parentCustomerRequestId =
              parentCustomerRequestId;
          activeBuyRequestInputDTO.startIndex = 0;
          activeBuyRequestInputDTO.size = inquiry.supplierRequestCount;
          hasMultipleRequests = true;
          setState(() {
            getBuyRequestsForParty(activeBuyRequestInputDTO, hasMultipleRequests, index);
          });
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    activeBuyRequestInputDTO.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
    activeBuyRequestInputDTO.size = 10;
    activeBuyRequestInputDTO.startIndex = 0;
    List<RequestDetails> selectedInquiries = [];
    setState(() {
      getInquiriesForParty(activeBuyRequestInputDTO);
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
        child: (selectedInquiries != null && selectedInquiries.length > 0)
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: selectedInquiries.length,
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
                                selectedInquiries[index]
                                            .requestDTO
                                            .newCustRequestId !=
                                        null
                                    ? selectedInquiries[index]
                                        .requestDTO
                                        .newCustRequestId
                                    : selectedInquiries[index]
                                        .requestDTO
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
                              Row(
                                children: <Widget>[
                                  Text(
                                    selectedInquiries[index]
                                                .requestDTO
                                                .customerRequestName !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index]
                                                .requestDTO
                                                .items[0]
                                                .quantity !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index]
                                                .requestDTO
                                                .items[0]
                                                .selectedAmount !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index]
                                                .requestDTO
                                                .customerRequestDate
                                                .substring(0, 10) !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index]
                                                .requestDTO
                                                .createdBy !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index]
                                                .requestDTO
                                                .responseRequiredDate
                                                .substring(0, 10) !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
                                            .responseRequiredDate
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
                                      'Delivery Date :',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    selectedInquiries[index]
                                                .requestDTO
                                                .items[0]
                                                .requiredByDate !=
                                            null
                                        ? selectedInquiries[index]
                                            .requestDTO
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
                                    selectedInquiries[index].lastActivityTs !=
                                            null
                                        ? selectedInquiries[index]
                                            .lastActivityTs
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
                                      'Line of Business :',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    selectedInquiries[index].requestDTO.lobName,
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
                                      'Status :',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                      child: Text(
                                    selectedInquiries[index]
                                                .requestDTO
                                                .marketPlaceRequest ==
                                            'Y'
                                        ? "Posted in marketplace"
                                        : "Sent to suppliers",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                      'Sent to 1 supplier(s)',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        getRequestDetails(index,
                                            selectedInquiries[index], 1, false);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    child: Text(
                                      '0 supplier(s) responded',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        getRequestDetails(index,
                                            selectedInquiries[index], 1, true);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        (inquiries.requestDetails[index].childRequests != null &&
                            inquiries.requestDetails[index].childRequests.length > 0)
                            ? Container(
                            child: (inquiries.requestDetails[index].childRequests != null &&
                                inquiries.requestDetails[index].childRequests.length > 0)
                                ? ListView.builder(
//                                    padding: const EdgeInsets.all(8),
                                    itemCount: inquiries.requestDetails[index].childRequests.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context,
                                            int idx) =>
                                        Column(children: <Widget>[
                                        Container(
                                        padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                            inquiries.requestDetails[index].childRequests[idx]
                                                .requestDTO
                                                .toPartyName !=
                                                null
                                                ? inquiries.requestDetails[index].childRequests[idx]
                                                .requestDTO
                                                .toPartyName
                                                : '-',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                          onTap: null,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text( inquiries.requestDetails[index].childRequests[idx]
                                                .requestDTO
                                                .customerRequestDate
                                                .substring(0, 10)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            InkWell(
                                              child: Text('Ignore', style: TextStyle(color: Colors.green)),
                                              onTap: null,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),)])
                            )
                                : Container()
                        ) : Container()
                      ],
                    ))
            : Container(),
      )
    ]));
  }
}
