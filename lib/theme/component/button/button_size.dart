part of 'button.dart';

enum ButtonSize {
  small,
  medium,
  large;

  double get padding {
    switch (this) {
      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 16;
    }
  }

  TextStyle getTextStyle(AppTypo typo) {
    switch (this) {
      case ButtonSize.small:
        return typo.subtitle2;
      case ButtonSize.medium:
        return typo.subtitle1;
      case ButtonSize.large:
        return typo.headline6;
    }
  }
}
