import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_strings.dart';

class AddRemoveWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const AddRemoveWidget({
    Key? key,
    required this.quantity,
    this.onAdd,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return quantity == 0
        ? TextButton.icon(
            style: ButtonStyle(
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    12.r,
                  ),
                ),
              ),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll(
                Colors.white12,
              ),
            ),
            onPressed: onAdd,
            icon: Icon(
              Icons.add,
              size: 16.r,
              color: Colors.white,
            ),
            label: Text(
              AppStrings.add,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          )
        : AnimatedSize(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInExpo,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(
                  12.r,
                ), // Border radius
              ),
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      Icons.remove,
                      size: 16.r,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: Icon(
                      Icons.add,
                      size: 16.r,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
