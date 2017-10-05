##  About
Combining a modified Bitcoin Core infrastructure with an intercompatible version of the Ethereum Virtual Machine (EVM), Qtum merges the reliability of Bitcoin’s unfailing blockchain with the endless possibilities provided by smart contracts. 
Designed with stability, modularity and interoperability in mind, Qtum is the foremost toolkit for building trusted decentralized applications, suited for real-world, business oriented use cases. Its hybrid nature, in combination with a first-of-its-kind PoS consensus protocol, allow Qtum applications to be compatible with major blockchain ecosystems, while providing native support for mobile devices and IoT appliances.

## Getting Started

1) Clone project<br/>
2) Install CocoaPods

Для установки CocoaPods на Ваш компьютер.

```bash
$ gem install cocoapods
```
> ios version 8+.

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

## Изменение параметров сети

#### Изменение testnet/mainnet

В файле AppSettings.m в методе ```setup``` поменять ```[NSUserDefaults saveIsMainnetSetting:NO];``` на ```YES/NO```

```objective-c
-(void)setup {

    if (![NSUserDefaults isNotFirstTimeLaunch]) {

        [NSUserDefaults saveIsDarkSchemeSetting:YES];
        [NSUserDefaults saveIsNotFirstTimeLaunch:YES];
    }

    [NSUserDefaults saveCurrentVersion:[[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]];
    [NSUserDefaults saveIsRPCOnSetting:NO];
    [NSUserDefaults saveIsMainnetSetting:NO];

    [PopUpsManager sharedInstance];
    [self setupFabric];
    [self setupFingerpring];
}
```

#### Изменение параметров сети

В файле BTCAddress+Extension.m  поменять значение в enum на необходимые

```objective-c
enum
{
    CustomBTCPublicKeyAddressVersion         = 58,
    CustomBTCPrivateKeyAddressVersion        = 128,
    CustomBTCScriptHashAddressVersion        = 50,
    CustomBTCPublicKeyAddressVersionTestnet  = 120,
    CustomBTCPrivateKeyAddressVersionTestnet = 239,
    CustomBTCScriptHashAddressVersionTestnet = 110,
};
```

## Technologies

#### Third Party Libraries
- ``` 'AFNetworking'```  – HTTP Client
- ``` 'MTBBarcodeScanner'```  – QR-Code/Barcode scanner
- ``` 'SVProgressHUD'```  – Custom Loader
- ``` 'CoreBitcoin'```   Bitcoin toolkit for Objective-C

#### Core Bitcoin

CoreBitcoin implements Bitcoin protocol in Objective-C and provides many additional APIs to make great apps.
CoreBitcoin deliberately implements as much as possible directly in Objective-C with limited dependency on OpenSSL. This gives everyone an opportunity to learn Bitcoin on a clean codebase and enables all Mac and iOS developers to extend and improve Bitcoin protocol.

Link: https://github.com/oleganza/CoreBitcoin
