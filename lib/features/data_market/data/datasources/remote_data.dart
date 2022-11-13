import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../../invoice/domain/entities/bill.dart';

const COLLECTION_1 = "cataloguse";

const COLLECTION_2 = "items";
const NOT_FOUND = "not-found";

abstract class ItemRemoteData {
  Future<Unit> insert(ItemModel itemModel);
  Future<Unit> delete(ItemModel itemModel);
  Future<Unit> update(ItemModel itemModel);
  Future<Unit> updateForInvoice(Bill bill);
  Future<List<ItemModel>> getAllItems(String catalogue);
}

class ItemRemoteDataImp extends ItemRemoteData {
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;
  List<ItemModel> _items = [];
  ItemRemoteDataImp(
      {required this.firebaseFirestore, required this.networkInfo});
  @override
  Future<Unit> insert(ItemModel itemModel) async {
    if (await networkInfo.isConnected) {
      if (await _checkExists(itemModel)) {
        try {
          firebaseFirestore
              .collection(COLLECTION_1)
              .doc(itemModel.catalogue)
              .collection(COLLECTION_2)
              .add(itemModel.toJson());
          return Future.value(unit);
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ItemExistsException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> update(ItemModel itemModel) async {
    if (await networkInfo.isConnected) {
      if (!await _checkForUpdate(itemModel)) {
        try {
          await firebaseFirestore
              .collection(COLLECTION_1)
              .doc(itemModel.catalogue)
              .collection(COLLECTION_2)
              .doc(itemModel.id)
              .update(itemModel.toJson());
          return Future.value(unit);
        } on PlatformException {
          throw ItemExistsException();
        } catch (e) {
          throw ServerException();
        }
      } else {
        throw ItemExistsException();
      }
      // await delete(itemModel);
      //await insert(itemModel);
      //return Future.value(unit);
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> delete(ItemModel itemModel) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseFirestore
            .collection(COLLECTION_1)
            .doc(itemModel.catalogue)
            .collection(COLLECTION_2)
            .doc(itemModel.id)
            .delete();
        return Future.value(unit);
      } on FirebaseException catch (e) {
        if (e.code == NOT_FOUND) {
          throw ItemExistsException();
        } else {
          throw ServerException();
        }
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<List<ItemModel>> getAllItems(String catalogue) async {
    _items = [];
    if (await networkInfo.isConnected) {
      try {
        QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
            .collection(COLLECTION_1)
            .doc(catalogue)
            .collection(COLLECTION_2)
            .get();
        for (var element in result.docs) {
          _items.add(ItemModel.fromJson(element.data(), catalogue, element.id));
        }
        return _items;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  Future<bool> _checkExists(ItemModel itemModel) async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await firebaseFirestore
          .collection(COLLECTION_1)
          .doc(itemModel.catalogue)
          .collection(COLLECTION_2)
          .where("name", isEqualTo: itemModel.name)
          .get();

      return query.docChanges.isEmpty;
    } catch (e) {
      throw ServerException();
    }
  }

  Future<bool> _checkForUpdate(ItemModel itemModel) async {
    QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
        .collection(COLLECTION_1)
        .doc(itemModel.catalogue)
        .collection(COLLECTION_2)
        .where("name", isEqualTo: itemModel.name)
        .get();
    if (result.docs.isEmpty) {
      return false;
    } else {
      ItemModel itemModel1 = ItemModel.fromJson(
          result.docs.first.data(), itemModel.catalogue, result.docs.first.id);
      return !(itemModel1.id == itemModel.id);
    }
  }

  late ItemModel itemModel;
  late DocumentSnapshot<Map<String, dynamic>> result;
  int count = 0;
  @override
  Future<Unit> updateForInvoice(Bill bill) async {
    //ItemModel(ملح, منتجات غذائية, 99, 2.0, MOpbxJJ04RjJXLzWxERw)
    if (await networkInfo.isConnected) {
      try {
        result = await firebaseFirestore
            .collection(COLLECTION_1)
            .doc(bill.item.catalogue)
            .collection(COLLECTION_2)
            .doc(bill.item.id)
            .get();
        itemModel = ItemModel.fromJson(
            result.data()!, bill.item.catalogue, bill.item.id);
        count = itemModel.count;
        count -= bill.count;
        if (count < 0) throw ItemCountNotenoughException();
        itemModel.count = count;
        await firebaseFirestore
            .collection(COLLECTION_1)
            .doc(itemModel.catalogue)
            .collection(COLLECTION_2)
            .doc(itemModel.id)
            .update(itemModel.toJson());
        return Future.value(unit);
      } on PlatformException {
        throw ItemExistsException();
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }
}
