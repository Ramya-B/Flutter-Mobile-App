

import 'package:tradeleaves/models/index.dart';

abstract class UserService{
  Future getUser();
  Future saveFaqs(List<Faqs> faqs);

}