class AllCourseModel {
  final int id;
  final String course;

  AllCourseModel({ required this.id, required this.course});

  factory AllCourseModel.fromJson(Map<String, dynamic> json) {
    return AllCourseModel(
      id: json['id'],
      course: json['course'],
    );
  }
}

class MyCourseModel {
  final int id;
  final String course;

  MyCourseModel({ required this.id, required this.course});

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: json['id'],
      course: json['course'],
    );
  }
}