import 'dart:ui' show lerpDouble;

import 'package:fischi/components/EmoteSwitchThumbPainter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Examples can assume:
// bool _lights;
// void setState(VoidCallback fn) { }

/// Based on [CupertinoSwitch]
/// An iOS-style switch.
///
/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of
/// the switch changes, the widget calls the [onChanged] callback. Most widgets
/// that use a switch will listen for the [onChanged] callback and rebuild the
/// switch with a new [value] to update the visual appearance of the switch.
///
/// {@tool snippet}
///
/// This sample shows how to use a [EmoteSwitch] in a [ListTile]. The
/// [MergeSemantics] is used to turn the entire [ListTile] into a single item
/// for accessibility tools.
///
/// ```dart
/// MergeSemantics(
///   child: ListTile(
///     title: Text('Lights'),
///     trailing: CupertinoSwitch(
///       value: _lights,
///       onChanged: (bool value) { setState(() { _lights = value; }); },
///     ),
///     onTap: () { setState(() { _lights = !_lights; }); },
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Switch], the material design equivalent.
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/switches/>
class EmoteSwitch extends StatefulWidget {
  /// Creates an iOS-style switch.
  ///
  /// The [value] parameter must not be null.
  /// The [dragStartBehavior] parameter defaults to [DragStartBehavior.start] and must not be null.
  const EmoteSwitch({
    Key key,
    @required this.value,
    @required this.onChanged,
    this.trackColor,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(value != null),
        assert(dragStartBehavior != null),
        super(key: key);

  /// Whether this switch is on or off.
  ///
  /// Must not be null.
  final bool value;

  /// Called when the user toggles with switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use for the background when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  final Color trackColor;

  /// {@template flutter.cupertino.switch.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin upon the detection of a drag gesture. If
  /// set to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  @override
  _EmoteSwitchState createState() => _EmoteSwitchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value',
        value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>(
        'onChanged', onChanged,
        ifNull: 'disabled'));
  }
}

class _EmoteSwitchState extends State<EmoteSwitch>
    with TickerProviderStateMixin {
  TapGestureRecognizer _tap;
  HorizontalDragGestureRecognizer _drag;

  AnimationController _positionController;
  CurvedAnimation position;

  AnimationController _reactionController;
  Animation<double> _reaction;

  bool get isInteractive => widget.onChanged != null;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the position indicated by the widget's value.
  bool needsPositionAnimation = false;

  @override
  void initState() {
    super.initState();

    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = widget.dragStartBehavior;

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );
    position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
    _reactionController = AnimationController(
      duration: _kReactionDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(EmoteSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _drag.dragStartBehavior = widget.dragStartBehavior;

    if (needsPositionAnimation || oldWidget.value != widget.value)
      _resumePositionAnimation(isLinear: needsPositionAnimation);
  }

  // `isLinear` must be true if the position animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    position
      ..curve = isLinear ? null : Curves.ease
      ..reverseCurve = isLinear ? null : Curves.ease.flipped;
    if (widget.value)
      _positionController.forward();
    else
      _positionController.reverse();
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) needsPositionAnimation = false;
    _reactionController.forward();
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isInteractive) _reactionController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.forward();
      _emitVibration();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = null
        ..reverseCurve = null;
      final double delta = details.primaryDelta / _kTrackInnerLength;
      _positionController.value += delta;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (position.value >= 0.5 != widget.value) widget.onChanged(!widget.value);
    _reactionController.reverse();
  }

  void _emitVibration() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        HapticFeedback.lightImpact();
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) _resumePositionAnimation();

    final trackColor = CupertinoDynamicColor.resolve(
        widget.trackColor ?? CupertinoColors.secondarySystemFill, context);

    return Opacity(
      opacity:
          widget.onChanged == null ? _kCupertinoSwitchDisabledOpacity : 1.0,
      child: _CupertinoSwitchRenderObjectWidget(
        value: widget.value,
        activeColor: trackColor,
        trackColor: trackColor,
        onChanged: widget.onChanged,
        state: this,
      ),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();

    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}

class _CupertinoSwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _CupertinoSwitchRenderObjectWidget({
    Key key,
    this.value,
    this.activeColor,
    this.trackColor,
    this.onChanged,
    this.state,
  }) : super(key: key);

  final bool value;
  final Color activeColor;
  final Color trackColor;
  final ValueChanged<bool> onChanged;
  final _EmoteSwitchState state;

  @override
  _RenderCupertinoSwitch createRenderObject(BuildContext context) {
    return _RenderCupertinoSwitch(
      value: value,
      activeColor: activeColor,
      trackColor: trackColor,
      onChanged: onChanged,
      state: state,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCupertinoSwitch renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..onChanged = onChanged;
  }
}

const double _kTrackWidth = 51.0 * 1.3;
const double _kTrackHeight = 31.0 * 1.3;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kTrackInnerStart = _kTrackHeight / 2.0;
const double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
const double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
const double _kSwitchWidth = 59.0 * 1.3;
const double _kSwitchHeight = 39.0 * 1.3;
const double _kCupertinoSwitchDisabledOpacity = 0.4;

const Duration _kReactionDuration = Duration(milliseconds: 300);
const Duration _kToggleDuration = Duration(milliseconds: 200);

class _RenderCupertinoSwitch extends RenderConstrainedBox {
  _RenderCupertinoSwitch({
    @required bool value,
    @required Color activeColor,
    @required Color trackColor,
    ValueChanged<bool> onChanged,
    @required _EmoteSwitchState state,
  })  : assert(value != null),
        assert(activeColor != null),
        assert(state != null),
        _value = value,
        _activeColor = activeColor,
        _trackColor = trackColor,
        _onChanged = onChanged,
        _state = state,
        super(
            additionalConstraints: const BoxConstraints.tightFor(
                width: _kSwitchWidth, height: _kSwitchHeight)) {
    state.position.addListener(markNeedsPaint);
    state._reaction.addListener(markNeedsPaint);
  }

  final _EmoteSwitchState _state;

  bool get value => _value;
  bool _value;
  set value(bool value) {
    assert(value != null);
    if (value == _value) return;
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;
  set activeColor(Color value) {
    assert(value != null);
    if (value == _activeColor) return;
    _activeColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;
  set trackColor(Color value) {
    assert(value != null);
    if (value == _trackColor) return;
    _trackColor = value;
    markNeedsPaint();
  }

  ValueChanged<bool> get onChanged => _onChanged;
  ValueChanged<bool> _onChanged;
  set onChanged(ValueChanged<bool> value) {
    if (value == _onChanged) return;
    final bool wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  bool get isInteractive => onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && isInteractive) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isInteractive) config.onTap = _state._handleTap;

    config.isEnabled = isInteractive;
    config.isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    final double currentValue = _state.position.value;
    final double currentReactionValue = _state._reaction.value;

    double visualPosition = currentValue;

    final Paint paint = Paint()
      ..color = Color.lerp(trackColor, activeColor, currentValue);

    final Rect trackRect = Rect.fromLTWH(
      offset.dx + (size.width - _kTrackWidth) / 2.0,
      offset.dy + (size.height - _kTrackHeight) / 2.0,
      _kTrackWidth,
      _kTrackHeight,
    );
    final RRect trackRRect = RRect.fromRectAndRadius(
        trackRect, const Radius.circular(_kTrackRadius));
    canvas.drawRRect(trackRRect, paint);

    final double currentThumbExtension =
        EmoteSwitchThumbPainter.extension * currentReactionValue;
    final double thumbLeft = lerpDouble(
      trackRect.left + _kTrackInnerStart - EmoteSwitchThumbPainter.radius,
      trackRect.left +
          _kTrackInnerEnd -
          EmoteSwitchThumbPainter.radius -
          currentThumbExtension,
      visualPosition,
    );
    final double thumbRight = lerpDouble(
      trackRect.left +
          _kTrackInnerStart +
          EmoteSwitchThumbPainter.radius +
          currentThumbExtension,
      trackRect.left + _kTrackInnerEnd + EmoteSwitchThumbPainter.radius,
      visualPosition,
    );
    final double thumbCenterY = offset.dy + size.height / 2.0;
    final Rect thumbBounds = Rect.fromLTRB(
      thumbLeft,
      thumbCenterY - EmoteSwitchThumbPainter.radius,
      thumbRight,
      thumbCenterY + EmoteSwitchThumbPainter.radius,
    );

    context
        .pushClipRRect(needsCompositing, Offset.zero, thumbBounds, trackRRect,
            (PaintingContext innerContext, Offset offset) {
      const EmoteSwitchThumbPainter.switchThumb()
          .paint(innerContext.canvas, thumbBounds, _value);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(FlagProperty('value',
        value: value, ifTrue: 'checked', ifFalse: 'unchecked', showName: true));
    description.add(FlagProperty('isInteractive',
        value: isInteractive,
        ifTrue: 'enabled',
        ifFalse: 'disabled',
        showName: true,
        defaultValue: true));
  }
}
