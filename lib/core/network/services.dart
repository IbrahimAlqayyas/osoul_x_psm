import 'package:osoul_x_psm/core/logging/logging.dart';
import 'package:osoul_x_psm/core/network/api_client.dart';
import 'package:osoul_x_psm/core/network/api_utils.dart';
import 'package:osoul_x_psm/core/network/endpoints.dart';
import 'package:osoul_x_psm/features/auth/models/user_model.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_item_line_model.dart';
import 'package:osoul_x_psm/features/home_work_orders/models/work_order_model.dart';
import 'package:osoul_x_psm/features/products/models/product_model.dart';
// import 'package:osoul_x_psm/features/collect/models/collect_orders_model.dart';
// import 'package:osoul_x_psm/features/returns/models/return_listing_item.dart';
// import 'package:osoul_x_psm/features/sales/models/customers_model.dart';
// import 'package:osoul_x_psm/features/sales/models/sales_item_lots_model.dart';
// import 'package:osoul_x_psm/features/sales/models/sales_order_details_model.dart';
// import 'package:osoul_x_psm/features/sales/models/sales_order_model.dart';
// import 'package:osoul_x_psm/features/stock/models/stock_items_model.dart';
// import 'package:osoul_x_psm/features/transfer_orders/models/items_to_add_in_transfer_order.dart';
// import 'package:osoul_x_psm/features/transfer_orders/models/transfer_item_model.dart';
// import 'package:osoul_x_psm/features/transfer_orders/models/transfer_order_model.dart';

class Services {
  Future<UserModel?> login(String email, String password) async {
    UserModel? returnValue;
    await ApiClient().request(
      serviceName: 'login',
      requestType: RequestType.post,
      uri: Endpoints().getLoginUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().getLoginUri(), method: 'POST'),
      body: {'email': email, 'password': password},
      printResponseBody: true,
      onSuccess: (json) {
        kLog(json);
        UserModel user = UserModel.fromJson(json);
        returnValue = user;
      },
      onError: (error) {
        returnValue = null;
      },
    );

    return returnValue;
  }

  Future<bool> changePassword(Map<String, dynamic> body) async {
    bool returnValue = false;
    await ApiClient().request(
      serviceName: 'change Password',
      requestType: RequestType.post,
      uri: Endpoints().changePasswordUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().changePasswordUri(), method: 'POST'),
      body: body,
      onSuccess: (_) {
        returnValue = true;
      },
    );

    return returnValue;
  }

  Future<bool> forgetPasswordSendEmailOtp(Map<String, dynamic> body) async {
    bool returnValue = false;
    await ApiClient().request(
      serviceName: 'forget Password Send Email Otp',
      requestType: RequestType.post,
      uri: Endpoints().forgetPasswordUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().forgetPasswordUri(), method: 'POST'),
      body: body,
      onSuccess: (list) {
        returnValue = true;
      },
    );

    return returnValue;
  }

  Future<bool> forgetPasswordSendTempPassword(Map<String, dynamic> body) async {
    bool returnValue = false;
    await ApiClient().request(
      serviceName: 'forget Password Send Temp Password',
      requestType: RequestType.put,
      uri: Endpoints().forgetPasswordUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().forgetPasswordUri(), method: 'PUT'),
      body: body,
      onSuccess: (list) {
        returnValue = true;
      },
    );

    return returnValue;
  }

  Future<bool> forgetPasswordChangePasswordWithTemp(Map<String, dynamic> body) async {
    bool returnValue = false;
    await ApiClient().request(
      serviceName: 'forget Password Change Password With Temp',
      requestType: RequestType.post,
      uri: Endpoints().changePasswordUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().changePasswordUri(), method: 'POST'),
      body: body,
      onSuccess: (list) {
        returnValue = true;
      },
    );

    return returnValue;
  }

  Future<List<WorkOrderModel>?> getWorkOrders() async {
    List<WorkOrderModel>? returnValue;
    await ApiClient().request(
      serviceName: 'get Work Orders',
      requestType: RequestType.get,
      uri: Endpoints().workOrdersUri(),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().workOrdersUri(), method: 'GET'),
      onSuccess: (list) {
        List<WorkOrderModel> workOrders = [];
        for (var item in list) {
          workOrders.add(WorkOrderModel.fromJson(item));
        }
        returnValue = workOrders;
      },
    );

    return returnValue;
  }

  Future<List<WorkOrderItemLineModel>?> getWorkOrderItemLine(String type) async {
    List<WorkOrderItemLineModel>? returnValue;
    await ApiClient().request(
      serviceName: 'get Work Orders Item Lines - type: $type',
      requestType: RequestType.get,
      uri: Endpoints().workOrderItemLineUri(type),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().workOrderItemLineUri(type), method: 'GET'),
      onSuccess: (list) {
        List<WorkOrderItemLineModel> workOrderItemLines = [];
        for (var item in list) {
          workOrderItemLines.add(WorkOrderItemLineModel.fromJson(item));
        }
        returnValue = workOrderItemLines;
      },
    );

    return returnValue;
  }

  // Future<List<TransferItemModel>?> getTransferOrders() async {
  //   List<TransferItemModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Transfer Orders',
  //     requestType: RequestType.get,
  //     uri: Endpoints().transferOrderUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().transferOrderUri(), method: 'GET'),
  //     onSuccess: (list) {
  //       List<TransferItemModel> transferOrders = [];
  //       for (var item in list) {
  //         transferOrders.add(TransferItemModel.fromJson(item));
  //       }
  //       returnValue = transferOrders;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<TransferOrderDetailsModel?> getTransferOrderDetails(String internalId) async {
  //   TransferOrderDetailsModel? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Transfer Order Details: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().transferOrderDetailsUri(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(
  //       url: Endpoints().transferOrderDetailsUri(internalId),
  //       method: 'GET',
  //     ),
  //     onSuccess: (list) {
  //       TransferOrderDetailsModel transferOrders = TransferOrderDetailsModel.fromJson(list);
  //       returnValue = transferOrders;
  //     },
  //   );

  //   return returnValue;
  // }

  Future<List<ProductModel>?> getProducts(bool isFrozen) async {
    List<ProductModel>? returnValue;
    await ApiClient().request(
      serviceName: 'get Items To Add In Transfer Order',
      requestType: RequestType.get,
      uri: Endpoints().itemsBrandsUri(isFrozen),
      printCurl: true,
      headers: ApiUtils().headers(url: Endpoints().itemsBrandsUri(isFrozen), method: 'GET'),
      onSuccess: (list) {
        List<ProductModel> items = [];
        for (var item in list) {
          items.add(ProductModel.fromJson(item));
        }
        returnValue = items;
      },
    );

    return returnValue;
  }

  // Future<bool> createTransferOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'create Transfer Order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().transferOrderCreateUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().transferOrderCreateUri(), method: 'POST'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<List<TransferItemModel>?> getReceiptOrderItemList() async {
  //   List<TransferItemModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Items To Add In Transfer Order',
  //     requestType: RequestType.get,
  //     uri: Endpoints().receiptOrderListerUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().receiptOrderListerUri(), method: 'GET'),
  //     onSuccess: (list) {
  //       List<TransferItemModel> items = [];
  //       for (var item in list) {
  //         items.add(TransferItemModel.fromJson(item));
  //       }
  //       returnValue = items;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<TransferOrderDetailsModel?> getReceiptOrderDetails(String internalId) async {
  //   TransferOrderDetailsModel? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Transfer Order Details: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().receiptOrderDetailsUri(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(
  //       url: Endpoints().receiptOrderDetailsUri(internalId),
  //       method: 'GET',
  //     ),
  //     onSuccess: (list) {
  //       TransferOrderDetailsModel transferOrders = TransferOrderDetailsModel.fromJson(list);
  //       returnValue = transferOrders;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> receiveOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'receive Order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().receiptOrderDetailsUri(null),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().receiptOrderDetailsUri(null), method: 'POST'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<GetCustomersResponse?> getVanCustomers({String? customerNameKeyword}) async {
  //   GetCustomersResponse? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Van Customers',
  //     requestType: RequestType.get,
  //     uri: Endpoints().customersUri(customerNameKeyword),
  //     printCurl: true,
  //     headers: ApiUtils().headers(
  //       url: Endpoints().customersUri(customerNameKeyword),
  //       method: 'GET',
  //     ),
  //     onSuccess: (list) {
  //       GetCustomersResponse customers = GetCustomersResponse.fromJson(list);
  //       returnValue = customers;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<List<SalesOrderModel>?> getSalesOrders() async {
  //   List<SalesOrderModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Sales Orders',
  //     requestType: RequestType.get,
  //     uri: Endpoints().salesOrderListUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().salesOrderListUri(), method: 'GET'),
  //     onSuccess: (list) {
  //       List<SalesOrderModel> salesOrders = [];
  //       for (var item in list) {
  //         salesOrders.add(SalesOrderModel.fromJson(item));
  //       }
  //       returnValue = salesOrders;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<SalesOrderDetailsModel?> getSalesOrderDetails(String internalId) async {
  //   SalesOrderDetailsModel? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Sales Order Details: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().salesOrderDetailsUri(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().salesOrderDetailsUri(internalId), method: 'GET'),
  //     onSuccess: (list) {
  //       SalesOrderDetailsModel salesOrderDetails = SalesOrderDetailsModel.fromJson(list);
  //       returnValue = salesOrderDetails;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<List<SalesItemLotModel>?> getSalesItemLots(String? filterText) async {
  //   List<SalesItemLotModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Sales Item Lots',
  //     requestType: RequestType.get,
  //     uri: Endpoints().itemsLotsUri(filterText),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().itemsLotsUri(filterText), method: 'GET'),
  //     onSuccess: (list) {
  //       List<SalesItemLotModel> salesItemLots = [];
  //       for (var item in list) {
  //         salesItemLots.add(SalesItemLotModel.fromJson(item));
  //       }
  //       returnValue = salesItemLots;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> updateSalesOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'update Sales Order',
  //     requestType: RequestType.put,
  //     uri: Endpoints().salesOrderDetailsUri(null),
  //     printCurl: true,
  //     printResponseBody: true,

  //     headers: ApiUtils().headers(url: Endpoints().salesOrderDetailsUri(null), method: 'PUT'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> fulfillOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'fulfill Sales Order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().salesOrderFulfillUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().salesOrderFulfillUri(), method: 'POST'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<GetCustomersResponse?> getCustomers(String? keyword) async {
  //   GetCustomersResponse? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Customers',
  //     requestType: RequestType.get,
  //     uri: Endpoints().customersUri(keyword),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().customersUri(keyword), method: 'GET'),
  //     onSuccess: (list) {
  //       GetCustomersResponse customers = GetCustomersResponse.fromJson(list);
  //       returnValue = customers;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> createCustomerSalesOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'create Customer Sales Order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().salesOrderDetailsUri(null),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().salesOrderDetailsUri(null), method: 'POST'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<String?> getSalesInvoiceLink(String internalId) async {
  //   String? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Sales Invoice Link for internalId: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().getSalesInvoiceLink(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().getSalesInvoiceLink(internalId), method: 'GET'),
  //     onSuccess: (strLink) {
  //       returnValue = strLink;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<List<ReturnListingItemModel>?> getReturnListing() async {
  //   List<ReturnListingItemModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Return Listing',
  //     requestType: RequestType.get,
  //     uri: Endpoints().returnListingUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().returnListingUri(), method: 'GET'),
  //     onSuccess: (list) {
  //       List<ReturnListingItemModel> returnListing = [];
  //       for (var item in list) {
  //         returnListing.add(ReturnListingItemModel.fromJson(item));
  //       }
  //       returnValue = returnListing;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<List<ReturnListingItemModel>?> getReturnCreatedListing() async {
  //   List<ReturnListingItemModel>? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Return Created Listing',
  //     requestType: RequestType.get,
  //     uri: Endpoints().returnCreatedListingUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().returnCreatedListingUri(), method: 'GET'),
  //     onSuccess: (list) {
  //       List<ReturnListingItemModel> returnListing = [];
  //       for (var item in list) {
  //         returnListing.add(ReturnListingItemModel.fromJson(item));
  //       }
  //       returnValue = returnListing;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<ReturnOrderDetailsModel?> getReturnOrderDetails(String internalId) async {
  //   ReturnOrderDetailsModel? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Return Order Details for internalId: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().getReturnOrderDetails(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(
  //       url: Endpoints().getReturnOrderDetails(internalId),
  //       method: 'GET',
  //     ),
  //     onSuccess: (json) {
  //       ReturnOrderDetailsModel returnOrderDetails = ReturnOrderDetailsModel.fromJson(json);
  //       returnValue = returnOrderDetails;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<ReturnOrderDetailsModel?> getReturnCreatedOrderDetails(String internalId) async {
  //   ReturnOrderDetailsModel? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get Return Created Order Details for internalId: $internalId',
  //     requestType: RequestType.get,
  //     uri: Endpoints().getReturnCreatedOrderDetails(internalId),
  //     printCurl: true,
  //     headers: ApiUtils().headers(
  //       url: Endpoints().getReturnCreatedOrderDetails(internalId),
  //       method: 'GET',
  //     ),
  //     onSuccess: (json) {
  //       kLog(json);
  //       ReturnOrderDetailsModel returnOrderDetails = ReturnOrderDetailsModel.fromJson(json);
  //       returnValue = returnOrderDetails;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> createReturnOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'create Return Order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().returnOrderCreateUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().returnOrderCreateUri(), method: 'POST'),
  //     body: body,
  //     onSuccess: (_) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> updateTransferOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'update Transfer Order',
  //     requestType: RequestType.put,
  //     uri: Endpoints().updateTransferOrderDetailsUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().updateTransferOrderDetailsUri(), method: 'PUT'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<GetCollectOrdersResponse?> getCollectOrders() async {
  //   GetCollectOrdersResponse? returnValue;
  //   await ApiClient().request(
  //     serviceName: 'get collect orders',
  //     requestType: RequestType.get,
  //     uri: Endpoints().collectOrderUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().collectOrderUri(), method: 'GET'),
  //     printResponseBody: true,
  //     onSuccess: (json) {
  //       kLog(json);
  //       GetCollectOrdersResponse getCollectOrdersResponse = GetCollectOrdersResponse.fromJson(json);
  //       returnValue = getCollectOrdersResponse;
  //     },
  //   );

  //   return returnValue;
  // }

  // Future<bool> collectOrder(Map<String, dynamic> body) async {
  //   bool returnValue = false;
  //   await ApiClient().request(
  //     serviceName: 'collect order',
  //     requestType: RequestType.post,
  //     uri: Endpoints().collectOrderActionUri(),
  //     printCurl: true,
  //     headers: ApiUtils().headers(url: Endpoints().collectOrderActionUri(), method: 'POST'),
  //     body: body,
  //     onSuccess: (list) {
  //       returnValue = true;
  //     },
  //   );

  //   return returnValue;
  // }

  ///      ////////////
}
