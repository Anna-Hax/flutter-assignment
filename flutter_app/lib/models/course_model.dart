class AllCourseModel {
  final int id;
  final String name;

  AllCourseModel({
    required this.id,
    required this.name,
  });

  factory AllCourseModel.fromJson(Map<String, dynamic> json) {
    return AllCourseModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}

class MyCourseModel {
  final int id;
  final String name;

  MyCourseModel({
    required this.id,
    required this.name,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}