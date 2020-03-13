
import 'package:tradeleaves/podos/crm/register.dart';

abstract class LoginService{
  Future getAuthToken(AuthRequest authRequest);
  Future logIn(AuthRequest authRequest);


}