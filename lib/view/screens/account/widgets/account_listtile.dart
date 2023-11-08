import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String tileText;
  final IconData tileIcon;
  final VoidCallback tileOnTap;
  const CustomListTile({
    super.key,
    required this.tileText,
    required this.tileIcon,
    required  this.tileOnTap,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.06,
          child: ListTile(
            onTap: tileOnTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            iconColor: const Color(0xff388E3C),
            leading: Icon(
              tileIcon,
              size: 30,
            ),
            title: Text(
              tileText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.black54),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          indent: 15,
          endIndent: 15,
        ),
      ],
    );
  }
}
