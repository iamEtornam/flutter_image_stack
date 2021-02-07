# flutter_image_stack

`FlutterImageStack` is a pure dart package for creating image stack in Flutter. This package give you a widget to easily create image stack for your need.

UI created by this package is mainly found in profile picture stacks in so many apps but it can be used at any place where you feel it will look good.

Pub Package: [flutter_image_stack](https://pub.dev/packages/flutter_image_stack)

## Installation

In the dependencies: section of your `pubspec.yaml`, add the following line:

```yaml
flutter_image_stack: <latest_version>
```

## Usage 1

```dart
import 'package:flutter_image_stack/flutter_image_stack.dart';

class MyWidget extends StatelessWidget {

  List<String> _images = [
    'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
    'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
    'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80'
  ];

  @override
  Widget build(BuildContext context) {
return FlutterImageStack(
        imageList: _images,
        showTotalCount: true,
        totalCount: 4,
        imageRadius: 60, // Radius of each images
        imageCount: 3, // Maximum number of images to be shown in stack
        imageBorderWidth: 3, // Border width around the images
      );
  }
}
```

## Usage 2

```dart
import 'package:flutter_image_stack/flutter_image_stack.dart';

class MyWidget extends StatelessWidget {

  List<ImageProvider> _images = [
    ExactAssetImage('assets/image_1.png'),
    NetworkImage('assets/image_2.png'),
    FileImage(File('assets/image_3.png')),
    ExactAssetImage('assets/image_4.png')
  ];

  @override
  Widget build(BuildContext context) {
return FlutterImageStack.providers(
          providers: _images,
          showTotalCount: true,
          totalCount: 4,
          imageRadius: 60, // Radius of each images
          imageCount: 3, // Maximum number of images to be shown in stack
          imageBorderWidth: 3, // Border width around the images
        );
  }
}
```


## Usage 3

```dart
import 'package:flutter_image_stack/flutter_image_stack.dart';

class MyWidget extends StatelessWidget {

  List<Widget> _images = [
    CircleAvatar(),
    CircleAvatar(),
    CircleAvatar(),
    CircleAvatar()
  ];

  @override
  Widget build(BuildContext context) {
return FlutterImageStack.widgets(
        children: _images,
        showTotalCount: true,
        totalCount: 4,
        widgetRadius: 60, // Radius of each images
        widgetCount: 3, // Maximum number of images to be shown in stack
        widgetBorderWidth: 3, // Border width around the images
      );
  }
}
```


## Screenshot

![Flutter Image Stack Screenshot](https://raw.githubusercontent.com/RegNex/flutter_image_stack/main/screenshot.png)

## Contributors

- [Etornam Sunu Bright](https://github.com/RegNex)
