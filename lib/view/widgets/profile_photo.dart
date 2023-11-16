import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';
import 'package:gromart_project/view/config/colors.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final bool isEdit;
  const ProfilePhotoWidget({
    super.key,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: Transform.scale(
              scale: 0.7,
              child: const CircularProgressIndicator(
                strokeWidth: 3,
                backgroundColor: Colors.white,
                color: Colors.black,
              ),
            ),
          );
        } else if (state is ProfileLoaded) {
          return Center(
            child: (isEdit)
                ? Stack(
                    children: [
                      Container(
                        width: size.width * 0.3,
                        height: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: kCardColor,
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                width: 1.5, color: kPrimaryColor)),
                        child: (state.profilePhotoUrl == '')
                            ? Image.asset('assets/images/profile.png')
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image.network(
                                  state.profilePhotoUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: Transform.scale(
                                          scale: 0.5,
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 3,
                                            backgroundColor: Colors.white,
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<ProfileBloc>(context)
                                .add(const ProfilePictureUploaded());
                          },
                          child: const CircleAvatar(
                            backgroundColor: kCardColor,
                            radius: 18,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: kCardColor,
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                            width: 1.5, color: kPrimaryColor)),
                    child: (state.profilePhotoUrl == '')
                        ? Image.asset('assets/images/profile.png')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              state.profilePhotoUrl,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: Transform.scale(
                                      scale: 0.5,
                                      child: const CircularProgressIndicator(
                                        strokeWidth: 3,
                                        backgroundColor: Colors.white,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                  ),
          );
        } else {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        }
      },
    );
  }
}
