# X Material Controls
Library extending quickcontrols2 to enhance application development using Material style.<br/>
Check [Demo](https://github.com/CamiloDelReal/xapps_controls_demo) for examples

## This project will not be maintenance anymore
I am not working for Qt since a while and updates started to become hard after so much changes in Qt 6

## Components
- XLabel
  * Display 1 to 4
  * Headline
  * Title
  * Subheading
  * Body 1 to 2
  * Caption
- XFormTextField
  * Basic style
  * Filled style (XFormTextFieldFilled)
  * Outlined style (XFormTextFieldOutlined)
  * All with floating label and icons support
- XPrimaryColorDialog and XAccentColorDialog
- XItemDelegate, XCheckDelegate, XRadioDelegate, XSwitchDelegate, XSwipeDelegate
  * Icon support
  * Secondary text
- XChip
  * Icon
  * Close button
  * Selectable state
- XCarousel
  * Images
  * Custom delegates
- XImageView
  * Pinch zoom in/out
  * Double tap to reset state
- XRoundedImage
  * Corder radius support
- XCard
  * Image background
  * Header
  * Footer
- XToast
  * Clasic Toast
  * Icon support
- XMessage
  * Snackbar like
  * Icon support
  * Action button
- XTitledPage
  * Page with Toolbar
  * Navigation action icon
  * Title and subtitle
  * Menu actions
  * Statusbar support for Android
- XTabbedPage
  * Page with a top TabBar (Looking like TabLayout from Android)
  * TabBar action buttons for navigation
  * Navigation action icon
  * Menu actions
  * Title and subtitle (looking better in landscape)
  * Statusbar support for Android
- XTitledTabbedPage
  * Fusion between XTitledPage and XTabbedPage
- XButtonedPage
  * Page with a bottom TabBar (looking like BottomNavigation from Android)
  * TabBar action buttons for navigation
  * Navigation action icon
  * Menu actions
  * Title and subtitle (looking better in landscape)
  * Statusbar support for Android
- XTitledButtonedPage
  * Fusion between XTitledPage and XButtonedPage
- XParallaxPage
  * Page with Toolbar
  * Navigation action icon
  * Title and subtitle
  * Menu actions
  * Statusbar support for Android
  * Parallax effect for toolbar content background
- XScrollingBehavior
  * Hide transition
  * Multiple toolbars
  * Inline (TopToBottom order) and PullBack (BottomToTop order) effects
- XSideBarNav
  * Header
  * Section items
- XAppNavController
  * Navigation support
  * Transition
- XAboutPane
  * Logo
  * Name
  * Version
  * Slogan
  * Sections
- XOnBoardingPane
  * Slides
- XSettingsPane
  * Sections
- XSplashPane
  * Color background
  * Logo
- XApplication
  * Splash
  * Side bar
  * Navigation
- Mobile cheats
  * Statusbar color and size for Android
  * Missing NavigationBar for Android
  * Missing iOS
  * Requires black drawable as splash with sticky behavior in Android to avoid flickering when app is loading.
    - [main.cpp](https://github.com/CamiloDelReal/xapps_controls_demo/blob/develop/src/app/main.cpp)
	- [AndroidManifest.xml](https://github.com/CamiloDelReal/xapps_controls_demo/blob/develop/android/AndroidManifest.xml)
	- [splashscreen.xml](https://github.com/CamiloDelReal/xapps_controls_demo/blob/develop/android/res/drawable/splashscreen.xml)