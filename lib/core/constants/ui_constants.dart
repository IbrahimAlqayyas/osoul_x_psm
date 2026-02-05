import 'package:get/get.dart';

// BaseScaffold AppBar height
const double kAppBarHeight = 70.0;

// BaseScaffold body padding (EdgeInsets.all(16))
const double bodyPadding = 16.0;

// MyGradientButton default height
const double buttonHeight = 50.0;

// Common vertical spacing
const double verticalSpacing = 16.0;

double getBodyHeight({num appBarHeight = kAppBarHeight}) {
  return (Get.height - appBarHeight - bodyPadding).toDouble();
}
