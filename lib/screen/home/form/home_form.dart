import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../models/main_form.dart';
import 'home_form_buttons.dart';
import 'home_form_date.dart';
import 'home_form_field.dart';

class HomeForm extends StatefulWidget {
  final MainForm form;

  const HomeForm(this.form, {super.key});

  @override
  State<StatefulWidget> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  static const _verticalMargin = SizedBox(height: 8);
  final AppColors _appColors = AppColors();
  final FocusNode _focus = FocusNode(canRequestFocus: false);

  MainForm get _form => widget.form;

  FieldsType get _fieldValue => _form.fieldValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _createDropdownButton(),
        _verticalMargin,
        _createField(),
        _verticalMargin,
        HomeFormButtons(_form),
      ],
    );
  }

  Widget _createDropdownButton() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: _appColors.border),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: SizedBox(
        height: 36.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButton<FieldsType>(
                value: _fieldValue,
                focusNode: _focus,
                isExpanded: true,
                padding: const EdgeInsets.only(left: 6.0),
                underline: const SizedBox.shrink(),
                alignment: Alignment.center,
                dropdownColor: _appColors.background,
                items: [
                  for (final field in FieldsType.values)
                    _createDropdownItem(field),
                ],
                onChanged: (value) {
                  _form.fieldValue = value ?? FieldsType.values.first;
                  _form.homeScreenKey.currentState?.setState(() {});
                  _focus.unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<FieldsType> _createDropdownItem(FieldsType field) {
    return DropdownMenuItem(
      value: field,
      child: Text(
        field.name,
        style: TextStyle(
          color: _appColors.text,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _createField() {
    switch (_fieldValue) {
      case FieldsType.seconds:
      case FieldsType.minutes:
      case FieldsType.hours:
      case FieldsType.days:
        return HomeFormField(_form);
      case FieldsType.date:
        return HomeFormDate(_form);
    }
  }
}
