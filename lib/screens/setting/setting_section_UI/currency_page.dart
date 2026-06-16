import 'package:budget_manager/data/currencies_data.dart';
import 'package:flutter/material.dart';

class CurrencyPage
    extends
        StatefulWidget {
  const CurrencyPage({
    super.key,
  });

  @override
  State<
    CurrencyPage
  >
  createState() => _CurrencyPageState();
}

class _CurrencyPageState
    extends
        State<
          CurrencyPage
        > {
  String selectedCurrencyCode = "INR";

  @override
  Widget build(
    BuildContext context,
  ) {
    return AlertDialog(
      backgroundColor: const Color(
        0xFF161D47,
      ),
      title: const Text(
        'Currency',
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 350,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(
              0xFF0F1330,
            ),
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          child: ListView.separated(
            itemCount: CurrencyData.currencies.length,
            itemBuilder:
                (
                  context,
                  index,
                ) {
                  final currency = CurrencyData.currencies[index];
                  final bool isSelected =
                      currency['code'] ==
                      selectedCurrencyCode;

                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      leading: Text(
                        currency['symbol']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      title: Text(
                        currency['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        currency['code']!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: Color(
                                0xFF9B4EFF,
                              ),
                            )
                          : null,

                      onTap: () {
                        setState(
                          () {
                            selectedCurrencyCode = currency['code']!;
                          },
                        );

                        Navigator.pop(
                          context,
                          currency,
                        );
                      },
                    ),
                  );
                },
            separatorBuilder:
                (
                  BuildContext context,
                  int index,
                ) {
                  return const Divider(
                    color: Color(
                      0xFF252B5C,
                    ),
                    thickness: 2.5,
                    indent: 20,
                    endIndent: 20,
                  );
                },
          ),
        ),
      ),
    );
  }
}
