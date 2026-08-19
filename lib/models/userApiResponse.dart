// GENERATED CODE - DO NOT MODIFY BY HAND

class UserApiResponse {

  final List<User>? users;
  final int? total;
  final int? skip;
  final int? limit;

  UserApiResponse({
    this.users,
    this.total,
    this.skip,
    this.limit,
  });


  factory UserApiResponse.fromJson(Map<String, dynamic> json) {
    return UserApiResponse(
      users: (json['users'] as List?)
          ?.map(
            (e) => User.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList()
,
      total: json['total'] as int?,
      skip: json['skip'] as int?,
      limit: json['limit'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users?.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}

class User {

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final UserHair? hair;
  final String? ip;
  final UserAddress? address;
  final String? macAddress;
  final String? university;
  final UserBank? bank;
  final UserCompany? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final UserCrypto? crypto;
  final String? role;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      maidenName: json['maidenName'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      birthDate: json['birthDate'] as String?,
      image: json['image'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      eyeColor: json['eyeColor'] as String?,
      hair: json['hair'] == null
          ? null
          : UserHair.fromJson(
              json['hair'] as Map<String, dynamic>,
            )
,
      ip: json['ip'] as String?,
      address: json['address'] == null
          ? null
          : UserAddress.fromJson(
              json['address'] as Map<String, dynamic>,
            )
,
      macAddress: json['macAddress'] as String?,
      university: json['university'] as String?,
      bank: json['bank'] == null
          ? null
          : UserBank.fromJson(
              json['bank'] as Map<String, dynamic>,
            )
,
      company: json['company'] == null
          ? null
          : UserCompany.fromJson(
              json['company'] as Map<String, dynamic>,
            )
,
      ein: json['ein'] as String?,
      ssn: json['ssn'] as String?,
      userAgent: json['userAgent'] as String?,
      crypto: json['crypto'] == null
          ? null
          : UserCrypto.fromJson(
              json['crypto'] as Map<String, dynamic>,
            )
,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'maidenName': maidenName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'birthDate': birthDate,
      'image': image,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hair': hair?.toJson(),
      'ip': ip,
      'address': address?.toJson(),
      'macAddress': macAddress,
      'university': university,
      'bank': bank?.toJson(),
      'company': company?.toJson(),
      'ein': ein,
      'ssn': ssn,
      'userAgent': userAgent,
      'crypto': crypto?.toJson(),
      'role': role,
    };
  }
}

class UserHair {

  final String? color;
  final String? type;

  UserHair({
    this.color,
    this.type,
  });


  factory UserHair.fromJson(Map<String, dynamic> json) {
    return UserHair(
      color: json['color'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'type': type,
    };
  }
}

class UserAddress {

  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final UserAddressCoordinates? coordinates;
  final String? country;

  UserAddress({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });


  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      stateCode: json['stateCode'] as String?,
      postalCode: json['postalCode'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : UserAddressCoordinates.fromJson(
              json['coordinates'] as Map<String, dynamic>,
            )
,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'stateCode': stateCode,
      'postalCode': postalCode,
      'coordinates': coordinates?.toJson(),
      'country': country,
    };
  }
}

class UserAddressCoordinates {

  final double? lat;
  final double? lng;

  UserAddressCoordinates({
    this.lat,
    this.lng,
  });


  factory UserAddressCoordinates.fromJson(Map<String, dynamic> json) {
    return UserAddressCoordinates(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class UserBank {

  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  UserBank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });


  factory UserBank.fromJson(Map<String, dynamic> json) {
    return UserBank(
      cardExpire: json['cardExpire'] as String?,
      cardNumber: json['cardNumber'] as String?,
      cardType: json['cardType'] as String?,
      currency: json['currency'] as String?,
      iban: json['iban'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardExpire': cardExpire,
      'cardNumber': cardNumber,
      'cardType': cardType,
      'currency': currency,
      'iban': iban,
    };
  }
}

class UserCompany {

  final String? department;
  final String? name;
  final String? title;
  final UserCompanyAddress? address;

  UserCompany({
    this.department,
    this.name,
    this.title,
    this.address,
  });


  factory UserCompany.fromJson(Map<String, dynamic> json) {
    return UserCompany(
      department: json['department'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      address: json['address'] == null
          ? null
          : UserCompanyAddress.fromJson(
              json['address'] as Map<String, dynamic>,
            )
,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'department': department,
      'name': name,
      'title': title,
      'address': address?.toJson(),
    };
  }
}

class UserCompanyAddress {

  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final UserCompanyAddressCoordinates? coordinates;
  final String? country;

  UserCompanyAddress({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });


  factory UserCompanyAddress.fromJson(Map<String, dynamic> json) {
    return UserCompanyAddress(
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      stateCode: json['stateCode'] as String?,
      postalCode: json['postalCode'] as String?,
      coordinates: json['coordinates'] == null
          ? null
          : UserCompanyAddressCoordinates.fromJson(
              json['coordinates'] as Map<String, dynamic>,
            )
,
      country: json['country'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'stateCode': stateCode,
      'postalCode': postalCode,
      'coordinates': coordinates?.toJson(),
      'country': country,
    };
  }
}

class UserCompanyAddressCoordinates {

  final double? lat;
  final double? lng;

  UserCompanyAddressCoordinates({
    this.lat,
    this.lng,
  });


  factory UserCompanyAddressCoordinates.fromJson(Map<String, dynamic> json) {
    return UserCompanyAddressCoordinates(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class UserCrypto {

  final String? coin;
  final String? wallet;
  final String? network;

  UserCrypto({
    this.coin,
    this.wallet,
    this.network,
  });


  factory UserCrypto.fromJson(Map<String, dynamic> json) {
    return UserCrypto(
      coin: json['coin'] as String?,
      wallet: json['wallet'] as String?,
      network: json['network'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coin': coin,
      'wallet': wallet,
      'network': network,
    };
  }
}

