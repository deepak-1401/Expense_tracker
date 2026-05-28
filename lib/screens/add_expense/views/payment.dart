import 'package:flutter/material.dart';

class Payment
    extends
        StatefulWidget {
  const Payment({
    super.key,
  });

  @override
  State<
    Payment
  >
  createState() => _PaymentState();
}

class _PaymentState
    extends
        State<
          Payment
        > {
  @override
  Widget build(
    BuildContext context,
  ) {
    return const AlertDialog(
      backgroundColor: Color(
        0xFF070B2C,
      ),
      title: Text(
        'Payment Method',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Padding(
        padding: EdgeInsets.all(
          8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: Color(
                0xFF161D47,
              ),
              child: InkWell(
                 onTap: ,
                child: ListTile(
                  leading: Icon(
                    Icons.credit_card,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Credit Card',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Color(
                0xFF161D47,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                title: Text(
                  'Cash',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Card(
              color: Color(
                0xFF161D47,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.payments,
                  color: Colors.white,
                ),
                title: Text(
                  'UPI',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
