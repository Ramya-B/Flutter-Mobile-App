class RegisterDTO {
  UserLoginDTO userLoginDTO;
  PersonalDetailsDTO person;
  CompanyDTO company;
  String channel;
  String region;
  String featureId;

  RegisterDTO(
      {this.userLoginDTO,
      this.person,
      this.company,
      this.channel,
      this.region,
      this.featureId});

  factory RegisterDTO.fromJson(Map<String, dynamic> json) {
    return RegisterDTO(
      userLoginDTO: UserLoginDTO.fromJson(json['userLoginDTO']),
      person: PersonalDetailsDTO.fromJson(json['person']),
      company: CompanyDTO.fromJson(json['company']),
      channel: json['channel'],
      region: json['region'],
      featureId: json['featureId'],
    );
  }

  Map toJson() {
    return {
      'userLoginDTO': userLoginDTO,
      'person': person,
      'company': company,
      'channel': channel,
      'region': region,
      'featureId': featureId,
    };
  }
}

class UserLoginDTO {
  String userLoginId;
  String password;

  UserLoginDTO({this.userLoginId, this.password});

  factory UserLoginDTO.fromJson(Map<String, dynamic> json) {
    return UserLoginDTO(
      userLoginId: json['userLoginId'],
      password: json['password'],
    );
  }

  Map toJson() {
    return {
      "userLoginId": userLoginId,
      "password": password,
    };
  }
}

class CompanyDTO {
  PartyGroupDTO details;

  CompanyDTO({this.details});

  factory CompanyDTO.fromJson(Map<String, dynamic> json) {
    return CompanyDTO(
      details: PartyGroupDTO.fromJson(json['details']),
    );
  }

  Map toJson() {
    return {
      "details": details,
    };
  }
}

class PartyGroupDTO {
  String groupName;

  PartyGroupDTO({this.groupName});

  factory PartyGroupDTO.fromJson(Map<String, dynamic> json) {
    return PartyGroupDTO(
      groupName: json['groupName'],
    );
  }

  Map toJson() {
    return {
      "groupName": groupName,
    };
  }
}

class PersonalDetailsDTO {
  PersonDTO details;
  TelephoneDTO mobile;
  EmailContactDTO email;

  PersonalDetailsDTO({this.details, this.mobile, this.email});

  factory PersonalDetailsDTO.fromJson(Map<String, dynamic> json) {
    return PersonalDetailsDTO(
      details: PersonDTO.fromJson(json['details']),
      mobile: TelephoneDTO.fromJson(json['mobile']),
      email: EmailContactDTO.fromJson(json['email']),
    );
  }

  Map toJson() {
    return {
      "details": details,
      'mobile': mobile,
      'email': email,
    };
  }
}

class PersonDTO {
  String firstName;
  String domainName;
  bool optIn;

  PersonDTO({this.firstName, this.domainName, this.optIn});

  factory PersonDTO.fromJson(Map<String, dynamic> json) {
    return PersonDTO(
      firstName: json['firstName'],
      domainName: json['domainName'],
      optIn: json['optIn'],
    );
  }

  Map toJson() {
    return {
      'firstName': firstName,
      'domainName': domainName,
      'optIn': optIn,
    };
  }
}

class TelephoneDTO {
  String countryCode;
  String contactNumber;

  TelephoneDTO({this.countryCode, this.contactNumber});

  factory TelephoneDTO.fromJson(Map<String, dynamic> json) {
    return TelephoneDTO(
      countryCode: json['countryCode'],
      contactNumber: json['contactNumber'],
    );
  }

  Map toJson() {
    return {
      'countryCode': countryCode,
      'contactNumber': contactNumber,
    };
  }
}

class EmailContactDTO {
  String emailAddress;

  EmailContactDTO({this.emailAddress});

  factory EmailContactDTO.fromJson(Map<String, dynamic> json) {
    return EmailContactDTO(
      emailAddress: json['emailAddress'],
    );
  }

  Map toJson() {
    return {
      'emailAddress': emailAddress,
    };
  }
}
