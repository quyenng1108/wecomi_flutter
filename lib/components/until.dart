import 'package:flutter/cupertino.dart';

const double kDefaultToggleOffset = 150.0;

class Util {
  static double getSafeOffset(
      ScrollController scrollController, double toggleOffset) {
    if (scrollController.offset > toggleOffset) {
      return toggleOffset;
    } else if (scrollController.offset < 0) {
      return 0;
    }
    return scrollController.offset;
  }

  static double computeSize(ScrollController scrollController,
      double toggleOffset, double originalValue, double finalValue) {
    var offset = getSafeOffset(scrollController, toggleOffset);
    var value =
        ((finalValue - originalValue) / toggleOffset) * offset + originalValue;
    return value;
  }

  static double computeTransitionOffset(
      ScrollController scrollController,
      double toggleOffsetY,
      double finalTransitionOffsetY,
      double originTransitionOffsetY) {
    var controllerOffset = Util.getSafeOffset(scrollController, toggleOffsetY);
    var transitionOffsetY =
        ((finalTransitionOffsetY - originTransitionOffsetY) / toggleOffsetY) *
                controllerOffset +
            originTransitionOffsetY;

    return transitionOffsetY;
  }
}
