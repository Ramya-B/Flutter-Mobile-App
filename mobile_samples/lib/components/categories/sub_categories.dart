import 'package:flutter/material.dart';
import 'package:tradeleaves/components/CustomAppBar.dart';
import 'package:tradeleaves/components/login_register/register.dart';
import 'package:tradeleaves/podos/categories/categories.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

import '../../service_locator.dart';

class SubCategoryDeatils extends StatefulWidget {
  final CategoryDTO categoryDTO;
  final categoryImage;

  SubCategoryDeatils(
      {Key key, this.categoryDTO,this.categoryImage})
      : super(key: key);

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategoryDeatils> {
  CatalogServiceImpl get catalogService => locator<CatalogServiceImpl>();

  var response = [];
  List<CategoryDetailsDTO> categoryDetails = [];
  List subCategoriesList = [];

  getCategoryDetailsByLoB() async {
    CategoryDetailsLobDTO categoryDetailsLobDTO = new CategoryDetailsLobDTO();
    categoryDetailsLobDTO.categoryId = widget.categoryDTO.id.toString();
    categoryDetailsLobDTO.lobId = ["34343e34-7601-40de-878d-01b3bd1f0641"];
    categoryDetailsLobDTO.systemRootCategoryFlag = false;
    print("getCategoryDetailsByLoB request object {}...........");
    print(categoryDetailsLobDTO.toJson());
    var response =
        await catalogService.getCategoryDetailsByLoB(categoryDetailsLobDTO);
    print("getCategoryDetailsByLoB response object {}...........");
    print(response);
    setState(() {
      for (var item = 0; item < response.length; item++) {
        this.categoryDetails.add(CategoryDetailsDTO.fromJson(response[item]));
      }
    });
  }

  @override
  void initState() {
    print("Before Calling getCategoryDetailsByLoB.................");
    getCategoryDetailsByLoB();
    print("After Calling getCategoryDetailsByLoB.................");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar(),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
                height: 300,
                width: 420,
                color: Colors.blueGrey,
                child: Center(
                  child: Text('${widget.categoryDTO.name}',
                      // '${this.categoryDetails[0].categoryAndAttributesDTO.categoryDTO.name}'
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                )),
            Container(
              padding: EdgeInsets.all(25),
              child: Text(
                'Import your agriculture & food products with ease and certainty, today.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: Container(
                  width: 300,
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => new Register()))
                    },
                    elevation: 5,
                    color: Colors.green[900],
                    textColor: Colors.white,
                    splashColor: Colors.green,
                    child: Text(
                      "Sign Me Up For Free Today",
                      style: TextStyle(fontSize: 16),
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              constraints: new BoxConstraints(
                minHeight: 200.0,
              ),
              child: ListView.builder(
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: this.categoryDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(
                          color: Colors.green,
                          height: 50,
                          child: Center(
                              child: Text(
                                  '${this.categoryDetails[index].categoryAndAttributesDTO.categoryDTO.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: this
                                  .categoryDetails[index]
                                  .subCategoryAndAttributesDTO
                                  .length,
                              itemBuilder: (context, int index2) {
                                return Center(
                                    child: Container(
                                  constraints: new BoxConstraints(
                                    minHeight: 200.0,
                                  ),
                                  height: 150,
                                  width: 150,
                                  child: Text(
                                      '${this.categoryDetails[index].subCategoryAndAttributesDTO[index2].categoryDTO.name}'),
                                  // decoration: BoxDecoration(
                                  //   shape: BoxShape.circle,
                                  //   image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage('${this.categoryDetails[index].subCategoryAndAttributesDTO[index2].categoryDTO.}'
                                  //         'https://dbtagriculture.bihar.gov.in/MediaGallery/undercon.jpg'),
                                  //   ),
                                  // )
                                ));
                              }),
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
