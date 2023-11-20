import 'package:flutter/material.dart';

class AddressChip extends StatelessWidget {
  final ValueChanged<bool>? onSelected;
  final bool? selected;

  const AddressChip({super.key, this.onSelected, this.selected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: const Text('Home'),
      onSelected: onSelected,
      selected: selected ?? false,
      color: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
      selectedColor: Theme.of(context).colorScheme.primary,
    );
  }
}
