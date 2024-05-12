import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerProductsStatusBody extends StatelessWidget {
  const SellerProductsStatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: const SellerProductSucessFFF(),
        ),
      ),
    );
  }
}

class SellerProductSucessFFF extends StatelessWidget {
  const SellerProductSucessFFF({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Image(image: AssetImage('assets/images/success_picture.png')),
        const SizedBox(height: 20),
        Text(
          "Your Product is successfully publish",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
        ),
        const SizedBox(height: 20),
        const Text(
          "Proin placerat risus non justo faucibus commodo. Nunc non neque sit amet magna aliquam condimentum.",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Go Back"),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    context.push("/");
                  },
                  child: const Text("View")),
            ),
          ],
        ),
      ],
    );
  }
}

class SellerProductFailureFFF extends StatelessWidget {
  final String message;
  const SellerProductFailureFFF({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Image(image: AssetImage('assets/images/failure_picture.png')),
        const SizedBox(height: 20),
        Text(
          "Payment was unsucessful",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.playfairDisplay().fontFamily),
        ),
        const SizedBox(height: 20),
        Text(
          message,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          "Click on the link to try again",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF807D7E),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Go Back"),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    context.push("/");
                  },
                  child: const Text("View")),
            ),
          ],
        ),
      ],
    );
  }
}
