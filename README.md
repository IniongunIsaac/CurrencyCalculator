#  Currency Calculator

A currency calculator app that allows you to convert amounts between `EUR` and other supported currencies.

The conversion engine is powered by [Fixer.io](https://fixer.io/) and the two important endpoints to note are:

* `/symbols` which allows us to fetch a list of supported currencies
* `/latest` which allows us to fetch the rates between `EUR` and any other supported currency. This is used against the `/convert` endpoint because the free subscription plan used for development.

## Technology Stack & Tools
The application is built using the following:

* Swift
* UIKit
* RealmSwift
* MVVM
* Xcode 14.2
* iOS 13+

## Screenshots
[<img src="/CurrencyCalculator/Screenshots/1.png" align="center" width ="35%" hspace="0" vspace="10">](/CurrencyCalculator/Screenshots/1.png)
[<img src="/CurrencyCalculator/Screenshots/2.png" align="center" width ="35%" hspace="0" vspace="10">](/CurrencyCalculator/Screenshots/2.png)
