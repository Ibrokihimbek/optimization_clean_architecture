// ignore_for_file: discarded_futures, always_specify_types

import "package:currency_clean_architecture/core/extension/extension.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";
import "package:currency_clean_architecture/core/widgets/loading/modal_progress_hud.dart";
import "package:currency_clean_architecture/features/home/presentation/bloc/home/home_bloc.dart";
import "package:currency_clean_architecture/features/home/presentation/pages/widgets/currency_item.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.tr("currency_rate")),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.apiStatus != current.apiStatus,
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state.apiStatus.isLoading,
              child: CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: state.currency.length,
                    itemBuilder: (_, int index) => CurrencyWidget(
                      currency: state.currency[index],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
}
