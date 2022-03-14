List processData(List responses) {
  List<dynamic> result = responses[0]
      .map((post) => {
            'id': post['id'],
            'userId': post['userId'],
            'title': post['title'],
            'body': post['body'],
            'userName': responses[1]
                    .where((user) => user['id'] == post['userId'])
                    ?.first['username'] ??
                ''
          })
      .toList();
  return result;
}
