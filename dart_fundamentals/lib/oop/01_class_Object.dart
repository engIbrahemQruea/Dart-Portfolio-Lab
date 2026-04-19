class ClsPerson {
  final String firstName;
  final String lastName;

  String get fullName => "$firstName $lastName";

  const ClsPerson(this.firstName, this.lastName);

  ClsPerson.geust() : firstName = 'IbrahimG', lastName = 'Al-QureaA';
} 

void main() {
  var person = const ClsPerson('Ibrahim', 'Al-Qurea');
  print(person.fullName);

  print("Hello Dart");
}
