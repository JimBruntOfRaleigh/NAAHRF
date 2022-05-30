import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_form_bloc/src/theme/field_theme_resolver.dart';
import 'package:flutter_form_bloc/src/utils/utils.dart';
import 'package:flutter/rendering.dart';

/// A material design checkbox without the checkbox (for possible later use)
class TextDisplayBlocBuilder extends StatelessWidget {
  const TextDisplayBlocBuilder({
    Key? key,
    required this.booleanFieldBloc,
    required this.body,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.errorBuilder,
    this.padding,
    this.alignment = AlignmentDirectional.centerStart,
    this.nextFocusNode,
    this.animateWhenCanShow = true,
    this.textStyle,
    this.textColor,
    this.controlAffinity,
    this.mouseCursor,
    this.fillColor,
    this.checkColor,
    this.overlayColor,
    this.splashRadius,
    this.shape,
    this.side,
  }) : super(key: key);

  /// {@macro flutter_form_bloc.FieldBlocBuilder.fieldBloc}
  final BooleanFieldBloc<dynamic> booleanFieldBloc;

  /// {@template flutter_form_bloc.FieldBlocBuilderControlAffinity}
  /// Where to place the control in widgets
  /// {@endtemplate}
  final FieldBlocBuilderControlAffinity? controlAffinity;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.errorBuilder}
  final FieldBlocErrorBuilder? errorBuilder;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.enableOnlyWhenFormBlocCanSubmit}
  final bool enableOnlyWhenFormBlocCanSubmit;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.isEnabled}
  final bool isEnabled;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.padding}
  final EdgeInsetsGeometry? padding;

  final AlignmentGeometry alignment;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.nextFocusNode}
  final FocusNode? nextFocusNode;

  /// {@template flutter_form_bloc.FieldBlocBuilder.checkboxBody}
  /// The widget on the right side of the checkbox
  /// {@endtemplate}
  final Widget body;

  /// {@macro  flutter_form_bloc.FieldBlocBuilder.animateWhenCanShow}
  final bool animateWhenCanShow;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.textStyle}
  final TextStyle? textStyle;

  /// {@macro flutter_form_bloc.FieldBlocBuilder.textColor}
  final MaterialStateProperty<Color?>? textColor;

  // ========== [Checkbox] ==========

  /// [Checkbox.mouseCursor]
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  /// [Checkbox.fillColor]
  final MaterialStateProperty<Color?>? fillColor;

  /// [Checkbox.checkColor]
  final MaterialStateProperty<Color?>? checkColor;

  /// [Checkbox.overlayColor]
  final MaterialStateProperty<Color?>? overlayColor;

  /// [Checkbox.splashRadius]
  final double? splashRadius;

  /// [Checkbox.shape]
  final OutlinedBorder? shape;

  /// [Checkbox.side]
  final BorderSide? side;

  CheckboxFieldTheme themeStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final formTheme = FormTheme.of(context);
    final fieldTheme = formTheme.checkboxTheme;
    final resolver = FieldThemeResolver(theme, formTheme, fieldTheme);
    final checkboxTheme = fieldTheme.checkboxTheme ?? theme.checkboxTheme;

    return CheckboxFieldTheme(
      textStyle: textStyle ?? resolver.textStyle,
      textColor: textColor ?? resolver.textColor,
      decorationTheme: fieldTheme.decorationTheme ?? resolver.decorationTheme,
      checkboxTheme: checkboxTheme.copyWith(
        mouseCursor: mouseCursor,
        fillColor: fillColor,
        checkColor: checkColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        shape: shape,
        side: side,
      ),
      controlAffinity: controlAffinity ??
          fieldTheme.controlAffinity ??
          FieldBlocBuilderControlAffinity.leading,
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldTheme = themeStyleOf(context);

    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: fieldTheme.checkboxTheme,
      ),
      child: CanShowFieldBlocBuilder(
        fieldBloc: booleanFieldBloc,
        animate: animateWhenCanShow,
        builder: (_, __) {
          return BlocBuilder<BooleanFieldBloc, BooleanFieldBlocState>(
            bloc: booleanFieldBloc,
            builder: (context, state) {
              final isEnabled = fieldBlocIsEnabled(
                isEnabled: this.isEnabled,
                enableOnlyWhenFormBlocCanSubmit:
                enableOnlyWhenFormBlocCanSubmit,
                fieldBlocState: state,
              );

              return DefaultFieldBlocBuilderPadding(
                padding: padding,
                child: InputDecorator(
                  decoration: Style.inputDecorationWithoutBorder.copyWith(
                    errorText: Style.getErrorText(
                      context: context,
                      errorBuilder: errorBuilder,
                      fieldBlocState: state,
                      fieldBloc: booleanFieldBloc,
                    ),
                  ),
                  child: DefaultTextStyle(
                    style: Style.resolveTextStyle(
                      isEnabled: isEnabled,
                      style: fieldTheme.textStyle!,
                      color: fieldTheme.textColor!,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: kMinInteractiveDimension,
                      ),
                      alignment: alignment,
                      child: body,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

}

Widget buildQuestion(
    BuildContext context,
    SelectFieldBloc<dynamic, dynamic> question,
    BooleanFieldBloc<dynamic> explanation,
    String questionString,
    String explanationString,
    double rot) {
  return Container(
    child: Column(children: [
      Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints.expand(
                  height:
                  Theme.of(context).textTheme.headline4!.fontSize! * 1.7 +
                      200.0,
                ),
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue[600],
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(rot),
                child: Text(questionString,
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.white)),
              ),
              RadioButtonGroupFieldBlocBuilder(
                selectFieldBloc: question,
                itemBuilder: (context, dynamic value) =>
                    FieldItem(child: Text(value)),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  //prefixIcon: SizedBox(),
                ),
              ),
            ],
          )),
      TextDisplayBlocBuilder(
          booleanFieldBloc: explanation,
          body: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //       width: 1,
              //   ),
              //   borderRadius: BorderRadius.all(
              //       Radius.circular(22.0)
              //   ),
              // ),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(explanationString)))),
      const Divider(height: 40.0, color: Color.fromARGB(0, 0, 0, 0)),
    ]),
  );
}



//To measure the size of the steps so we can frame them correctly
typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size oldSize = Size.zero;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}