class ChangePassword {
  final String username;
  final String oldPassword;
  final String newPassword;

  ChangePassword({required this.username, required this.oldPassword, required this.newPassword});

  Map<String, dynamic> toJson() => {
        "username": username,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      };
}