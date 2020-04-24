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

  getBuyRequestsForParty(activeBuyRequestInputDTO) async{
    print("getBuyRequestsForParty called");
    var res = await ormService.getBuyRequestById(activeBuyRequestInputDTO);
    print("getBuyRequestsForParty response");
    inquiries = InquiriesResponseDto.fromJson(res);
    print(jsonEncode(inquiries));

  }
  @override
  void initState() {
    // TODO: implement initState
    activeBuyRequestInputDTO.lobId = "34343e34-7601-40de-878d-01b3bd1f0640";
    activeBuyRequestInputDTO.size = 10;
    activeBuyRequestInputDTO.startIndex = 0;
    getBuyRequestsForParty(activeBuyRequestInputDTO);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
