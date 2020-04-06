import 'package:tradeleaves/models/index.dart';
import 'package:tradeleaves/podos/crm/register.dart';

abstract class CrmServices {
  Future register(RegisterDTO registerDTO);
  Future verifyUser(UserCheck info);
  Future companyRegions();
  Future<List> companyTypes(String siteId);
  Future businessType();
  Future<List> industryType(String siteId);
  Future<List> getIdentificationGroyp(int groupId);
  Future<List> getStates(String name, bool isActive);
  Future getPersonalDetails();
  Future updateUser(PersonalDetailsDTO personalDetailsDTO);
  Future updatePassword(UpdatePasswordDto updatePasswordDto);
  Future resendOtp(Resend resend);
  Future chagePassword(ChangeUserPassword changeUserPassword);
  Future getSecurityQuestions();
  Future saveSecurityQuestions(PartyQuestionsList partyQuestionsList);
  Future fetchSecurityQuestionsByPartyId(String partyId);
  Future saveCompanyDetails(Company company);
}
