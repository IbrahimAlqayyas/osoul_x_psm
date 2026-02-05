import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:osoul_x_psm/core/shared_widgets/padding.dart';
import 'package:osoul_x_psm/core/theme/colors.dart';

// ignore: must_be_immutable
class CustomTextFieldWidget extends StatefulWidget {
  final String? title;
  final String hint;
  final TextEditingController controller;
  final Function(String value)? validator;
  final Function(String value)? onChanged;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final bool isEditable;
  final bool enableFocusBorder;
  final FocusNode? focusNode;
  final TextInputType keyBoardType;
  final GlobalKey<FormState>? formKey;
  String? errorMessage;
  final EdgeInsetsGeometry? contentPadding;
  final num? height;
  final Color? fillColor;

  final Color? enabledBorderColor;
  final Color? focusedBorderColor;

  final bool isObscure;
  final bool showObscureToggle;
  final List<TextInputFormatter>? formatters;
  final bool isCentered;

  CustomTextFieldWidget({
    super.key,
    this.fillColor,
    this.title,
    required this.hint,
    required this.controller,
    this.validator,
    this.focusNode,
    this.onChanged,
    this.isEditable = true,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.enableFocusBorder = true,
    this.keyBoardType = TextInputType.text,
    this.formKey,
    this.height,
    this.errorMessage,
    this.contentPadding,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.isObscure = false,
    this.showObscureToggle = false,
    this.formatters,
    this.isCentered = false,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    final hasCustomFocusBorder = widget.focusedBorderColor != null;

    // Determine colors based on isEditable
    final effectiveFillColor =
        widget.fillColor ??
        (widget.isEditable
            ? kFormFieldBackground
            : kDisabledButtonBackground.withAlpha(opacityToAlpha(0.3)));

    final effectiveEnabledBorderColor =
        widget.enabledBorderColor ??
        (widget.isEditable ? kDefaultBorder : kMutedTextColor.withAlpha(opacityToAlpha(0.3)));

    final effectiveFocusedBorderColor =
        widget.focusedBorderColor ??
        (widget.isEditable ? kPrimaryColor : kMutedTextColor.withAlpha(opacityToAlpha(0.3)));

    // ✅ نجهز البوردر الثابت (نستخدمه مرتين)
    final normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: effectiveEnabledBorderColor, width: 1),
    );

    // ✅ نجهز البوردر وقت الفوكس
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: effectiveFocusedBorderColor, width: 1),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) Text(widget.title!),
        if (widget.title != null) const VPadding(6),
        SizedBox(
          height: widget.height?.toDouble(),
          child: TextFormField(
            focusNode: widget.focusNode,
            keyboardType: widget.keyBoardType,
            enabled: true,
            // الشكل ثابت
            readOnly: !widget.isEditable,
            // التحكم في التعديل
            showCursor: widget.isEditable,
            // ✅ إخفاء الكيرسر لو مش قابل للتعديل
            controller: widget.controller,
            obscureText: _obscureText,
            inputFormatters: widget.formatters,
            style: TextStyle(color: widget.isEditable ? null : kMutedTextColor),
            onChanged: (value) {
              if (!widget.isEditable) return;
              if (widget.onChanged != null) widget.onChanged!(value);
              if (widget.validator != null) {
                // setState(() {
                //   widget.errorMessage = widget.validator!(value);
                // });
                widget.formKey?.currentState?.validate();
              }
            },
            validator: (value) {
              return widget.validator != null ? widget.validator!(value!) : null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: effectiveFillColor,

              // ✅ البوردر العادي
              enabledBorder: normalBorder,

              // ✅ لو مش قابل للتعديل → نفس البوردر العادي، ميعملش فوكس بوردر
              focusedBorder: widget.isEditable && widget.enableFocusBorder
                  ? (hasCustomFocusBorder ? focusedBorder : normalBorder)
                  : normalBorder,

              hintText: widget.hint,
              hintStyle: TextStyle(color: formFieldHintText, fontSize: 14),

              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8),
                      child: widget.prefixIcon,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 35,
                minHeight: 35,
                maxHeight: 35,
                maxWidth: 35,
              ),

              suffixIcon: widget.showObscureToggle
                  ? IconButton(
                      onPressed: widget.isEditable ? _toggleObscure : null,
                      icon: Icon(
                        _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: kSecondaryColor,
                      ),
                    )
                  : (widget.suffixIcon != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(end: 8),
                            child: widget.suffixIcon,
                          )
                        : null),
              suffixIconConstraints: const BoxConstraints(maxHeight: 50, maxWidth: 120),

              contentPadding: widget.contentPadding ?? const EdgeInsetsDirectional.only(start: 12),
            ),
            textAlign: widget.isCentered ? TextAlign.center : TextAlign.start,
          ),
        ),
        if (widget.errorMessage != null) VPadding(3),
        Visibility(
          visible: widget.errorMessage != null,
          child: Text(
            widget.errorMessage ?? '',
            style: const TextStyle(color: kErrorColor, fontSize: 13, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
