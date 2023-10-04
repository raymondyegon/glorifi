import 'package:flutter/material.dart';

class RewardsSection extends StatelessWidget {
  const RewardsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 350,
        width: MediaQuery.of(context).size.width * .9,
        margin: const EdgeInsets.only(
          top: 40,
          bottom: 40
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 15),
              child: Text(
                'Rewards',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 4, 33, 56),
                ),
              ),
            ),
            // Two Lines with Star in Between
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 4, 33, 56),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 4, 33, 56),
                  ),
                ),
                Container(
                  width: 70,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 4, 33, 56),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Text(
              "250",
              style: TextStyle(
                fontSize: 70,
                color: Color.fromARGB(255, 4, 33, 56),
                fontWeight: FontWeight.w900,
                letterSpacing: -3,
              ),
            ),
            const Text(
              "POINTS EARNED",
              style: TextStyle(
                color: Color.fromARGB(255, 4, 33, 56),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 120,
                    height: 45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.orange,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Earn More',
                        style: TextStyle(
                          color: Color.fromARGB(255, 4, 33, 56),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                      color: Colors.orange,
                    ),
                    child: const Center(
                      child: Text(
                        'Redeem',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
