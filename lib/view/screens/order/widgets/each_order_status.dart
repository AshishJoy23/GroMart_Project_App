import 'package:flutter/material.dart';

class CustomEachOrderStatus extends StatelessWidget {
  const CustomEachOrderStatus({
    super.key,
    required this.statusDate,
    required this.status,
    required this.statusFlag,
    required this.statusDescription,
    required this.isConfirmed,
    required this.isProcessed,
    required this.isShipped,
    required this.isDelivered,
    this.iscancel = true,
    this.isRed = false,
  });

  final String statusDate;
  final String status;
  final bool statusFlag;
  final String statusDescription;
  final bool isConfirmed;
  final bool isProcessed;
  final bool isShipped;
  final bool isDelivered;
  final bool iscancel;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: size.width * 0.3,
          child: Text(
            statusDate,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        (statusFlag)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      (isRed) ? Colors.red : const Color(0xff388E3C),
                  child: Icon(
                    (isRed) ? Icons.close : Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black26,
                ),
              ),
        SizedBox(
          width: size.width * 0.1,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: (statusFlag)
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.black26),
              ),
              ((isConfirmed) &&
                      (isProcessed) &&
                      (isShipped) &&
                      (isDelivered) &&
                      (iscancel))
                  ? Text(
                      statusDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}