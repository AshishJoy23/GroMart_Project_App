import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/search'),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: size.height * 0.055,
          width: size.width,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 232, 226, 226),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  CupertinoIcons.search,
                  size: 30,
                  color: Color(0xff388E3C),
                ),
              ),
              Text(
                'Search Here...',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
