part of 'button.dart';

enum ButtonType {
  fill,
  flat,
  outline;

  Color getColor(AppColor appColor, bool isInactive, [Color? color]) {
    switch (this) {
      case ButtonType.fill:
        return isInactive
            ? appColor.onInactiveContainer
            : color ?? appColor.onPrimary;
      case ButtonType.flat:
      case ButtonType.outline:
        return isInactive ? appColor.inactive : color ?? appColor.primary;
    }
  }

  Color getBackgroundColor(AppColor appColor, bool isInactive, [Color? color]) {
    switch (this) {
      case ButtonType.fill:
        return isInactive
            ? appColor.inactiveContainer
            : color ?? appColor.primary;
      case ButtonType.flat:
      case ButtonType.outline:
        return color ?? Colors.transparent;
    }
  }

  Border? getBorder(AppColor appColor, bool isInactive, [Color? color]) {
    switch (this) {
      case ButtonType.fill:
      case ButtonType.flat:
        return null;
      case ButtonType.outline:
        return Border.all(
          color: getColor(appColor, isInactive, color),
        );
    }
  }
}
