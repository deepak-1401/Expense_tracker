import 'package:budget_manager/theme/app_extra_colors.dart';
import 'package:budget_manager/theme/colours.dart';
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
    final extraColors =
        Theme.of(
              context,
            )
            .extension<
              AppExtraColors
            >()!;
    return AlertDialog(
      backgroundColor: const Color(
        0xFF161D47,
      ),
      title: Text(
        'Payment Method',
        style: TextStyle(
          color: Theme.of(
            context,
          ).colorScheme.primary,
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
                  ? Theme.of(
                      context,
                    ).colorScheme.primary
                  : extraColors.filledColor,
              child: InkWell(
                onTap: () {
                  setState(
                    () {
                      selectedPayment = 'Credit Card';
                    },
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.credit_card,
                    color: extraColors.iconColor,
                  ),
                  title: Text(
                    'Credit Card',
                    style: TextStyle(
                      color: extraColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color:
                  selectedPayment ==
                      "Cash"
                  ? Theme.of(
                      context,
                    ).colorScheme.primary
                  : extraColors.filledColor,
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
                    color: extraColors.iconColor,
                  ),
                  title: Text(
                    'Cash',
                    style: TextStyle(
                      color: extraColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color:
                  selectedPayment ==
                      "UPI"
                  ? Theme.of(
                      context,
                    ).colorScheme.primary
                  : extraColors.filledColor,
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
                    color: extraColors.iconColor,
                  ),
                  title: Text(
                    'UPI',
                    style: TextStyle(
                      color: extraColors.textPrimary,
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

                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: extraColors.textPrimary,
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
