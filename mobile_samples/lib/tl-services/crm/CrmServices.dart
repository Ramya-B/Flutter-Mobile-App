

import 'package:tradeleaves/podos/crm/register.dart';

abstract class CrmServices {
  
   Future register(RegisterDTO registerDTO);
   Future verifyUser(UserCheck info);

}