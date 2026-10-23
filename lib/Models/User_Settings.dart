class UserSettings {
  final String name;
  final String address;
  final String email;
  final bool receiveMovieTicket;

  const UserSettings({
    this.name = '',
    this.address = '',
    this.email = '',
    this.receiveMovieTicket = false,
  });
}
