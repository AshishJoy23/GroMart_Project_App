import 'package:flutter/material.dart';

class NewAddressCard extends StatelessWidget {
  const NewAddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.01,horizontal: width * 0.04,),
      child: SizedBox(
        height: height * 0.06,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
              Colors.black,
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  height * 0.06,
                ), // Adjust the value to control the border radius
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/add_address');
          },
          child: Text(
            'Add New Address',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
