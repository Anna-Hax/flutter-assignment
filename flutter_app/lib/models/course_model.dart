class CourseModel {
  final int id;
  final String course;

  CourseModel({ required this.id, required this.course});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      course: json['course'],
    );
  }
}