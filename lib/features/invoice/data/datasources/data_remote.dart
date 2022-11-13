import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mustafa/core/error/exceptions.dart';
import 'package:mustafa/core/network/network_info.dart';
import 'package:mustafa/features/catalogue/data/datasources/local_data_catalogues.dart';
import 'package:mustafa/features/data_market/data/datasources/remote_data.dart';
import 'package:mustafa/features/data_market/data/models/item_model.dart';
import 'package:mustafa/features/invoice/data/models/model_catalogue_data.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';

const String BILLHOLLDERCOL = "BillHolder";

abstract class DataRemote {
  Future<List<ModelCatalogueData>> read();
  Future<Unit> uploadInvoice(String path, BillHolder billHolder);
  Future<Unit> addBillHolder(BillHolder billHolder);
  Future<List<BillHolder>> getBillHolders();
  Future<Unit> downloadInvoice(String path, BillHolder billHolder);
}

const INDEX_JSON_CATALOGUE_NAME = "name";
const INVOICES = "invoces";

class DataRemoteImp extends DataRemote {
  final FirebaseFirestore firebaseFirestore;
  final NetworkInfo networkInfo;
  final FirebaseStorage firebaseStorage;
  late QuerySnapshot<Map<String, dynamic>> result1, result2;
  late List<ModelCatalogueData> _data;
  late List<ItemModel> _itemModels;
  late List<BillHolder> billHolders;
  late DateTime dateTime;

  DataRemoteImp({
    required this.firebaseFirestore,
    required this.networkInfo,
    required this.firebaseStorage,
  });
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

  @override
  Future<Unit> uploadInvoice(String path, BillHolder billHolder) async {
    if (await networkInfo.isConnected) {
      try {
        billHolder.fileName = path.split("/")[path.split("/").length - 1];
        dateTime = DateTime.parse(
            billHolder.fileName!.replaceAll(".pdf", "").split("_")[1]);
        billHolder.dateDay =
            "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        await addBillHolder(billHolder);
        await firebaseStorage
            .ref()
            .child('$INVOICES/${billHolder.fileName}')
            .putFile(File(path));
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  @override
  Future<Unit> addBillHolder(BillHolder billHolder) async {
    try {
      await firebaseFirestore
          .collection(BILLHOLLDERCOL)
          .add(billHolder.toJson());
      return Future.value(unit);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<BillHolder>> getBillHolders() async {
    billHolders = [];
    if (await networkInfo.isConnected) {
      try {
        result1 = await firebaseFirestore
            .collection(BILLHOLLDERCOL)
            .orderBy("dateDay")
            .get();
        for (var element in result1.docs) {
          billHolders.add(BillHolder.fromJson(element.data()));
        }
        return billHolders;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }

  late Reference reference;
  late File file;
  @override
  Future<Unit> downloadInvoice(String path, BillHolder billHolder) async {
    if (await networkInfo.isConnected) {
      try {
        reference = firebaseStorage.ref(INVOICES).child(billHolder.fileName!);
        file = File('$path/${billHolder.fileName}');
        await reference.writeToFile(file);
        return Future.value(unit);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw OfflineException();
    }
  }
}
