# Atlas

This app requires a 3rd party API key from https://openweathermap.org. You can get your own free key
by signing up for an account, then creating a new API Key here:

https://home.openweathermap.org/api_keys

Next you'll right-click on the `Configuration` folder in the Xcode sidebar, and select _Reveal in Finder_. Duplicate the file `secrets.template.xcconfig` and rename it to `secrets.xcconfig`. Then edit the file and enter your API Key there.

## Security

Secret Management API Keys are Stored in Xcode Configuration
SSL/Certificate Pinning using Intermediate Certificate Authority (CA) certificates for openweathermap.org
