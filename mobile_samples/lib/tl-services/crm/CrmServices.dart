

import 'package:tradeleaves/podos/crm/register.dart';

abstract class CrmServices {
  
   Future register(RegisterDTO registerDTO);
   Future verifyUser(UserCheck info);
   Future companyRegions();
   Future<List> companyTypes(String siteId);
   Future businessType();
   Future<List> industryType(String siteId);

}