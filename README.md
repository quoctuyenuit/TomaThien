# IOS_Project - ToMaThien
This is a pure IOS app. It will help you manage all member in your team via attendance. Attendance will be done by registering / logging in then using the app. App will automatically generate QR codes. The manager just scans the QR code that can quickly roll attendance. So easily <3.
# Team Members

|Student ID  |Full Name               |Role     |
|------------|------------------------|---------|
|15520994    |Nguyễn Quốc Tuyến       |Leader   |
|15520607    |Trần Tấn Phát           |Member   |

# Functionality
| Functionality| Example images|
|---|---|
|**Register**:First, you must register your account in our system including in name, phone, email, date of birth, id card, your password.| **Register screen**: ![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2021.02.22.png)**Succesfull screen**:![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2021.05.17.png)|
|**Login**: When you had have account, you can logging in app.|![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2021.02.17.png)|
|**Home screen**:|![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2021.50.58.png)|
|**QR code scanner**: This is function that Manager will scan it to help to attendance. User must show QR code to Manager do it. And QR code automaticly was created by your account on FireBase.| My QR code![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2021.51.10.png)Scanning process your QR:![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/48415131_1087732068065138_318469943802724352_n.jpg)|
|**Alert Notification**: Why we create this function -> Because we want  Manager can be recieved user information which created by user. If no, the QR codes are impossible then the user's QR code cannot be scanned (attendance).|![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2022.04.07.png)|
|**List member were scanned**: Here, we create some list of list.|**List of members**: Fill all of member in a group following in group number![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2022.36.42.png)**List of attendance**: Fill all of member in a group following in month![](https://github.com/quoctuyenuit/TomaThien/blob/master/image/Simulator%20Screen%20Shot%20-%20iPhone%20X%20-%202018-12-25%20at%2022.36.54.png)|
|**Detail member**: Show uer information.|![]()|

# How to setup
## Set up environment

1. **[Ios/Swift](https://swift.org/)** (use latest version)

You can download and use the installer from their [homepage](https://yarnpkg.com/en/docs/install#windows-stable) or install via npm.

1. **[Expo](https://expo.io/) client**

   ```sh
   yarn global add expo-cli
   ```

1. Clone project

   ```sh
   git clone https://github.com/quoctuyenuit/TomaThien.git
   ```

1. Install package

   ```sh
   git clone https://github.com/quoctuyenuit/TomaThien.git
   cd React-Native-Project
   and Build via Xcode.
   ```

## Run app in dev mode

1. Connect your ios device or turn on IOS Emulator
2. Open a terminal and run `xcodebuild test -workspace News.xcworkspace -scheme News -destination 'platform=iOS Simulator,name=iPhone 6s,OS=12.0' | xcpretty -s`
3. Press 'a' to open on ios device


# Library
- [Firebase](https://firebase.google.com/) – Manage backend of user part. 
- [Expo](https://docs.expo.io) – a set of tools, libraries, and services that let you build native iOS and Android apps by writing JavaScript.
- [SQL Lite]() – Database
- [SnapKit](http://snapkit.io/) – SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.
- [UIKit](https://getuikit.com/docs/introduction) – Get familiar with the basic setup and overview of UIkit.
- [APIs](https://developer.apple.com/documentation/).
- [Foundation](https://developer.apple.com/documentation/foundation) : Access essential data types, collections, and operating-system services to define the base layer of functionality for your app.
- [CoreData](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/index.html)Core Data is a framework that you use to manage the model layer objects in your application. It provides generalized and automated solutions to common tasks associated with object life cycle and object graph management, including persistence.
- [RxSwift](https://github.com/ReactiveX/RxSwift) - Rx is a generic abstraction of computation expressed through Observable<Element> interface.
- [PINRemoteImage](https://github.com/pinterest/PINRemoteImage) - aPINRemoteImage supports downloading many types of files. It, of course, supports both PNGs and JPGs. It also supports decoding WebP images if Google's library is available. It even supports GIFs and Animated WebP via PINAnimatedImageView.
- [AVFoundation](https://developer.apple.com/av-foundation/) - AVFoundation is the full featured framework for working with time-based audiovisual media on iOS, macOS, watchOS and tvOS. Using AVFoundation, you can easily play, create, and edit QuickTime movies and MPEG-4 files, play HLS streams, and build powerful media functionality into your apps.
- [Viber Architive](https://github.com/santhoshss17/viber-sample) - 
Clean code architecture using Viber in Swift.

What is viper design pattern? : The word VIPER is a backronym for View, Interactor, Presenter, Entity, and Routing. Read (https://www.objc.io/issues/13-architecture/viper/)

Also check for integration of Google SDK and using Google places API's.
- [Realm](https://github.com/realm/realm-cocoa) - Realm is an enticing, cross-platform alternative to Core Data when it comes to persistence. It’s easier to work with than Core Data, as well as faster, and you even get a data browser to explore Realm database files. In case you need another reason to love Realm, this popular library for iOS app development recently launched a platform to sync data between apps in real-time.

If you need to do any data persistence, I’d definitely recommend checking out Realm as an alternative to Core Data.
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON improves your life when it comes to handling JSON in Swift. Parsing JSON with Swift can be tricky due to type casting issues that make it difficult to deserialize model object, amd it may require a bunch of nested if statements. SwiftyJSON makes all of it quite simple to do. It’s also the second-most popular Swift library.
- [Cocoapods](https://cocoapods.org/) - CocoaPods is built with Ruby and is installable with the default Ruby available on macOS. We recommend you use the default ruby.

# Future works
- Store all app data online with personal security.
- Create file report by month, day.
- Attendance via Wifi, Location.
- Multilanguage support.


# Related docs

- Firebase Tutorial ([eng](https://www.raywenderlich.com/3-firebase-tutorial-getting-started?fbclid=IwAR1g0zxeBcLoxWQJ4CFygVJ9opr_29YNszm0fVs6mWygF9uPB5WlnAKC_CM)/[vie](https://viblo.asia/p/tim-hieu-ve-firebase-realtime-database-Az45bxzVZxY))
- RxSwift and RxCocoa ([eng](https://www.raywenderlich.com/900-getting-started-with-rxswift-and-rxcocoa?fbclid=IwAR0ZLbRmt6lCwz9Ltmvd_pInEFN1BlFMi5Yz9UKUszJXcoXap69Y6G3X5uw))
- Grok Swift ([eng](https://grokswift.com/json-swift-4/?fbclid=IwAR36rH28Z_9kVv9znZVKSfg6StROvPraKOtdpvtlafyMi6QLgpUMnVnzRvw))
- Floaty ([github](https://github.com/kciter/Floaty/tree/master/Sources?fbclid=IwAR0OyZP7a8WZsoGUYmQKWMUSrU3zKtmmV_WDbE_sI4Ck1CxOKElV6iPlw7s))
- PropTypes ([eng](https://reactjs.org/docs/typechecking-with-proptypes.html)/[vie](https://viblo.asia/p/react-proptypes-khai-bao-kieu-du-lieu-cho-component-naQZR1aPKvx))
- [StackOverflow](https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates?fbclid=IwAR3-xyS2SzZe3TryLjgzFhpJJxP0qRvB9BRCYo1YHACVv4Hfdt2NIQcKZKw)
- [ReactiveX](http://reactivex.io/?fbclid=IwAR3pEOYHlEu8hBOFVSfJJ-uqp58pHTakK9FTDNWWVELCqYb2NV6RGWlhabg)
- [Common fixes](CommonFix.md)
