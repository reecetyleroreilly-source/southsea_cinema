class UserSettings {
  final String name;
  final String address;
  final String email;
  final bool recieveNewsletter;

  const UserSettings({
    this.name = '',
    this.address = '',
    this.email = '',
    this.recieveNewsletter = false,
  });
}
