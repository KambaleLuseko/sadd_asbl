uuidGenerator() {
  return DateTime.now().microsecondsSinceEpoch.toRadixString(16);
  // return utf8
  //     .encode(
  //         "${DateTime.now().toString().replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "").replaceAll(".", "")}-${navKey.currentContext?.read<UserProvider>().userLogged?.user.id}")
  //     .map((e) => e.toRadixString(16))
  //     .join('');
}
