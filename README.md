# Gorush Service for Vapor

This service allows to easily integrate [Gorush](https://github.com/appleboy/gorush) into [Vapor](https://vapor.codes) to send push notifications.

## Installation
### Add the package to the `Package.swift`
```swift
.package(url: "https://github.com/TICESoftware/vapor-gorush.git", from: "1.0.0")
// ...
.target(name: "App", dependencies: ["Vapor", "Gorush"])
```
From version 1.0.0, this uses Vapor 4. If you want to use Gorush in Vapor 3, you can use version 0.9.0.

### Register Gorush in `configure.swift`
```swift
let hostname = Environment.get("GORUSH_HOSTNAME")
app.gorush.use { req in
    Gorush(client: req.client, hostname: hostname)
}
```
Per default, HTTPS will be used. To use HTTP instead, just add `httpScheme: .http` into that initialization.

## Usage
```swift
import Gorush
// ...
let notification = GorushNotification(tokens: ["deviceToken"], platform: .ios, message: "Push message", title: "Push title")

req.gorush.dispatch(notification, on: req.eventLoop).map { (response: GorushResponse) in
    if !response.logs.isEmpty {
        // This means an error occurred, if Gorush was configured to return errors
    }
}
// ...
```

## License
This vapor-gorush package is released under an MIT license. See [License](LICENSE) for more information.

## Todo

- [ ] Parse Gorush response and answer with succeeded or failed future
- [ ] Write further documentation
- [ ] Complete fields for Gorush notification
- [ ] Write tests
