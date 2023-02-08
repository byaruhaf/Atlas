# Atlas

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)
![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
[![Swift Version](https://img.shields.io/badge/Swift-5.7-F16D39.svg?style=flat)](https://developer.apple.com/swift)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Twitter](https://img.shields.io/badge/twitter-@byaruhaf-blue.svg)](http://twitter.com/byaruhaf)

## Overview

Atlas is a partial demo of a weather app using the openweathermap.org API.
This branch was Compiled with Xcode 14.2.0, and Swift 5.7 and supports iOS 16 and above.

Project Documentation generate using **Apples DocC** can be accessed using this link [Documentation](https://byaruhaf.github.io/Atlas/documentation/Atlas/)

## Secrets Management

This app requires a 3rd party API key from https://openweathermap.org. You can get your own free key
by signing up for an account, then creating a new API Key here:

https://home.openweathermap.org/api_keys

Next you'll right-click on the `Configuration` folder in the Xcode sidebar, and select _Reveal in Finder_. Duplicate the file `secrets.template.xcconfig` and rename it to `secrets.xcconfig`. Then edit the file and enter your API Key there.

## Implementation Details

### App Navigation & Function

### Persistence Implementation

The Apps Persistence is implemented using UserDefaults.
UserDefaults is used to store the users favorite cities and last time the users current location weather data was updated

### Security

Secret Management API Keys are Stored in Xcode Configuration
SSL/Certificate Pinning using Intermediate Certificate Authority (CA) certificates for openweathermap.org

### Logging

Proper logging using Apple unified logging system using the **Logger** type

### Continuous Integration & Deployment

Atlas uses Xcode Cloud to perform continuous integration and deployment.
Every push to the github repo is Built, Tested, Archive and Deploy to testflight for internal testing.
If any file changes Xcode Cloud will create a new build of the Atlas app on TestFlight.
