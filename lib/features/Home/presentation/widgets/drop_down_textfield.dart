import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hcs/src/theme/app_colors.dart';

class DropDownField extends StatefulWidget {
  const DropDownField({super.key});

  @override
  State<DropDownField> createState() => _DropDownFieldState();
}

class _DropDownFieldState extends State<DropDownField> {
  final List<String> _items = ['one', 'two'];
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selected,
      // isDense: true,
      borderRadius: BorderRadius.circular(8),
      elevation: 8,

      items: [
        // existing items
        for (var v in _items)
          DropdownMenuItem(
            value: v,
            child: Text(
              _capitalize(v),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),

        // divider
        DropdownMenuItem<String>(
          enabled: false,
          child: Divider(height: 0.5.h, color: AppColors.dividerGrey),
        ),

        // add-customer entry
        DropdownMenuItem<String>(
          value: '_add_',
          child: Text(
            '+ Add Customer',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
      decoration: InputDecoration(
        hintText: 'Name',
        isDense: true,
        // constraints: BoxConstraints.loose(Size(293.w, 213.h)),
        // styling via ThemeData.inputDecorationTheme
      ),
      style: Theme.of(context).inputDecorationTheme.hintStyle,
      onChanged: (v) async {
        if (v == '_add_') {
          final newName = await showDialog<String>(
            context: context,
            builder: (_) => const AddCustomerDialog(),
          );
          if (newName != null && newName.isNotEmpty) {
            setState(() {
              _items.add(newName);
              _selected = newName;
            });
          }
        } else {
          setState(() {
            _selected = v;
          });
        }
      },
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : (s[0].toUpperCase() + s.substring(1));
}

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({Key? key}) : super(key: key);

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Customer'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Customer Name',
            hintText: 'Enter name',
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop(_controller.text.trim());
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
