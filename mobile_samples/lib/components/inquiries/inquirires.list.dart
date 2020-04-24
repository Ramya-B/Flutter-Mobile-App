import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/orm-api/OrmServiceImpl.dart';

import '../../service_locator.dart';
class Inquiries extends StatefulWidget {
  @override
  _InquiriesState createState() => _InquiriesState();
}

class _InquiriesState extends State<Inquiries> {
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
  getInquiriesForParty(activeBuyRequestInputDTO) async{
    print("getInquiriesForParty called");
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getBuyRequestsForParty response");
    inquiries = InquiriesResponseDto.fromJson(res);
    print(jsonEncode(inquiries));
  }
  getBuyRequestsForParty(activeBuyRequestInputDTO, hasMultipleRequests, index) async{
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

  }
  checkHasChildRequests(parentCustomerRequestId) async{
    print("checkHasChildRequests called");
    if (inquiries.requestDetails!=null && inquiries.requestDetails.length > 0) {
      for (RequestDetails req in inquiries.requestDetails) {
        if (parentCustomerRequestId == req.requestDTO.customerRequestId) {
          if (req.childRequests!=null  && req.childRequests.length > 0) {
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
  getRequestDetails(index, inquiry, showChildRequests, response) async{
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
      }
      else {
        isHasChildRequests = false;
        checkHasChildRequests(parentCustomerRequestId);
        if (!isHasChildRequests) {
          ActiveBuyRequestInputDTO activeBuyRequestInputDTO = new ActiveBuyRequestInputDTO();
          activeBuyRequestInputDTO.parentCustomerRequestId = parentCustomerRequestId;
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
    getInquiriesForParty(activeBuyRequestInputDTO);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
