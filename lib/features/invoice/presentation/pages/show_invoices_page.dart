import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as df;
import 'package:mustafa/core/methods/app_util.dart';
import 'package:mustafa/core/widgets/divider.dart';
import 'package:mustafa/core/widgets/snack_bar.dart';
import 'package:mustafa/features/catalogue/presentation/pages/drawer_catalogue_page.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';
import 'package:mustafa/features/invoice/presentation/widgets/show_invoices_wigets/item_list_view.dart';

import '../bloc/show_all_invoices/show_all_invoices_bloc.dart';
import '../widgets/invoice_widgets/load_export_widget.dart';
import '../widgets/show_invoices_wigets/app_bar_widget.dart';
import '../widgets/show_invoices_wigets/but_filter_by_date.dart';

class ShowAllInvoicesPage extends StatefulWidget {
  const ShowAllInvoicesPage({super.key});

  @override
  State<ShowAllInvoicesPage> createState() => _ShowAllInvoicesPageState();
}

class _ShowAllInvoicesPageState extends State<ShowAllInvoicesPage> {
  late List<BillHolder> billHolders;
  late List<BillHolder> forFilter;
  bool awesomeDialogIshow = false;
  String dateSort = "";
  String path = "/data/user/0/apps.soonfu.mustafa/app_flutter";
  @override
  void initState() {
    super.initState();
    billHolders = [];
    forFilter = [];
    getpath();
  }

  getpath() async {
    path = await AppUtil.getPath();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        ShowAllInvoicesBloc.get(context).add(GettAllBillHoldersEvent());
        return Future.delayed(Duration(seconds: NUM_SECOND));
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButton: BtnFilterByDate(),
          appBar: appBarShowAllInvoice(context),
          body: BlocBuilder<ShowAllInvoicesBloc, ShowAllInvoicesState>(
            builder: (context, state) {
              if (state is StartGetAllBillHoldersState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  awesomeDialogIshow = true;
                  loadExportWidget(context).show();
                });
              } else if (state is GettAllBillHoldersStete) {
                billHolders = state.billHolders.reversed.toList();
                forFilter = billHolders;
                dateSort =
                    billHolders.isNotEmpty ? billHolders.first.dateDay! : "";
                if (awesomeDialogIshow) {
                  Navigator.pop(context);
                  awesomeDialogIshow = false;
                }
              } else if (state is ShowErrorGellBillsState) {
                if (awesomeDialogIshow) {
                  Navigator.pop(context);
                  awesomeDialogIshow = false;
                }
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  showErrorSnackBar(message: state.message, context: context);
                });
              } else if (state is StartFilterByDateState) {
                //loadExportWidget(context).show();
                DateTime dateTime;
                billHolders = [];
                print("start=>${state.pickerDateRange.startDate}");
                print("end=>${state.pickerDateRange.endDate}");
                for (BillHolder billHolder in forFilter) {
                  dateTime =
                      df.DateFormat("dd-MM-yyyy").parse(billHolder.dateDay!);
                  if ((dateTime.compareTo(state.pickerDateRange.startDate!) >=
                          0 &&
                      dateTime.compareTo(state.pickerDateRange.endDate!) <=
                          0)) {
                    billHolders.add(billHolder);
                  }
                }
                dateSort = billHolders.isNotEmpty
                    ? billHolders.first.dateDay!
                    : dateSort;
                //Navigator.pop(context);
              }
              return ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          ItemListView.ShowDate(dateSort, path),
                          ItemListView.showBillHolder(billHolders[index], path)
                        ],
                      );
                    } else {
                      return ItemListView.showBillHolder(
                          billHolders[index], path);
                    }
                  },
                  separatorBuilder: (context, index) {
                    if (index != billHolders.length - 1) {
                      if (billHolders[index + 1].dateDay != dateSort) {
                        dateSort = billHolders[index + 1].dateDay!;
                        return ItemListView.ShowDate(dateSort, path);
                      }
                    }
                    return myDivider;
                  },
                  itemCount: billHolders.length);
            },
          ),
        ),
      ),
    );
  }
}
