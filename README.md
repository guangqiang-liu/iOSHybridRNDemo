# iOS原生混合RN开发最佳实践
> 做过原生iOS开发或者Android开发的同学们肯定也都了解Hybrid，有一些Hybrid的开发经验，目前我们企业开发中运用最广泛的Hybrid App技术就是原生与H5 hybrid，在早期的时候，可能部分同学也接触过PhoneGap等hybrid技术，今天我们就简单来聊下一种比较新的Hybrid技术方案，原生App与ReactNativie Hybrid，如果有同学们对React Native技术不熟悉的同学，可以查看作者简书中对React Native基础的讲解：[React Native入门到实战讲解](https://www.jianshu.com/u/023338566ca5)

# [简书地址](https://www.jianshu.com/p/f9812f601a2c)


![](http://ovyjkveav.bkt.clouddn.com/18-3-9/86804430.jpg)

## 具体步骤
* 创建一个iOS原生项目
* 将iOS原生项目支持pod
* 调整目前项目工程的文件夹结构
* 添加RN依赖相关文件
* 安装React Native
* 修改Podfile文件，原生安装React Native依赖库
* 在iOS原生页面填加RN页面入口
* 修改RN入口文件 index.ios.js
* 执行`npm start` 运行项目

### 创建一个iOS原生项目
> 使用Xcode创建一个空的项目，这个应该不用多说了

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/13158819.jpg)

### 项目支持pod
> 这一操作步骤同样也很简单，我们只需要执行下面的几条命令即可，如果对cocoapods 安装使用不熟悉的同学请参照作者简书

* 创建podfile文件，我们在有xcodeproj文件的同级目录下执行下面命令，这时我们的项目文件中就多了一个Podfile文件

```
$ pod init
```

* 执行pod install 命令来安装pod，同样，这个命令也是在有xcodeproj同级目录下，安装完成后，我们的项目多了一个

```
$ pod install
```

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/71970196.jpg)

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/41252836.jpg)

**注意：**  这里对原生iOS不熟悉的同学们需要注意了，当我们使用pod来作为库管理工具，后面我们打开项目运行，我们就需要打开上图所示的xcworkspace文件了

### 调整目前项目工程的文件夹结构
> 这里对文件夹做结构调整是为了后期更好的将Android原始项目也使用RN Hybrid，使iOS和Android共享一份React Native框架，共享同一份JS文件，调整的后的文件夹结构如下

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/88989146.jpg)

#### 添加RN依赖相关文件
> 到这里，我们原生的iOS项目目录结构已近调整完毕，后面我们需要处理的都是RN相关的内容了，这里需要创建的文件有点多，大家可以直接将示例Demo中的这几个文件直接拖到自己的项目中，然后在做修改即可

* 首先我们需要创建package.json文件
* 创建index.ios.js文件
* 创建index.android.js文件
* 创建bundle文件夹，**注意这个文件夹是后面我们接入CodePush热更新时使用的**

### 安装React Native
> 安装React Native这个也很简单，我们也是简单的执行下面的命令即可，**注意：执行npm 系列的命令，我们都需要在项目根目录（有package.json文件的目录）下执行**

```
$ npm install
```

package.json文件内容如下

```
{
  "name": "iOSHybridRNDemo",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "start": "node node_modules/react-native/local-cli/cli.js start"
  },
  "dependencies": {
    "prop-types": "^15.6.1",
    "react": "16.0.0",
    "react-native": "0.50.3",
    "react-native-code-push": "^5.2.2",
    "react-native-root-toast": "^1.3.0",
    "react-native-router-flux": "^4.0.0-beta.24",
    "react-native-simple-store": "^1.3.0",
    "react-native-storage": "^0.2.2",
    "react-native-vector-icons": "^4.3.0",
    "react-redux": "^5.0.6",
    "redux": "^3.7.2",
    "redux-actions": "^2.2.1",
    "redux-promise-middleware": "^4.4.1",
    "redux-thunk": "^2.2.0"
  },
  "devDependencies": {
    "babel-jest": "22.4.1",
    "babel-preset-react-native": "4.0.0",
    "jest": "22.4.2",
    "react-test-renderer": "16.0.0"
  },
  "jest": {
    "preset": "react-native"
  }
}

```

**注意：因为我们项目中使用到了`react-native-vector-icons` 这个iconFont组件需要依赖原生，所以我们执行完 `npm install` 之后，我们还需要 再执行一个 `react-native link react-native-vector-icons` 命令来安装原生依赖**

```
$ react-native link react-native-vector-icons
```

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/91162484.jpg)

当我们执行完`npm install` 命令之后，我们再打开项目目录，发现多了一个 `node_modules` 文件夹，这个文件夹就是我们安装的React Native所有的依赖库

### 修改Podfile文件，原生安装React Native依赖库
> 后面我们都是使用Pod来管理原生的依赖库，安装React Native依赖库，我们只需要将下面的Podfile文件中的内容添加进去，执行 `pod install` 安装即可

*Podfile文件*

```
# Uncomment the next line to define a global platform for your project
  platform :ios, '9.0'
# Uncomment the next line if you're using Swift or would like to use dynamic frameworks
# use_frameworks!

target 'iOSHybridRNDemo' do
  
  # Pods for iOSHybridRNDemo

    #***********************************************************************#
   
    # 'node_modules'目录一般位于根目录中
    # 但是如果你的结构不同，那你就要根据实际路径修改下面的`:path`
    pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'RCTText',
    'RCTImage',
    'RCTActionSheet',
    'RCTGeolocation',
    'RCTNetwork',
    'RCTSettings',
    'RCTVibration',
    'BatchedBridge',
    'RCTWebSocket',
    'ART',
    'RCTAnimation',
    'RCTBlob',
    'RCTCameraRoll',
    'RCTPushNotification',
    'RCTLinkingIOS',
    'DevSupport'
    # 在这里继续添加你所需要的模块
    ]

    # 如果你的RN版本 >= 0.42.0，请加入下面这行
    pod "yoga", :path => "../node_modules/react-native/ReactCommon/yoga"
    
    #***********************************************************************#

    pod 'RNVectorIcons', :path => '../node_modules/react-native-vector-icons'

end

```

**注意：** `#*************************# 中间的内容是我们需要添加的RN依赖库，后面我们所有pod 相关的命令，我们都需要iOS根目录（有Podfile文件的目录）下执行`

* 执行安装命令

```
$ pod install
```

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/68022585.jpg)


### 在iOS原生页面填加RN页面入口
> 现在我就来实现从原生页面跳RN页面

* 使用RN提供一个View视图代码如下

```
NSURL * jsCodeLocation;
#ifdef DEBUG
    NSString * strUrl = @"http://localhost:8081/index.ios.bundle?platform=ios&dev=true";
    jsCodeLocation = [NSURL URLWithString:strUrl];
#else
    jsCodeLocation = [CodePush bundleURL];
#endif
    
    NSDictionary *params = @{@"componentName":@"MeApp1", @"args":@{@"params":@"这是原生传递的参数"}};

    RCTRootView * rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                         moduleName:@"iOSRN"
                                                  initialProperties:params
                                                      launchOptions:nil];
    self.view = rootView;
```

### 修改RN入口文件 index.ios.js
> 修改RN页面的入口文件，这里当是iOS入口我们修改index.ios.js文件，当Android入口，我们修改index.android.js文件

* index.ios.js文件

```
import React, {Component} from 'react'
import {
  Platform,
  StyleSheet,
  Text,
  View,
  AppRegistry
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

type Props = {};
export default class App extends Component<Props> {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit App.js
        </Text>
        <Text style={styles.instructions}>
          {instructions}
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('iOSHybridRNDemo', () => App)
```

### 执行`npm start` 运行项目
> 到这里，我们一个简单的原生嵌入RN开发工程就搭建完成了，我们执行下面命令来运行项目，查看效果

* 开启node 服务

```
$ npm start
```

* 运行效果

![](http://ovyjkveav.bkt.clouddn.com/18-3-8/87889727.jpg)
