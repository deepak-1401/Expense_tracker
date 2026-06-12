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
  String selectedPayment = "";
  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor: const Color(
        0xFF161D47,
      ),
      title: const Text(
        'Payment Method',
        style: TextStyle(
          color: Color(
            0xFF8B4CFF,
          ),
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color:
                  selectedPayment ==
                      "Credit Card"
                  ? Color(
                      0xFF8B4CFF,
                    )
                  : Color(
                      0xFF0F1330,
                    ),
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      selectedPayment = 'Credit Card';
                    },
                  );
                },
                child: const ListTile(
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
              color:
                  selectedPayment ==
                      "Cash"
                  ? Color(
                      0xFF8B4CFF,
                    )
                  : Color(
                      0xFF0F1330,
                    ),
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      selectedPayment = 'Cash';
                    },
                  );
                },
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
            ),
            Card(
              color:
                  selectedPayment ==
                      "UPI"
                  ? Color(
                      0xFF8B4CFF,
                    )
                  : Color(
                      0xFF0F1330,
                    ),
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      selectedPayment = 'UPI';
                    },
                  );
                },
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
            ),
            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(
                        context,
                      ).colorScheme.tertiary,
                      Theme.of(
                        context,
                      ).colorScheme.secondary,
                      Theme.of(
                        context,
                      ).colorScheme.primary,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    60,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color(
                            0xFF8B5CF6,
                          ).withValues(
                            alpha: 0.35,
                          ),
                      blurRadius: 15,
                      offset: Offset(
                        0,
                        6,
                      ),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),

                  onPressed: () {
                    Navigator.pop(
                      context,
                      selectedPayment,
                    );
                  },

                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
