import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/core/network/network_info.dart';
import 'package:mustafa/features/catalogue/data/models/model_catalogue.dart';

abstract class LocalDataCatalogue {
  Future<Unit> add(ModelCatalogue modelCatalogue);
  Future<List<ModelCatalogue>> getAll();
}

class LocalDataCatalogueImp implements LocalDataCatalogue {
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;
  LocalDataCatalogueImp({
    required this.firebaseFirestore,
    required this.networkInfo,
  });

  @override
  Future<Unit> add(ModelCatalogue modelCatalogue) async {
    if (await networkInfo.isConnected) {
      try {
        await firebaseFirestore
            .collection("cataloguse")
            .add(modelCatalogue.toJson());
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<List<ModelCatalogue>> getAll() async {
    List<ModelCatalogue> listCatalogues = [];
    if (await networkInfo.isConnected) {
      try {
        QuerySnapshot<Map<String, dynamic>> result =
            await firebaseFirestore.collection("cataloguse").get();
        for (var element in result.docChanges) {
          listCatalogues.add(
              ModelCatalogue.fromJson(element.doc.data()!, element.doc.id));
        }
        return listCatalogues;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }
}
