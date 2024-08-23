part of "orders_local_data_source.dart";

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  const OrdersLocalDataSourceImpl({
    required this.localSource,
  });

  final LocalSource localSource;
}
