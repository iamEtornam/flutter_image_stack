library flutter_image_stack;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Creates a flutter image stack
class FlutterImageStack extends StatelessWidget {

   /// List of image urls
  final List<String> imageList;

  /// item radius for the circular image/widget
  final double? itemRadius;

 /// Count of the number of images/widgets to be shown
  final int? itemCount;

  /// Total count will be used to determine the number of circular images
  /// to be shown along with showing the remaining count in an additional
  /// circle
  final int totalCount;

  /// Optional field to set the circular image/widget border width
  final double? itemBorderWidth;

  /// Optional field to set the color of circular image/widget border
  final Color? itemBorderColor;

  /// The text style to apply if there is any extra count to be shown
  final TextStyle extraCountTextStyle;

  /// Set the background color of the circle
  final Color backgroundColor;

  /// Enum to define the image source.
  ///
  /// Describes type of the image source being sent in [imageList]
  ///
  /// Possible values:
  ///  * Asset
  ///  * Network
  ///  * File
  final ImageSource? imageSource;

/// Custom widget list passed to render circular widgets
  final List<Widget> children;

   /// List of `ImageProvider` eg. AssetImage, FileImage, NetworkImage
  final List<ImageProvider> providers;

  /// To show the remaining count if the provided list size is less than [totalCount]
  final bool showTotalCount;


 /// Creates a flutter image stack widget.
  ///
  /// The [imageList] and [totalCount] parameters are required.
  FlutterImageStack({
    Key? key,
    required this.imageList,
    this.itemRadius = 25,
    this.itemCount = 3,
    required this.totalCount,
    this.itemBorderWidth = 2,
    Color this.itemBorderColor = Colors.grey,
    this.imageSource = ImageSource.Network,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.backgroundColor = Colors.white,
  })  : children = [],
        providers = [],
        super(key: key);

  /// Creates a flutter image stack widget by passing list of custom widgets.
  ///
  /// The [children] and [totalCount] parameters are required.
  FlutterImageStack.widgets({
    Key? key,
    required this.children,
    this.itemRadius = 25,
    this.itemCount = 3,
    required this.totalCount,
    this.itemBorderWidth = 2,
    Color this.itemBorderColor = Colors.grey,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.backgroundColor = Colors.white,
  })  : imageList = [],
        providers = [],
        imageSource = null,
        super(key: key);

  /// Creates an flutter image stack by passing list of `ImageProvider`.
  ///
  /// The [providers] and [totalCount] parameters are required.
  FlutterImageStack.providers({
    Key? key,
    required this.providers,
    this.itemRadius = 25,
    this.itemCount = 3,
    required this.totalCount,
    this.itemBorderWidth = 2,
    Color this.itemBorderColor = Colors.grey,
    this.showTotalCount = true,
    this.extraCountTextStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    this.backgroundColor = Colors.white,
  })  : imageList = [],
        children = [],
        imageSource = null,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    var items = List.from(imageList)..addAll(children)..addAll(providers);
    int size = min(itemCount!, items.length);
    var widgetList = items
        .sublist(0, size)
        .asMap()
        .map((index, value) => MapEntry(
            index,
            Padding(
              padding: EdgeInsets.only(left: 0.7 * itemRadius! * index),
              child: circularItem(value),
            )))
        .values
        .toList()
        .reversed
        .toList();
    return FittedBox(
      child: Row(
        children: <Widget>[
          widgetList.isNotEmpty
              ? Stack(
                  clipBehavior: Clip.none,
                  children: widgetList,
                )
              : SizedBox.shrink(),
          Container(
              child: showTotalCount && totalCount - widgetList.length > 0
                  ? Container(
                      constraints: BoxConstraints(
                          minWidth: itemRadius! - itemBorderWidth!),
                      padding: EdgeInsets.all(3),
                      height: (itemRadius! - itemBorderWidth!),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              itemRadius! - itemBorderWidth!),
                          border: Border.all(
                              color: itemBorderColor!, width: itemBorderWidth!),
                          color: backgroundColor),
                      child: Center(
                        child: Text(
                          "+${totalCount - widgetList.length}",
                          textAlign: TextAlign.center,
                          style: extraCountTextStyle,
                        ),
                      ),
                    )
                  : SizedBox()),
        ],
      ),
    );
  }

  Widget circularItem(dynamic item) {
    if (item is ImageProvider) {
      return circularProviders(item);
    } else if (item is Widget) {
      return circularWidget(item);
    } else if (item is String) {
      return circularImage(item);
    }
    return Container();
  }

  circularWidget(Widget widget) {
    return Container(
      height: itemRadius,
      width: itemRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: itemBorderColor!,
          width: itemBorderWidth!,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(itemRadius!),
        child: widget,
      ),
    );
  }

  Widget circularImage(String imageUrl) {
    return Container(
      height: itemRadius,
      width: itemRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: itemBorderWidth!,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget circularProviders(ImageProvider imageProvider) {
    return Container(
      height: itemRadius,
      width: itemRadius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: itemBorderWidth!,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  imageProvider(imageUrl) {
    if (this.imageSource == ImageSource.Asset) {
      return AssetImage(imageUrl);
    } else if (this.imageSource == ImageSource.File) {
      return FileImage(imageUrl);
    }
    return NetworkImage(imageUrl);
  }
}

enum ImageSource { Asset, Network, File }
