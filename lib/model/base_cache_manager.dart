import 'package:farmsoftnew/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'animal_model.dart';

final BaseCacheManager<UserModel> cachemanager = BaseCacheManager<UserModel>(CacheBoxNames.loggeduser);
final BaseCacheManager<AnimalModel> cachemanageranimal = BaseCacheManager<AnimalModel>(CacheBoxNames.animalrfid);

class BaseCacheManager<T> {
  Box<T>? _box;
  final CacheBoxNames boxName;

  BaseCacheManager(this.boxName)
  {
    openBox();
  }

  Future<void> openBox() async {
    registerAdaptor();
    if (!(_box?.isOpen ?? false)) {
      _box = await Hive.openBox<T>(boxName.name);
    }
  }

  registerAdaptor() {
    Hive.registerAdapter(UserModelAdapter());
  }

  Future<void> updateItem(dynamic key, T val) async {
    await _box?.put(key, val);
  }

  T? getItem(dynamic key) {
    return _box?.get(key);
  }

  List<T>? getAllItems() {
    return _box?.values.toList();
  }

  saveItem(T? item) {
    if (item != null) {
      _box?.add(item);
    }
  }

  saveAllItems(List<T>? items) {
    if (items != null) {
      _box?.addAll(items);
    }
  }
}
enum CacheBoxNames { loggeduser, animalrfid }