class Country {
  String code='';
  String country='';
  String region='';

  Country({required this.code, required this.country, required this.region});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    country = json['country'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['country'] = this.country;
    data['region'] = this.region;
    return data;
  }
}