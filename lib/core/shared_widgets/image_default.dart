import 'package:flutter/material.dart';

ImageProvider defaultNetworkImage(String? networkPhoto) {
  if (networkPhoto == null) {
    return const AssetImage('assets/logo/logo_icon.png');
  } else {
    return NetworkImage(networkPhoto);
  }
}

Image defaultImageNetwork(String? networkPhoto) {
  if (networkPhoto == null) {
    return Image.asset('assets/logo/logo_icon.png', fit: BoxFit.contain);
  } else {
    return Image.network(
      networkPhoto,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset('assets/logo/logo_icon.png', fit: BoxFit.contain),
      ),
    );
  }
}

Image defaultUserImageNetwork(String? networkPhoto) {
  if (networkPhoto == null) {
    return Image.asset('assets/icons/person.png', fit: BoxFit.cover);
  } else {
    return Image.network(networkPhoto, fit: BoxFit.cover);
  }
}
