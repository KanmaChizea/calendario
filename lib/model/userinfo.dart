class UserInformation {
  final List? courses;
  final String test;
  final String assignment;
  final String tutorial;
  final String? role;

  UserInformation(
      {this.courses,
      this.role,
      required this.test,
      required this.assignment,
      required this.tutorial});
}
