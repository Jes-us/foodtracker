import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:foodtracker/view/constants.dart';

class GoogleAdsBanner extends StatefulWidget {
  const GoogleAdsBanner({super.key});

  @override
  State<GoogleAdsBanner> createState() => _GoogleAdsBannerState();
}

class _GoogleAdsBannerState extends State<GoogleAdsBanner> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: kadUnitId, // ID de anuncio de prueba
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void initState() {
    _loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isBannerAdReady
        ? Container(
            color: Theme.of(context).colorScheme.surface,
            alignment: Alignment.center,
            width: _bannerAd.size.width.toDouble(),
            height: _bannerAd.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd),
          )
        : SizedBox.shrink();
  }
}
