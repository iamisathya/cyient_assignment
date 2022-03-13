// ignore_for_file: constant_identifier_names

enum DataState {
  UNINITIALISED,
  INITIAL_FETCHING,
  MORE_FETCHING,
  FETCHED,
  NO_MORE_DATA,
  ERROR
}

enum UserState {
  UNINITIALISED,
  FETCHING,
  FETCHED,
  ERROR
}

enum CreatePostState {
  UNINITIALISED,
  CREATING,
  CREATED,
  ERROR
}

enum UpdatePostState {
  UNINITIALISED,
  UPDATING,
  UPDATED,
  ERROR
}

