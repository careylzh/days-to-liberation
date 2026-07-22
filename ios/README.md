# Days to Liberation for iOS

A native SwiftUI port of the countdown page with support for multiple saved dates and configurable Home Screen widgets. The app targets iOS 26 so its countdown surface and controls use native Liquid Glass.

## Open and run

1. Install Xcode 26 or later and [XcodeGen](https://github.com/yonaskolb/XcodeGen).
2. From this directory, run `xcodegen generate`.
3. Open `DaysToLiberation.xcodeproj`.
4. Select the `DaysToLiberation` target and choose your Apple Developer team under Signing & Capabilities.
5. Register the App Group `group.com.careylzh.daystoliberation` for both the app and widget extension. If you use different bundle identifiers, update the identifier in both entitlement files and `CountdownRepository.swift`.
6. Run the app on an iOS 26 simulator or device.

The app starts with the Copa De Singapura finale from the web version. Use the plus button to add more dates, tap a row to see the full countdown, swipe left to delete, or use Edit on the detail screen.

## Add a widget

1. Run the app once and add any countdowns you want.
2. Long-press the Home Screen, choose **Add Widget**, and find **Days to Liberation**.
3. Add a small or medium widget.
4. Long-press the widget, choose **Edit Widget**, and select a countdown.

Widget data is stored in the shared App Group. Saving or deleting a countdown asks WidgetKit to refresh immediately, and the timeline refreshes again after local midnight.

## Validate

```bash
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodegen generate
DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer xcodebuild \
  -project DaysToLiberation.xcodeproj \
  -scheme DaysToLiberation \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build
```

