import 'package:osoul_x_psm/core/app/environment.dart';
import 'package:osoul_x_psm/core/network/api_utils.dart';
import 'package:osoul_x_psm/features/home_work_orders/controllers/home_work_orders_controller.dart';
// import 'package:osoul_x_psm/features/home/controllers/home_controller.dart';

class Endpoints {
  ApiUtils apiUtils = ApiUtils();

  /// Check if the current environment is staging
  bool get _isStaging => kAppEnvironment?.environment == 'staging';

  /// //////////////////////////////////////////////////////////////////////////////////////
  /// ////////////////////////////  Endpoints  /////////////////////////////////////////////
  /// //////////////////////////////////////////////////////////////////////////////////////

  Uri getLoginUri() {
    final scriptId = _isStaging ? '1761' : '1761';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  }

  Uri changePasswordUri() {
    final scriptId = _isStaging ? '1756' : '1756';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  }

  Uri forgetPasswordUri() {
    final scriptId = _isStaging ? '1760' : '1760';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  }

  Uri customersUri(String? customerNameKeyword) {
    final scriptId = _isStaging ? '1740' : '2030';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId&filtertext=$customerNameKeyword');
  }

  Uri workOrdersUri() {
    final scriptId = _isStaging ? '2050' : '2050';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  }

  Uri workOrderItemLineUri(String type) {
    final scriptId = _isStaging ? '2052' : '2052';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId&type=$type');
  }

  // Uri transferOrderCreateUri() {
  //   final scriptId = _isStaging ? '1888' : '2017';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  // Uri transferOrderDetailsUri(String internalId) {
  //   final scriptId = _isStaging ? '1893' : '2018';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  // }

  Uri itemsBrandsUri(bool isFrozen) {
    final scriptId = _isStaging ? '1896' : '2028';
    return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId&isfrozen=$isFrozen');
  }

  // Uri receiptOrderListerUri() {
  //   final scriptId = _isStaging ? '1889' : '2026';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri receiptOrderDetailsUri(String? internalId) {
  //   final scriptId = _isStaging ? '1892' : '2025';
  //   if (internalId != null) {
  //     return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  //   }
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  Uri itemsLotsUri(String? filterText) {
    final scriptId = _isStaging ? '1894' : '2029';
    return Uri.parse(
      '${apiUtils.getBaseURL()}$scriptId&filtertext=$filterText&driverid=$kDriverId',
    );
  }

  // Uri vanItemsListUri() {
  //   final scriptId = _isStaging ? '1895' : '2016';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri salesOrderListUri() {
  //   final scriptId = _isStaging ? '1897' : '2022';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri salesOrderDetailsUri(String? internalId) {
  //   final scriptId = _isStaging ? '1898' : '2021';
  //   if (internalId != null) {
  //     return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  //   }
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  // salesOrderFulfillUri() {
  //   final scriptId = _isStaging ? '1899' : '2023';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  // Uri getSalesInvoiceLink(String internalId) {
  //   final scriptId = _isStaging ? '1902' : '2024';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  // }

  // Uri returnListingUri() {
  //   final scriptId = _isStaging ? '1906' : '2020';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri returnCreatedListingUri() {
  //   final scriptId = _isStaging ? '1907' : '2031';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri getReturnOrderDetails(String internalId) {
  //   final scriptId = _isStaging ? '1904' : '2019';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  // }

  // Uri getReturnCreatedOrderDetails(String internalId) {
  //   final scriptId = _isStaging ? '1908' : '2037';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&internalid=$internalId');
  // }

  // Uri returnOrderCreateUri() {
  //   final scriptId = _isStaging ? '1904' : '2019';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri updateTransferOrderDetailsUri() {
  //   final scriptId = _isStaging ? '1888' : '2017';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  // Uri collectOrderUri() {
  //   final scriptId = _isStaging ? '1912' : '2042';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }

  // Uri collectOrderActionUri() {
  //   final scriptId = _isStaging ? '1912' : '2042';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId');
  // }

  // Uri getCollectOrderDetailsUri() {
  //   final scriptId = _isStaging ? '1912' : '2042';
  //   return Uri.parse('${apiUtils.getBaseURL()}$scriptId&driverid=$kDriverId');
  // }
}
