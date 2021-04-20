class SingletonKeeper {
  static String _token=null;
  static String _email=null;
  static final SingletonKeeper _singleton = SingletonKeeper._internal();

  factory SingletonKeeper() {
    return _singleton;
  }

  SingletonKeeper._internal();

  static void SetToken(String token,String email){
    _token=token;
    _email=email;
  }
  static String GetToken(){
    return _token;
  }
  static bool IsLogged(){
    return _token!=null;
  }
  static String GetEmail(){
    return _email;
  }
}