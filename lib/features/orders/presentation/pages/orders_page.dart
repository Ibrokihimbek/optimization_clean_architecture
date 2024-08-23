import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";

import "package:pizza_hut_client_mobile/core/widgets/custom_tab_bar.dart";
import "package:pizza_hut_client_mobile/core/widgets/loading/modal_progress_hud.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/bloc/orders/orders_bloc.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/pages/widgets/current_orders_widget.dart";
import "package:pizza_hut_client_mobile/features/orders/presentation/pages/widgets/history_orders_widget.dart";

part "mixin/orders_mixin.dart";

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with OrdersMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    initTabController(this);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(context.tr("my_orders")),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: CustomTabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(text: context.tr("active"), height: 36),
                Tab(text: context.tr("history"), height: 36),
              ],
            ),
          ),
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (_, OrdersState state) => ModalProgressHUD(
            inAsyncCall: state.isLoading,
            child: TabBarView(
              controller: tabController,
              children: const <Widget>[
                CurrentOrdersWidget(),
                HistoryOrdersWidget(),
              ],
            ),
          ),
        ),
      );
}
