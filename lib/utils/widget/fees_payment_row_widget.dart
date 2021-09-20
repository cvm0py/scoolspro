// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:infixedu/utils/model/Fee.dart';

import '../Utils.dart';

// ignore: must_be_immutable
class FeePaymentRow extends StatelessWidget {
  String dueDate = 'Due Date';
  String amount = 'Amount';
  String paid = 'Paid';
  String balance = 'Balance';

  @override
  void initState() {
    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage('Due Date', language).then((val) {
        dueDate = val;
      });

      Utils.getTranslatedLanguage(language, "Amount").then((val) {
        amount = val;
      });

      Utils.getTranslatedLanguage(language, "Paid").then((val) {
        paid = val;
      });

      Utils.getTranslatedLanguage(language, "Balance").then((val) {
        amount = val;
      });
    });
  }

  Fee fee;
  FeePaymentRow(this.fee);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  fee.title,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        dueDate,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        fee.dueDate,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        amount,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '\$' + fee.amount,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        paid,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '\$' + fee.paid,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        balance,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '\$' + fee.balance,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
