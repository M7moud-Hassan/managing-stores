import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/core/error/failures.dart';
import 'package:mustafa/core/network/network_info.dart';
import 'package:mustafa/features/catalogue/data/datasources/local_data_catalogues.dart';
import 'package:mustafa/features/catalogue/data/models/model_catalogue.dart';
import 'package:mustafa/features/catalogue/domain/entities/catalogue.dart';
import 'package:mustafa/features/data_market/data/datasources/remote_data.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';
import 'package:mustafa/features/invoice/data/models/model_catalogue_data.dart';

abstract class DataRemote {
  Future<List<ModelCatalogueData>> read();
}

const INDEX_JSON_CATALOGUE_NAME = "name";

class DataRemoteImp extends DataRemote {
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;
  late QuerySnapshot<Map<String, dynamic>> result1, result2;
  late List<ModelCatalogueData> _data;
  late List<ItemModel> _itemModels;

  DataRemoteImp({required this.firebaseFirestore, required this.networkInfo});
  @override
  Future<List<ModelCatalogueData>> read() async {
    _data = [];
    if (await networkInfo.isConnected) {
      try {
        result1 = await firebaseFirestore.collection(COLLECTION).get();
        for (var element in result1.docs) {
          _itemModels = [];
          result2 = await firebaseFirestore
              .collection(COLLECTION_1)
              .doc(element.id)
              .collection(COLLECTION_2)
              .get();
          for (var element2 in result2.docs) {
            _itemModels.add(
                ItemModel.fromJson(element2.data(), element.id, element2.id));
          }
          _data.add(ModelCatalogueData.create(
              element.data(), element.id, _itemModels));
        }
        return _data;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }
}
