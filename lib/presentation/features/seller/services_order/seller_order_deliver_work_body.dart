import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SellerOrderDeliverWorkBody extends ConsumerStatefulWidget {
  const SellerOrderDeliverWorkBody({super.key});

  @override
  ConsumerState<SellerOrderDeliverWorkBody> createState() =>
      _SellerOrderDeliverWorkBodyState();
}

class _SellerOrderDeliverWorkBodyState
    extends ConsumerState<SellerOrderDeliverWorkBody> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
