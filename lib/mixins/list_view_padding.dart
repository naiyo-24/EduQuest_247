import 'package:flutter/material.dart';

mixin ListViewPaddingMixin {
  EdgeInsets get listViewPadding => const EdgeInsets.fromLTRB(16, 8, 16, 85);
  
  // Helper method for body padding
  EdgeInsets get bodyPadding => const EdgeInsets.only(bottom: 65);
}
