import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

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
      try {
        firebaseFirestore
            .collection(itemModel.catalogue)
            .add(itemModel.toJson());
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
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
        QuerySnapshot<Map<String, dynamic>> result =
            await firebaseFirestore.collection(catalogue).get();
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
}
