import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Image(image: AssetImage('assets/images/empty_cart.png')),
              const SizedBox(height: 20),
              Text(
                "Your cart is empty and sad :(",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.playfairDisplay().fontFamily),
              ),
              const SizedBox(height: 20),
              const Text(
                "Add something to make it happy!",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF807D7E),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    context.push("/");
                  },
                  child: const Text("Continue Shopping")),
            ],
          ),
        ),
      ),
    );
  }
}
