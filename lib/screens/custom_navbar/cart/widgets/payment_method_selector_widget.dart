import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

class PaymentMethodSelectorWidget extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const PaymentMethodSelectorWidget({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged("cash"),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: selected == "cash"
                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                    : const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected == "cash"
                      ? AppColors.primaryColor
                      : const Color(0xFF2A2A2A),
                  width: selected == "cash" ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.money,
                    color: selected == "cash"
                        ? AppColors.primaryColor
                        : Colors.white54,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        color: selected == "cash"
                            ? AppColors.primaryColor
                            : Colors.white54,
                        fontSize: 13,
                        fontWeight: selected == "cash"
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (selected == "cash")
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged("stripe"),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: selected == "stripe"
                    ? AppColors.primaryColor.withValues(alpha: 0.15)
                    : const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected == "stripe"
                      ? AppColors.primaryColor
                      : const Color(0xFF2A2A2A),
                  width: selected == "stripe" ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: selected == "stripe"
                        ? AppColors.primaryColor
                        : Colors.white54,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Stripe",
                      style: TextStyle(
                        color: selected == "stripe"
                            ? AppColors.primaryColor
                            : Colors.white54,
                        fontSize: 13,
                        fontWeight: selected == "stripe"
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (selected == "stripe")
                    Icon(
                      Icons.check_circle,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
