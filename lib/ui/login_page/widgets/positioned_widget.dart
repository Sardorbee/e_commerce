import 'package:flutter/material.dart';

class PositionedWW extends StatelessWidget {
  const PositionedWW({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 92,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.facebook),
                color: Color(0xFF3B5998),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 92,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/g.png',
                ),
                // color: Colors.black,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
