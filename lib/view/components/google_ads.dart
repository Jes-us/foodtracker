import 'package:flutter/material.dart';
import 'package:foodtracker/view/components/screen_size.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

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
      adUnitId:
          'ca-app-pub-3940256099942544/6300978111', // ID de anuncio de prueba
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
          print('Error al cargar el anuncio: $error');
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = ScreenSizeProvider.of(context)?.screenHeight ?? 0.0;
    double screenWidth = ScreenSizeProvider.of(context)?.screenWidth ?? 0.0;
    return _isBannerAdReady
        ? Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              alignment: Alignment.center,
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          )
        : SizedBox.shrink();
  }
}
