 

import 'package:vr_wedding_rental/core/di/injectors.dart';
import 'package:vr_wedding_rental/core/shr_pref/datasource/preference_data_source.dart';

class PreferencesRepository {
  final _preferencesDataSource = serviceLocator<PreferencesDataSource>();

  //-------------------------Bool-----------------------------------------------
  //-----------On-Boarding-Screen-----------------------------------------------
  Future<bool> hasSeenOnboarding() async {
    return _preferencesDataSource.getBool('hasSeenOnboarding');
  }

  Future<void> setHasSeenOnboarding(bool value) async {
    return _preferencesDataSource.setBool('hasSeenOnboarding', value);
  }

  //-----------After-Auth-Category-Selection------------------------------------
  Future<bool> hasSeenCategory() async {
    return _preferencesDataSource.getBool('hasSeenCategory');
  }

  Future<void> setHasSeenCategory(bool value) async {
    return _preferencesDataSource.setBool('hasSeenCategory', value);
  }

  //-----------Home-Screen------------------------------------------------------
  Future<bool> hasSeenHome() async {
    return _preferencesDataSource.getBool('hasSeenHome');
  }

  Future<void> setHasSeenHome(bool value) async {
    return _preferencesDataSource.setBool('hasSeenHome', value);
  }

  //-------------------------List-----------------------------------------------
  Future<List<String>> saveSelectCategoryName() async {
    return _preferencesDataSource.getList('selectUser');
  }

  Future<void> setHasSeenUserId(List<String> value) async {
    /*
    log("Start- shared");
    if (value.isNotEmpty) {
      for (int i = 0; i < value.length; i++) {
        log(value[i]);
      }
    }
    log("End- shared");
    */

    return _preferencesDataSource.saveList('selectUser', []);
  }

  //-------------------------String---------------------------------------------
  Future<void> setDataFn(String value) async {
    return _preferencesDataSource.saveData('categoryName', value);
  }

  Future<String?> getDataFn() async {
    return _preferencesDataSource.getData('categoryName');
  }

  Future<void> clearCategoryName() async {
    await _preferencesDataSource.clearFromPreferences('categoryName');
  }

  //-------------------------Remove---------------------------------------------
  Future<void> clearAllPref() async {
    await _preferencesDataSource.removeData();
  }
}
