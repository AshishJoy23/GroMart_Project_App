import 'package:flutter/material.dart';

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.transparent,
      child: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.home,size: 26,),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/category');
              },
              icon: const Icon(Icons.category,size: 26,),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/wishlist');
              },
              icon: const Icon(Icons.favorite,size: 26,),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
              icon: const Icon(Icons.notifications,size: 26,),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person,size: 26,),
            ),
          ],
        ),
      ),
    );
  }
}
