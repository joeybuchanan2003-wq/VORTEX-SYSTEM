class Attribute {
  String name;
  int value;
  Attribute({required this.name, this.value = 10});

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    name: json['name'],
    value: json['value'],
  );

  Map<String, dynamic> toJson() => {'name': name, 'value': value};
}