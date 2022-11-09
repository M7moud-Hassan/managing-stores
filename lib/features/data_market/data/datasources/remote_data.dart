import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

const COLLECTION_1 = "cataloguse";

const COLLECTION_2 = "items";

abstract class ItemRemoteData {
  Future<Unit> insert(ItemModel itemModel);
  Future<Unit> delete(ItemModel itemModel);
  Future<Unit> update(ItemModel itemModel);
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
      if (!await _checkExists(itemModel.name, itemModel.catalogue)) {
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
      try {
        firebaseFirestore
            .collection(itemModel.catalogue)
            .doc(itemModel.id)
            .update(itemModel.toJson());
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> delete(ItemModel itemModel) async {
    if (await networkInfo.isConnected) {
      try {
        firebaseFirestore
            .collection(itemModel.catalogue)
            .doc(itemModel.id)
            .delete();
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<List<ItemModel>> getAllItems(String catalogue) async {
    if (await networkInfo.isConnected) {
      try {
        QuerySnapshot<Map<String, dynamic>> result = await firebaseFirestore
            .collection(COLLECTION_1)
            .doc(catalogue)
            .collection(COLLECTION_2)
            .get();
        for (var element in result.docChanges) {
          _items.add(ItemModel.fromJson(
              element.doc.data()!, catalogue, element.doc.id));
        }
        return _items;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  Future<bool> _checkExists(name, docId) async {
    try {
      AggregateQuerySnapshot query = await firebaseFirestore
          .collection(COLLECTION_1)
          .doc(docId)
          .collection(COLLECTION_2)
          .where("name", isEqualTo: name)
          .count()
          .get();

      return query.count > 0;
    } catch (e) {
      throw ServerException();
    }
  }
}
