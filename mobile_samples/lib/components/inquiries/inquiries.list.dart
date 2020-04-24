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
  ActiveBuyRequestInputDTO activeBuyRequestInputDTO = new ActiveBuyRequestInputDTO();
  InquiriesResponseDto inquiries;
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
  bool hasResponse;
  List lobs = [
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0640", "lobName": "All"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0641", "lobName": "Marketplace"},
    {"lobId": "34343e34-7601-40de-878d-01b3bd1f0642", "lobName": "Bliss"}
  ];

  getInquiriesForParty(activeBuyRequestInputDTO) async {
    print("getInquiriesForParty called");
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getInquiriesForParty response");
    this.inquiries = InquiriesResponseDto.fromJson(res);
    print(jsonEncode(inquiries));
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

  getBuyRequestsForParty(activeBuyRequestInputDTO, hasMultipleRequests,
      index) async {
    print("getBuyRequestsForParty called");
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getBuyRequestsForParty response");
    inquiries = InquiriesResponseDto.fromJson(res);
    print(jsonEncode(inquiries));
    if (hasMultipleRequests) {
      inquiries.requestDetails[index].childRequests = inquiries.requestDetails;
      if (hasResponse) {
        inquiries.requestDetails[index].hasChildRequestsResponse = true;
      } else {
        inquiries.requestDetails[index].hasChildRequests = true;
      }
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
          getBuyRequestsForParty(activeBuyRequestInputDTO, true, index);
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
    setState(() {
      getInquiriesForParty(activeBuyRequestInputDTO);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (inquiries!=null && inquiries.requestDetails.length > 0)  ? ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: inquiries.requestDetails.length,
        itemBuilder: (BuildContext context, int index) => Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey
                  ),
                  color: Colors.grey[50],
                ),
                child: Row(children: <Widget>[
                  Container(child: Text(
                    'Inquiry Id :', style: TextStyle(color: Colors.grey),),),
                  Container(child: Text(' 1000-43-3-53',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),))
                ],),
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
                    Row(children: <Widget>[
                      Text('flutter Inquiry',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                    ],),
                    Row(children: <Widget>[
                      Container(child: Text(
                        'order quantity :', style: TextStyle(color: Colors.grey),),),
                      Container(child: Text(' 1000',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),))
                    ],),
                    Row(children: <Widget>[
                      Container(child: Text(
                        'order quantity :', style: TextStyle(color: Colors.grey),),),
                      Container(child: Text(' 1000',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),))
                    ],),
                    Row(children: <Widget>[
                      Container(child: Text(
                        'order quantity :', style: TextStyle(color: Colors.grey),),),
                      Container(child: Text(' 1000',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),))
                    ],)
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
                        Text('Sent to 1 supplier(s)',
                          style: TextStyle(color: Colors.brown),),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text('0 supplier(s) Responded',
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
    ): Container();

  }
}
