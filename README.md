# weex-demo-web

> weex-demo-web

## introduce

* 根目录下包含两个工程，一个是weex工程，一个是express工程（为weex提供一些支持）
* 工程的初始化需要到各自的工程的根目录下去操作，里面都会有相关的readme。
* ios工程目录存放位置,已经配置好文件.
	
		test-weex/ios
## Compile

Install the dependencies:

```
npm install
npm install -g weex-toolkit@beta
```

Compile the source code:

+ `npm run build` # Compile the source code for web platform and native platform.
+ `npm run dev` # Watch mode for `npm run build`.

Copy the bundle file:

+ `npm run copy:android` # Copy generated bundle file to the assets of Android project.
+ `npm run copy:ios` # Copy generated bundle file to the assets of iOS project.
+ `npm run copy` # Run both `copy:andriod` and `copy:ios`.

More npm scripts will be find in the `package.json`.

### Start Web Service

```
npm run serve
```

The server is listening on 1337. Visit http://127.0.0.1:8080/index.html can preview the app on browser.

 > NOTE: Currently the vue renderer is not ready, the web page isn't rendering by Vue components.

### Run The Android Project

First you should install [Android Studio](https://developer.android.com/studio/index.html) and Android SDK.

Assuming you have configured the Android development environment properly, just use Android Studio to open the project in the `android` folder, and run the app as other normal Android projects.

### Run The iOS Project

First you should [setup the iOS develop environment](https://developer.apple.com/library/content/documentation/IDEs/Conceptual/AppStoreDistributionTutorial/Setup/Setup.html) and install the [CocoaPods](https://guides.cocoapods.org/using/getting-started.html).


Open the project in the `ios` folder by Xcode, you could run the app on the simulator.

 > NOTE: If you want to run the app on real device, you also need to setup your own signing configuration.