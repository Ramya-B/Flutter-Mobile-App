import 'package:flutter/material.dart';
import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import '../../service_locator.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';

class SecurityQuestions extends StatefulWidget {
  @override
  _SecurityQuestionsState createState() => _SecurityQuestionsState();
}

class _SecurityQuestionsState extends State<SecurityQuestions> {
  CrmServiceImpl get crmService => locator<CrmServiceImpl>();

  UserServiceImpl get userService => locator<UserServiceImpl>();
  SecurityQuestionsResponse securityQuestionsResponse;
  List<QuestionsDTO> firstQuestionDto = [];
  List<QuestionsDTO> secondQuestionDto = [];
  List<QuestionsDTO> thirdQuestionDto = [];
  QuestionsDTO question1;
  QuestionsDTO question2;
  QuestionsDTO question3;
  String answer1;
  String answer2;
  String answer3;
  PartyQuestionsList partyQuestionsList = new PartyQuestionsList();
  List<QuestionsDTO> questionsList = [];
  User user;
  PartyQuestionsListRequest savedQuestionResponse;
  @override
  void initState() {
    getUserInfo();
    getSecurityQuestions();

    super.initState();

  }
  getUserInfo() async {
    var data = await userService.getUser();
    print("user response...");
    this.user = User.fromJson(data);
    setState(() {
      this.user = User.fromJson(data);
      print("user response set state...");
      print(this.user);
      print(this.user.partyId);
      getSecurityQuestionsByPartyId(this.user.partyId);

    });
  }
  getSecurityQuestionsByPartyId(String partyId) async{
    print("get security questions called");
    var response = await crmService.fetchSecurityQuestionsByPartyId(partyId);
    print("getSecurityQuestionsByPartyId response");
    print(response);
    savedQuestionResponse = PartyQuestionsListRequest.fromJson(response);
    print(savedQuestionResponse.partyQuestionsList);
    for (QuestionsDTO items in savedQuestionResponse.partyQuestionsList.questionsList) {
      for(QuestionsDTO question in securityQuestionsResponse.questionsDTO) {
        print("printing item");
        print(items.answer);
        if (items.categoryId == "1" && question.questionId == items.questionId) {
          print("first if called");
          question1 = question;
          this.answer1 = items.answer;
          break;
        } else if (items.categoryId == "2" && question.questionId == items.questionId) {
          print("second if called");
          question2 = question;
          this.answer2 = items.answer;
          break;
        } else  if (items.categoryId == "3" && question.questionId == items.questionId) {
          print("third if called");
          question3 = question;
          this.answer3 = items.answer;
          break;
        }
      }
    }
    setState(() {
      print("set state called");
      print(this.answer1);
      print(this.answer2);
      print(this.answer3);
      print(firstQuestionDto);
      print(secondQuestionDto);
      print(thirdQuestionDto);
    });
  }
  getSecurityQuestions() async {
    print("get security questions called");
    var response = await crmService.getSecurityQuestions();
    print(response);
    securityQuestionsResponse = SecurityQuestionsResponse.fromJson(response);
    print(securityQuestionsResponse);
    print("securityQuestionsResponse");
    print(securityQuestionsResponse.questionsDTO);
    setState(() {
      for (QuestionsDTO items in securityQuestionsResponse.questionsDTO) {
        print("printing item");
        print(items);
        if (items.categoryId == "1") {
          firstQuestionDto.add(items);
        } else if (items.categoryId == "2") {
          secondQuestionDto.add(items);
        } else if (items.categoryId == "3") {
          thirdQuestionDto.add(items);
        }
      }
      print(firstQuestionDto);
      print(secondQuestionDto);
      print(thirdQuestionDto);
    });

  }
//  prepareQuestions(QuestionsDTO question, String categoryId) async{
//    QuestionsDTO questionsDTO = new QuestionsDTO();
//    questionsDTO.questionId = question.questionId;
//    questionsDTO.categoryId = question.categoryId;
//    questionsList.add(questionsDTO);
//  }
//  prepareAnswersList(String answer, int index){
//        questionsList[index].answer = answer;
//
//  }
  saveSecurityQuestions() async{
    print(this.questionsList);
    print("save security questions called");
    questionsList = [];
    if(this.question1!=null && this.answer1!=null){
      QuestionsDTO questionsDTO = new QuestionsDTO();
      questionsDTO.questionId = this.question1.questionId;
      questionsDTO.categoryId = this.question1.categoryId;
      questionsDTO.answer = this.answer1;
      questionsList.add(questionsDTO);
    }
    if(this.question2!=null && this.answer2!=null){
      QuestionsDTO questionsDTO = new QuestionsDTO();
      questionsDTO.questionId = this.question2.questionId;
      questionsDTO.categoryId = this.question2.categoryId;
      questionsDTO.answer = this.answer2;
      questionsList.add(questionsDTO);
    }
    if(this.question3!=null && this.answer3!=null){
      QuestionsDTO questionsDTO = new QuestionsDTO();
      questionsDTO.questionId = this.question3.questionId;
      questionsDTO.categoryId = this.question3.categoryId;
      questionsDTO.answer = this.answer3;
      questionsList.add(questionsDTO);
    }
    partyQuestionsList.questionsList = this.questionsList;
    print(partyQuestionsList);
    print(this.questionsList);
    print("savesecurity called");
    var response = await crmService.saveSecurityQuestions(partyQuestionsList);
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Security Questions Page'),
      // ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Security Questions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                    'We want to make sure that your account and the information in it stays safe, so make sure that the given security questions can be safe, easily memorable and simple.'),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Question No.1:'),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButton(
                      hint: Text('Select question 1'),
                      isExpanded: true,
                      value: question1,
                      iconSize: 30.0,
                      items: this.firstQuestionDto.map(
                            (val) {
                          return DropdownMenuItem<QuestionsDTO>(
                            value: val,
                            child: Text(
                              val.question,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                               this.question1 = val;
                                print('question1 printing');
                                print(this.question1.question);
//                                prepareQuestions(this.question1, 1);
                              },
                        );
                      },
                    )
//                    TextFormField(
//                      decoration: InputDecoration(
//                        contentPadding:
//                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
//                        hintText: "Please select a question",
//                        border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(5)),
//                      ),
//                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Answer'),
                    SizedBox(
                      height: 8,
                    ),
//                    Text(this.answer1),
                    this.answer1!=null ? TextFormField(
                        initialValue: this.answer1!=null ? this.answer1: null,
                        decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Please enter the answer",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          this.answer1 = value;
                          print("answer printing");
                          print(this.answer1);
//                          prepareAnswersList(value,0);
                        });
                      },
                    ) : Container(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Question No.2:'),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButton(
                      hint: Text('Select question 1'),
                      isExpanded: true,
                      value: question2,
                      iconSize: 30.0,
                      items: this.secondQuestionDto.map(
                            (val) {
                          return DropdownMenuItem<QuestionsDTO>(
                            value: val,
                            child: Text(
                              val.question,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            this.question2 = val;
                            print('question1 printing');
                            print(this.question2.question);
//                            prepareQuestions(this.question2);
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Answer'),
                    SizedBox(
                      height: 8,
                    ),
                    this.answer2!=null ? TextFormField(
                      initialValue: this.answer2,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Please enter the answer",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          this.answer2 = value;
                        });
                      },
                    ) : Container(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Question No.3:'),
                    SizedBox(
                      height: 8,
                    ),
                    DropdownButton(
                      hint: Text('Select question 1'),
                      isExpanded: true,
                      value: question3,
                      iconSize: 30.0,
                      items: this.thirdQuestionDto.map(
                            (val) {
                          return DropdownMenuItem<QuestionsDTO>(
                            value: val,
                            child: Text(
                              val.question,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        setState(
                              () {
                            this.question3 = val;
                            print('question1 printing');
                            print(this.question3.question);
//                            prepareQuestions(this.question3);
                          },
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Answer'),
                    SizedBox(
                      height: 8,
                    ),
                    this.answer3!=null ? TextFormField(
                      initialValue: this.answer3,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                        hintText: "Please enter the answer",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onChanged: (String value){
                        setState(() {
                          this.answer3 = value;
                        });
                      },
                    ) : Container(),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightGreen,
//                        onPressed: () {},
                        onPressed: () {saveSecurityQuestions();},

                        child: Text(
                          'Save',
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
          ),
        ],
      ),
    );
  }
}
