import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gromart_project/blocs/blocs.dart';

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
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(
                                width: 1.5, color: const Color(0xff388E3C))),
                        child: (state.profilePhotoUrl == '')
                            ? Image.asset('assets/images/profile.png')
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(90),
                                child: Image.network(
                                  state.profilePhotoUrl,
                                  fit: BoxFit.cover,
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
                            backgroundColor: Color(0xff388E3C),
                            radius: 18,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
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
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                            width: 1.5, color: const Color(0xff388E3C))),
                    child: (state.profilePhotoUrl == '')
                        ? Image.asset('assets/images/profile.png')
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(90),
                            child: Image.network(
                              state.profilePhotoUrl,
                              fit: BoxFit.cover,
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
