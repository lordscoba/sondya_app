import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sondya_app/data/remote/home.dart';
import 'package:sondya_app/presentation/widgets/picture_slider.dart';

class ProductDetailsBody extends ConsumerStatefulWidget {
  final String id;
  final String name;
  const ProductDetailsBody({super.key, required this.id, required this.name});

  @override
  ConsumerState<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends ConsumerState<ProductDetailsBody> {
  @override
  Widget build(BuildContext context) {
    final getProductDetails = ref
        .watch(getProductDetailsProvider((id: widget.id, name: widget.name)));
    return SingleChildScrollView(
      child: Center(
        child: Container(
            height: 710,
            padding: const EdgeInsets.all(10),
            child: getProductDetails.when(
              data: (data) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SondyaPictureSlider(
                      pictureList: data["data"]["image"],
                    )
                  ],
                );
              },
              loading: () => const CupertinoActivityIndicator(),
              error: (error, stackTrace) => Text(error.toString()),
            )),
      ),
    );
  }
}
