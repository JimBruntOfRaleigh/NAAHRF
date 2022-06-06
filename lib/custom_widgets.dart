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

///  A function to build a 'Question' for the app.
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


///StepperScroller Constants & Helper
const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kErrorLight = Colors.red;
final Color _kErrorDark = Colors.red.shade400;
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const Color _kDisabledLight = Colors.black38;
const Color _kDisabledDark = Colors.white38;
const double _kStepSize = 24.0;
const double _kTriangleHeight = _kStepSize * 0.866025; // Triangle height. sqrt(3.0) / 2.0

// Paints a triangle whose base is the bottom of the bounding rectangle and its
// top vertex the middle of its top.
class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  bool hitTest(Offset point) => true; // Hitting the rectangle is fine enough.

  @override
  bool shouldRepaint(_TrianglePainter oldPainter) {
    return oldPainter.color != color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double base = size.width;
    final double halfBase = size.width / 2.0;
    final double height = size.height;
    final List<Offset> points = <Offset>[
      Offset(0.0, height),
      Offset(base, height),
      Offset(halfBase, 0.0),
    ];

    canvas.drawPath(
      Path()..addPolygon(points, true),
      Paint()..color = color,
    );
  }
}


/// A stepper with a scroll controller passed.
class StepperScroller extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const StepperScroller({
    Key? key,
    required this.steps,
    required this.controller,
    this.physics,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
    this.elevation,
    this.margin,
  }) : assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<Step> steps;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics? physics;

  /// The stepper's scroll controller.
  final ScrollController controller;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int>? onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback? onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and a [ControlsDetails] object, which
  /// contains step information and two functions: [onStepContinue] and [onStepCancel].
  /// These can be used to control the stepper. For example, reading the
  /// [ControlsDetails.currentStep] value within the callback can change the text
  /// of the continue or cancel button depending on which step users are at.
  ///
  /// {@tool dartpad}
  /// Creates a stepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Stepper(
  ///     controlsBuilder:
  ///       (BuildContext context, ControlsDetails details) {
  ///          return Row(
  ///            children: <Widget>[
  ///              TextButton(
  ///                onPressed: details.onStepContinue,
  ///                child: Text('Continue to Step ${details.stepIndex + 1}'),
  ///              ),
  ///              TextButton(
  ///                onPressed: details.onStepCancel,
  ///                child: Text('Back to Step ${details.stepIndex - 1}'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     steps: const <Step>[
  ///       Step(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       Step(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// ** See code in examples/api/lib/material/stepper/stepper.controls_builder.0.dart **
  /// {@end-tool}
  final ControlsWidgetBuilder? controlsBuilder;

  /// The elevation of this stepper's [Material] when [type] is [StepperType.horizontal].
  final double? elevation;

  /// custom margin on vertical stepper.
  final EdgeInsetsGeometry? margin;

  @override
  State<StepperScroller> createState() => _StepperScrollerState();
}

class _StepperScrollerState extends State<StepperScroller> with TickerProviderStateMixin {
  late List<GlobalKey> _keys;
  final Map<int, StepState> _oldStates = <int, StepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
          (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1)
      _oldStates[i] = widget.steps[i].state;
  }

  @override
  void didUpdateWidget(StepperScroller oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1)
      _oldStates[i] = oldWidget.steps[i].state;
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildLine(bool visible) {
    return Container(
      width: visible ? 1.0 : 0.0,
      height: 16.0,
      color: Colors.grey.shade400,
    );
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final StepState state = oldState ? _oldStates[index]! : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    switch (state) {
      case StepState.indexed:
      case StepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive ? _kStepStyle.copyWith(color: Colors.black87) : _kStepStyle,
        );
      case StepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.complete:
        return Icon(
          Icons.check,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    if (!_isDark()) {
      return widget.steps[index].isActive ? colorScheme.primary : colorScheme.onSurface.withOpacity(0.38);
    } else {
      return widget.steps[index].isActive ? colorScheme.secondary : colorScheme.background;
    }
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          color: _circleColor(index),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: _buildCircleChild(index, oldState && widget.steps[index].state == StepState.error),
        ),
      ),
    );
  }

  Widget _buildTriangle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: Center(
        child: SizedBox(
          width: _kStepSize,
          height: _kTriangleHeight, // Height of 24dp-long-sided equilateral triangle.
          child: CustomPaint(
            painter: _TrianglePainter(
              color: _isDark() ? _kErrorDark : _kErrorLight,
            ),
            child: Align(
              alignment: const Alignment(0.0, 0.8), // 0.8 looks better than the geometrical 0.33.
              child: _buildCircleChild(index, oldState && widget.steps[index].state != StepState.error),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: _buildTriangle(index, true),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == StepState.error ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != StepState.error)
        return _buildCircle(index, false);
      else
        return _buildTriangle(index, false);
    }
  }

  Widget _buildVerticalControls(int stepIndex) {
    if (widget.controlsBuilder != null)
      return widget.controlsBuilder!(
        context,
        ControlsDetails(
          currentStep: widget.currentStep,
          onStepContinue: widget.onStepContinue,
          onStepCancel: widget.onStepCancel,
          stepIndex: stepIndex,
        ),
      );

    final Color cancelColor;
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        cancelColor = Colors.black54;
        break;
      case Brightness.dark:
        cancelColor = Colors.white70;
        break;
    }

    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    const OutlinedBorder buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 16.0);

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child: Row(
          // The Material spec no longer includes a Stepper widget. The continue
          // and cancel button styles have been configured to match the original
          // version of this widget.
          children: <Widget>[
            TextButton(
              onPressed: widget.onStepContinue,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled) ? null : (_isDark() ? colorScheme.onSurface : colorScheme.onPrimary);
                }),
                backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                  return _isDark() || states.contains(MaterialState.disabled) ? null : colorScheme.primary;
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(buttonPadding),
                shape: MaterialStateProperty.all<OutlinedBorder>(buttonShape),
              ),
              child: Text(localizations.continueButtonLabel),
            ),
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8.0),
              child: TextButton(
                onPressed: widget.onStepCancel,
                style: TextButton.styleFrom(
                  primary: cancelColor,
                  padding: buttonPadding,
                  shape: buttonShape,
                ),
                child: Text(localizations.cancelButtonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _titleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.steps[index].state != null);
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.bodyText1!;
      case StepState.disabled:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return textTheme.bodyText1!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  TextStyle _subtitleStyle(int index) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;

    assert(widget.steps[index].state != null);
    switch (widget.steps[index].state) {
      case StepState.indexed:
      case StepState.editing:
      case StepState.complete:
        return textTheme.caption!;
      case StepState.disabled:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kDisabledDark : _kDisabledLight,
        );
      case StepState.error:
        return textTheme.caption!.copyWith(
          color: _isDark() ? _kErrorDark : _kErrorLight,
        );
    }
  }

  Widget _buildHeaderText(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedDefaultTextStyle(
          style: _titleStyle(index),
          duration: kThemeAnimationDuration,
          curve: Curves.fastOutSlowIn,
          child: widget.steps[index].title,
        ),
        if (widget.steps[index].subtitle != null)
          Container(
            margin: const EdgeInsets.only(top: 2.0),
            child: AnimatedDefaultTextStyle(
              style: _subtitleStyle(index),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: widget.steps[index].subtitle!,
            ),
          ),
      ],
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: widget.steps[i].state != StepState.disabled ? () {
            widget.onStepTapped?.call(i);
          } : null,
          canRequestFocus: widget.steps[i].state != StepState.disabled,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 72.0,
                child: Center(
                  child: _buildIcon(i),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(start: 12.0),
                child: _buildHeaderText(i),
              ),
            ],
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 1.0,
              color: Colors.grey.shade400,
            ),
          ),
      ],
    ];

    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < widget.steps.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i == widget.currentStep,
          child: widget.steps[i].content,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Material(
          elevation: widget.elevation ?? 2,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: children,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            controller: widget.controller,
            physics: widget.physics,
            padding: const EdgeInsets.all(24.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: stepPanels),
              ),
              _buildVerticalControls(widget.currentStep),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<StepperScroller>() != null) {
        throw FlutterError(
          'Steppers must not be nested.\n'
              'The material specification advises that one should avoid embedding '
              'steppers within steppers. '
              'https://material.io/archive/guidelines/components/steppers.html#steppers-usage',
        );
      }
      return true;
    }());

    return _buildHorizontal();
  }
}

///  An alternative StepperFormBlocBuilder, that gets a scroll controller passed
class StepperScrollerFormBlocBuilder<T extends FormBloc> extends StatelessWidget {
  const StepperScrollerFormBlocBuilder({
    Key? key,
    this.formBloc,
    required this.stepsBuilder,
    required this.controller,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  }) : super(key: key);

  final T? formBloc;

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [stepsBuilder] must not change.
  final List<FormBlocStep> Function(T? formBloc) stepsBuilder;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollController controller;

  //Type is always vertical.
  // /// The type of stepper that determines the layout. In the case of
  // /// [StepperType.horizontal], the content of the current step is displayed
  // /// underneath as opposed to the [StepperType.vertical] case where it is
  // /// displayed in-between.
  // final StepperType type;


  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final void Function(FormBloc? formBloc, int step)? onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will call [FormBloc.submit]
  final void Function(FormBloc? formBloc)? onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will call [FormBloc.previousStep]
  final void Function(FormBloc? formBloc)? onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and two functions,[onStepContinue]
  /// and [onStepCancel]. These can be used to control the stepper.
  ///
  /// {@tool dartpad --template=stateless_widget_scaffold}
  /// Creates a stepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Stepper(
  ///     controlsBuilder:
  ///       (BuildContext context, int step, VoidCallback onStepContinue, VoidCallback onStepCancel, FormBloc formBloc) {
  ///          return Row(
  ///            children: <Widget>[
  ///              FlatButton(
  ///                onPressed: onStepContinue,
  ///                child: const Text('NEXT'),
  ///              ),
  ///              FlatButton(
  ///                onPressed: onStepCancel,
  ///                child: const Text('CANCEL'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     steps: const <Step>[
  ///       Step(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       Step(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  final Widget Function(
      BuildContext context,
      VoidCallback? onStepContinue,
      VoidCallback? onStepCancel,
      int step,
      FormBloc formBloc,
      )? controlsBuilder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, FormBlocState>(
      bloc: formBloc,
      buildWhen: (p, c) =>
      p.numberOfSteps != c.numberOfSteps || p.currentStep != c.currentStep,
      builder: (context, state) {
        final formBloc = this.formBloc ?? context.read<T>();

        final formBlocSteps = stepsBuilder(formBloc);
        return StepperScroller(
          key: Key('__stepper_form_bloc_${formBlocSteps.length}__'),
          currentStep: state.currentStep,
          onStepCancel: onStepCancel == null
              ? (state.isFirstStep ? null : formBloc.previousStep)
              : () => onStepCancel?.call(formBloc),
          onStepContinue: onStepContinue == null
              ? formBloc.submit
              : () => onStepContinue?.call(formBloc),
          onStepTapped: onStepTapped == null
              ? null
              : (step) => onStepTapped?.call(formBloc, step),
          controller: controller,
          physics: const ClampingScrollPhysics(),
          steps: [
            for (var i = 0; i < formBlocSteps.length; i++)
              Step(
                  title: formBlocSteps[i].title,
                  isActive: formBlocSteps[i].isActive ?? i == state.currentStep,
                  content: formBlocSteps[i].content,
                  state: formBlocSteps[i].state,
                  subtitle: formBlocSteps[i].subtitle)
          ],
          controlsBuilder: controlsBuilder == null
              ? null
              : (context, controlsDetails) => controlsBuilder!(
              context,
              controlsDetails.onStepContinue,
              controlsDetails.onStepCancel,
              controlsDetails.stepIndex,
              formBloc),
        );
      },
    );
  }
}
