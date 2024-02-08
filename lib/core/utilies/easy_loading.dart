import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/src/widgets/indicator.dart';
void showLoading({
  EasyLoadingMaskType maskType = EasyLoadingMaskType.black,
}) {

  EasyLoading.show(maskType: maskType,status: "Loading..");
}

void hideLoading() {
  EasyLoading.dismiss();
}

void showError(String message) {
  EasyLoading.dismiss();

  EasyLoading.showError(
    message,
    dismissOnTap: true,
  );
}

void showSuccess(String message) {
  EasyLoading.dismiss();

  EasyLoading.showSuccess(
    message,
    dismissOnTap: true,
  );
}

void showInfo(String message) {
  EasyLoading.dismiss();

  EasyLoading.showInfo(
    message,
    dismissOnTap: true,
  );
}
