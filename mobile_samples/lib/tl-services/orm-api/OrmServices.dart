import 'package:tradeleaves/models/index.dart';

abstract class OrmServices {
Future createBuyrequest(CustomerRequestDTO customerRequestDTO);
Future getBuyRequestById(ActiveBuyRequestInputDTO activeBuyRequestInputDTO);
Future getSupplierReceiveCustRequest(SupplierReceiveCustRequestDTO supplierReceiveCustRequestDTO);
}
