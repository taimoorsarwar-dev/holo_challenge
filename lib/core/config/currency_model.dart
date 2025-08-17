class CurrencyModel {
  String? id;
  String? code;
  String? label;
  String? name;
  bool? isDefault;

  CurrencyModel({this.id, this.code, this.label, this.name, this.isDefault});

  CurrencyModel.empty();

  String? displayName() {
    return code;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "label": label,
      "name": name,
      "isDefault": isDefault,
    };
  }

  fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    code = json['code'] as String;
    label = json['label'] as String;
    name = json['name'] as String;
    isDefault = json['isDefault'] as bool;
  }
}
