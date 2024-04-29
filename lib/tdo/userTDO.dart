class UserTDO {

  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  String token = "";
  String address = "";
  int auth = 0;
  int admin = 0;


  UserTDO(userData) {
    name = userData['name'] ?? "";
    email = userData['email'] ?? "";
    password = userData['password'] ?? "";
    phone = userData['phone'] ?? "";
    token = userData['token'] ?? "";
    auth = userData['auth'] ?? 0;
    admin = userData['admin'] ?? 0;
    address = userData['address'] ?? '';
  }

  String getName() {
    return name;
  }

  void setName(String newName) {
    name = newName;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String newEmail) {
    email = newEmail;
  }

  String getPassword() {
    return password;
  }

  void setPassword(String newPassword) {
    password = newPassword;
  }

  String getPhone() {
    return phone;
  }

  void setPhone(String newPhone) {
    phone = newPhone;
  }

  String getToken() {
    return token;
  }

  void setToken(String newToken) {
    token = newToken;
  }

  int getAuth() {
    return auth;
  }

  void setAuth(int newAuth) {
    auth = newAuth;
  }

  int getAdmin() {
    return admin;
  }

  void setAdmin(int newAdmin) {
    admin = newAdmin;
  }

  String getAddress() {
    return  address;
  }

  void setAddress(String newAddress) {
    address = newAddress;
  }
}