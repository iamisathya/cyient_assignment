class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // user endpoints
  static const String getUsers = baseUrl + "/users";
}