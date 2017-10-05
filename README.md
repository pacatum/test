#### About
Combining a modified Bitcoin Core infrastructure with an intercompatible version of the Ethereum Virtual Machine (EVM), Qtum merges the reliability of Bitcoin’s unfailing blockchain with the endless possibilities provided by smart contracts. 
Designed with stability, modularity and interoperability in mind, Qtum is the foremost toolkit for building trusted decentralized applications, suited for real-world, business oriented use cases. Its hybrid nature, in combination with a first-of-its-kind PoS consensus protocol, allow Qtum applications to be compatible with major blockchain ecosystems, while providing native support for mobile devices and IoT appliances.

## Getting Started

1) Clone project<br/>
2) Install CocoaPods

Для установки CocoaPods на Ваш компьютер.

```bash
$ gem install cocoapods
```
> Xcode 8 + 9.

Далее в териминале заходим в папку проекта и вводим команду для загрузки и подключения библиотек

```bash
$ pod install
```

3) Install Carthage

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

Далее в териминале заходим в папку проекта и вводим команду для загрузки и подключения библиотек.

```bash
$ carthage update --platform iOS
```

## Изменение ссылок на API

Change return value in ```baseURL``` method in AppSettings.m like this

```objective-c
-(NSString*)baseURL {

NSString* baseUrl = @"http://163.172.251.4:5931/";
return baseUrl;
}
```

<b>Gradle version</b><br/>
```
com.android.tools.build:gradle:2.3.3
```

<b>Minimal Android SDK Version</b><br/>
```
19
```

<b>Build Tools version</b><br/>
```
25.0.3
``` 

<b>Technologies</b><br/>
- Java (v. 7)
- Google Firebase (v. 9.0.2)
- Java RX (v. 1.1.6, Android RX – v. 1.2.1)
- Retrofit 2 (v. 2.1.0)
- Socket IO (v. 0.8.3)

<b>Third Party Libraries (gradle)</b><br/>
- ``` 'com.github.designsters:android-fork-bitcoinj:1.+'```  – fork bitcoinj (with QTUM functionality)
- ``` 'com.google.zxing:core:3.2.1'```  – QR-Code/Barcode scanner
- ``` 'io.reactivex:rxjava:1.1.6', 'io.reactivex:rxandroid:1.2.1'```  – Java RX
- ``` 'io.socket:socket.io-client:0.8.3'```  - Socket IO Client
- ``` 'com.squareup.retrofit2:retrofit:2.1.0'```  HTTP Client

<b>Android Fork BitcoinJ</b><br/>
The android fork bitcoinj library is a Java implementation of the Bitcoin protocol, which allows it to maintain a QTUM wallet and send/receive transactions without needing a local copy of Bitcoin Core. It comes with full documentation and some example apps showing how to use it<br/>
Link: https://github.com/bitcoinj/bitcoinj

<b>BitcoinJ Technologies</b><br/>
- Java 6 for the core modules, Java 8 for everything else
- Maven 3+ - for building the project
- Google Protocol Buffers - for use with serialization and hardware communications
