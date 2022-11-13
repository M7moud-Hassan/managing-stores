import 'package:flutter/material.dart';
import 'package:mustafa/core/themes/app_theme.dart';
import 'package:mustafa/features/data_market/presentation/pages/data_grid_view.dart';
import 'package:mustafa/features/invoice/domain/entities/bill_holder.dart';

import 'download_btn.dart';

const double CIRCULAR_BORDER = 25;
const double MARGIN_DATE = 100;

class ItemListView extends StatelessWidget {
  ItemListView({super.key, this.date, this.billHolder, required this.path});
  String? date;
  String? path;
  BillHolder? billHolder;
  factory ItemListView.ShowDate(String date, String path) {
    return ItemListView(
      date: date,
      path: path,
    );
  }
  factory ItemListView.showBillHolder(BillHolder billHolder, String path) {
    return ItemListView(
      billHolder: billHolder,
      path: path,
    );
  }
  @override
  Widget build(BuildContext context) {
    return date != null ? _showDate(context) : _showHolder();
  }

  Widget _showHolder() {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          billHolder!.name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Expanded(
                child: Text(
              '${billHolder!.address}',
              overflow: TextOverflow.ellipsis,
            )),
            Expanded(
                child: Text(
              '${billHolder!.phone}',
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        trailing: DownloadBtnWidget(
          path: '$path/${billHolder!.fileName}',
          billHolder: billHolder!,
        ),
      ),
    );
  }

  Widget _showDate(BuildContext context) => Container(
        margin: EdgeInsets.only(
            right: MARGIN_DATE,
            left: MARGIN_DATE,
            top: PADDING,
            bottom: PADDING),
        padding: EdgeInsets.all(PADDING),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CIRCULAR_BORDER),
            color: primaryColor),
        child: Center(
            child: Text(
          date!,
          style: Theme.of(context).textTheme.titleLarge,
        )),
      );
}
