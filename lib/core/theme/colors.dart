import 'package:flutter/material.dart';

LinearGradient kMainGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kSecondaryColor, kPrimaryColor],
);

/// colors
const Color kPrimaryColor = Color.fromARGB(255, 0, 61, 140);
const Color kSecondaryColor = Color.fromARGB(255, 124, 85, 142);
const Color kRedColor = Color(0xffDF345B);
const Color kOrangeColor = Color(0xFFFFA726);
const Color kGreenColor = Color(0xff66BB6A);
const Color kWhiteColor = Colors.white;
const Color kBlackColor = Colors.black;
const Color kLightGreyColor = Color(0xffDCDFE2);
const Color kGreyColor = Color(0xffC5C4C3);
const Color kFieldBorderColor = Color(0x458E5578);
const Color kTransparent = Colors.transparent;
const Color kDarkGreyColor = Color.fromARGB(255, 61, 61, 61);

/// Snackbar title text color
const Color kSnackbarTitleTextColor = Color(0xFF2A3139);

/// Snackbar subtitle text color
const Color kSnackbarSubtitleTextColor = Color(0xFF70747B);

/// form field /////////////////////
const Color kFormFieldBackground = Color(0xFFF8F9FA);

/// Error color - used for negative feedback and validation errors
const Color kErrorColor = Color(0xFFF44336);

/// Form field border color
const Color formFieldBorder = Color(0xFFE0E0E0);

/// Form field focused border color
const Color formFieldFocusedBorder = Color(0xFF68408C);

/// Form field error border color
const Color formFieldErrorBorder = Color(0xFFF44336);

/// Form field hint text color
const Color formFieldHintText = Color(0xFF999999);

/// Disabled button background color
const Color kDisabledButtonBackground = Color(0xFFE0E0E0);

/// Disabled button text color
const Color kDisabledButtonText = Color(0xFF999999);

/// Muted text color - used for less important content
const Color kMutedTextColor = Color(0xFF999999);

/// Default border color
const Color kDefaultBorder = Color(0xFFDDDDDD);

/// gradients
const kLinearGradient = LinearGradient(
  colors: [kPrimaryColor, kSecondaryColor],
  begin: AlignmentDirectional.centerEnd,
  end: AlignmentDirectional.centerStart,
  transform: GradientRotation(7),
);

const kButtonGradient = LinearGradient(
  colors: [Color.fromARGB(255, 124, 21, 72), kSecondaryColor],
  begin: AlignmentDirectional.centerEnd,
  end: AlignmentDirectional.centerStart,
  transform: GradientRotation(7),
);

const kGreenGradient = LinearGradient(
  colors: [Colors.green, Colors.lime],
  begin: AlignmentDirectional.centerEnd,
  end: AlignmentDirectional.centerStart,
  transform: GradientRotation(7),
);

const kLinearGradientNoRotation = LinearGradient(
  colors: [Color(0xff8f3e70), Color(0xff8f3e70), Color(0xff0c3b7e)],
  begin: AlignmentDirectional.topEnd,
  end: AlignmentDirectional.bottomStart,
  transform: GradientRotation(3),
);

const kLinearGradientFlipped = LinearGradient(
  colors: [kPrimaryColor, kSecondaryColor],
  begin: AlignmentDirectional.centerStart,
  end: AlignmentDirectional.centerEnd,
  transform: GradientRotation(7),
);

const kLinearGradientLighter = LinearGradient(
  colors: [Color(0xffDF345B), Color(0xffff0072)],
  begin: AlignmentDirectional.centerEnd,
  end: AlignmentDirectional.centerStart,
  transform: GradientRotation(7),
);

const kScannerGradient = LinearGradient(
  colors: [kTransparent, kSecondaryColor],
  begin: AlignmentDirectional.topCenter,
  end: AlignmentDirectional.bottomCenter,
);

const kPageGradient = LinearGradient(
  colors: [kPrimaryColor, kSecondaryColor],
  begin: AlignmentDirectional.centerEnd,
  end: AlignmentDirectional.centerStart,
  transform: GradientRotation(7),
);

LinearGradient getCardGradient(int index) {
  return kCardGradients[index % kCardGradients.length];
}

/// /////////////////////////////////////////
const List<LinearGradient> kCardGradients = [
  // 💎 Premium Dark Elegance
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f3460)],
  ),

  // 🌊 Deep Ocean Blue
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0f2027), Color(0xFF203a43), Color(0xFF2c5364)],
  ),

  // 🍷 Sophisticated Burgundy
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2c1b3d), Color(0xFF5b2a42), Color(0xFF8b3a47)],
  ),

  // 🌲 Forest Emerald
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF134e4a), Color(0xFF065f46), Color(0xFF047857)],
  ),

  // 🌑 Midnight Slate
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1e293b), Color(0xFF334155), Color(0xFF475569)],
  ),

  // 👔 Executive Navy
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1e3a8a), Color(0xFF1e40af), Color(0xFF3b82f6)],
  ),

  // 🎩 Royal Purple
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3b1e54), Color(0xFF4a2358), Color(0xFF5a2d5f)],
  ),

  // 🌌 Deep Space
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0c0c1e), Color(0xFF1a1a3e), Color(0xFF2d2d5f)],
  ),

  // 🌿 Pine Green
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1b3a2f), Color(0xFF234d3e), Color(0xFF2d6149)],
  ),

  // 🏔️ Carbon Black
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF18181b), Color(0xFF27272a), Color(0xFF3f3f46)],
  ),

  // 💼 Business Teal
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF083344), Color(0xFF0e4c5e), Color(0xFF166678)],
  ),

  // 🎯 Deep Crimson
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF450a0a), Color(0xFF7f1d1d), Color(0xFF991b1b)],
  ),
  // 🌙 Lunar Indigo
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1e1b4b), Color(0xFF312e81), Color(0xFF4338ca)],
  ),

  // 🍂 Autumn Bronze
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3e2723), Color(0xFF4e342e), Color(0xFF5d4037)],
  ),

  // 🌊 Arctic Blue
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0c4a6e), Color(0xFF075985), Color(0xFF0369a1)],
  ),

  // 🍇 Velvet Plum
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4a1942), Color(0xFF5e1f52), Color(0xFF701a75)],
  ),

  // 🌑 Obsidian Gray
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0f172a), Color(0xFF1e293b), Color(0xFF334155)],
  ),

  // 🌲 Deep Moss
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF14532d), Color(0xFF166534), Color(0xFF15803d)],
  ),

  // 💎 Sapphire Night
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF172554), Color(0xFF1e3a8a), Color(0xFF1d4ed8)],
  ),

  // 🍷 Merlot Red
  LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4c0519), Color(0xFF5f1327), Color(0xFF881337)],
  ),
];

// LinearGradient kGoldGradient = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFF7B5D01), Color(0xFF1F1F1F)],
// );

int opacityToAlpha(num opacity) {
  final int alpha = (opacity * 255).round();
  return alpha;
}
