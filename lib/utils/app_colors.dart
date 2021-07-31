import 'dart:math' as math;

import 'package:flutter/material.dart';

const colorPrimary = const Color(0xFFbc1f26);
const colorAccent = const Color(0xFFbc1f26);
const colorAccentMild = const Color(0xFFffe9eb);

const colorBlack = const Color(0xFF000000);
const colorWhite = const Color(0xFFFFFFFF);
const colorDarkGrey = const Color(0xFF808080);
const colorVeryLightGrey = const Color(0xFFF0F0F0);
const colorDividerGrey = const Color(0xFFD3D3D3);
const colorStarGrey = const Color(0xFFD3D3D3);
const colorCloseIconImage = const Color(0xFF979597);
const colorDropDownHeaderColor = const Color(0xFFFDEEF2);
const colorTextContentRedColor = const Color(0xFF912B36);
const colorQtyHintColor = const Color(0xFF1A181A);
const colorGrey = const Color(0xFFf5f5f5);
const colorYellow = const Color(0xFFFFD700);
const colorYoutubeGrey = const Color(0xFFF1F1F1);
const colorFbBlue = const Color(0xFF3b5999);
const colorGMailRed = const Color(0xFFdc4e42);
const colorTwitterBlue = const Color(0xFF55acef);

const colorTextLabel = const Color(0xFF7D7F7F);
const colorLightGrey = const Color(0xFF91A5A6);
const colorFlashGreen = const Color(0xFF46cf7d);
const colorFlashDarkGreen = const Color(0xFF2ecc71);
const colorOrange = const Color(0xFFED7C24);

const colorCard1 = const Color(0xFF3498db);
const colorCard2 = const Color(0xFFe74c3c);
const colorCard3 = const Color(0xFF2ecc71);
const colorDarkRed = const Color(0xFFE0665E);

colorRandom() => Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
