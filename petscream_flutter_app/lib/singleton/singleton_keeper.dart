class SingletonKeeper {
  static String _token=null;
  static final SingletonKeeper _singleton = SingletonKeeper._internal();

  factory SingletonKeeper() {
    return _singleton;
  }

  SingletonKeeper._internal();

  static void SetToken(String token){
    _token=token;
  }

  static bool IsLogged(){
    return _token!=null;
  }
}