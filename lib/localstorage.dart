import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
 static setPostData(String tokenData)async{
    SharedPreferences storage=await SharedPreferences.getInstance();
    storage.setString("store", tokenData);

  }
 static Future<String?>getData()async{
    SharedPreferences storage=await SharedPreferences.getInstance();
   return storage.getString("store")??"";

  }
 static deleteData()async{
    SharedPreferences storage=await SharedPreferences.getInstance();
    storage.remove("store");

}
}