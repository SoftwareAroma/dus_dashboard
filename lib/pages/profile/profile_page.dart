import 'package:cached_network_image/cached_network_image.dart';
import 'package:dus_dashboard/index.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<PlatformFile>? _paths;

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => debugPrint(
          status.toString(),
        ),
        allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      ))
          ?.files;
      if (!mounted) return;
    } on PlatformException catch (e) {
      notificationService.showSuccessNotification(
        context: context,
        title: "Success",
        message: e.message.toString(),
      );
    } catch (e) {
      notificationService.showSuccessNotification(
        context: context,
        title: "Success",
        message: e.toString(),
      );
    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          //passing file bytes and file name for API call
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade200,
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesDynastyEngraved),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            /// user profile
            Positioned(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.extension<CustomColors>()!.brandSurface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.00),
                    bottomRight: Radius.circular(20.00),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /// profile picture
                    Container(
                      height: 132.00,
                      width: 327.00,
                      margin: const EdgeInsets.only(
                        left: 10.00,
                        top: 24.00,
                        right: 10.00,
                      ),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 100.00,
                              width: 100.00,
                              margin: const EdgeInsets.only(
                                left: 113.00,
                                top: 10.00,
                                right: 113.00,
                              ),
                              child: Obx(
                                () => ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: CachedNetworkImage(
                                    width: 38.0,
                                    height: 38.0,
                                    imageUrl: adminController.activeAdmin?.avatar ??
                                        "https://res.cloudinary.com/dynasty-urban-style/image/upload/v1701686160/defaults/account_afhqmj.png",
                                    fit: BoxFit.cover,
                                    placeholder: (BuildContext context, String url) => Container(
                                      width: 38.0,
                                      height: 38.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(Assets.imagesAccount),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (BuildContext context, String url, dynamic dynamic) {
                                      return Container(
                                        width: 38.0,
                                        height: 38.0,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(Assets.imagesAccount),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: pickFiles,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 30.00,
                                width: 30.00,
                                margin: const EdgeInsets.only(
                                  left: 183.00,
                                  top: 10.00,
                                  right: 113.00,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(
                                    5.00,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// admin name
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.00,
                        top: 16.00,
                        right: 10.00,
                      ),
                      child: Text(
                        adminController.activeAdmin?.userName ?? "User",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey.shade50,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    /// admin email
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.00,
                        top: 8.00,
                        right: 10.00,
                        bottom: 48.00,
                      ),
                      child: Text(
                        "Admin | ${adminController.activeAdmin?.email ?? "Email"}",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey.shade50,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// delete button
            Positioned(
              top: 20.0,
              right: 10.0,
              child: CustomButton(
                width: MediaQuery.of(context).size.width * 0.14,
                buttonColor: Colors.redAccent,
                text: "Delete",
                fontSize: 16.0,
                onPressed: () async {
                  var response = await helperMethods.deleteAdmin(id: adminController.activeAdmin!.id);

                  if (!mounted) return;
                  response.fold(
                    (Failure l) {
                      notificationService.showErrorNotification(
                        context: context,
                        title: "Error",
                        message: l.message,
                      );
                    },
                    (bool r) {
                      context.pop();
                      notificationService.showSuccessNotification(
                        context: context,
                        title: "Success",
                        message: "Admin deleted successfully",
                      );
                    },
                  );
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
