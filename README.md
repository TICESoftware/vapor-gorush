# Gorush Service for Vapor

This service allows to easily integrate [Gorush](https://github.com/appleboy/gorush) into [Vapor](https://vapor.codes) to send push notifications.

## Installation
### Add the package to the `Package.swift`
```swift
.package(url: "https://github.com/code28/vapor-gorush.git", from: "0.3.0")
// ...
.target(name: "App", dependencies: ["Vapor", "Gorush"])
```

### Register Gorush in `configure.swift`
```swift
let hostname = Environment.get("GORUSH_HOSTNAME")
let port = Environment.get("GORUSH_PORT")
services.register(Gorush.self) { container in
    return Gorush(hostname: hostname, port: port)
}
```
Per default, HTTPS will be used. To use HTTP instead, just add `httpScheme: .http` into that initialization.

## Usage
```swift
import Gorush
// ...
let notification = GorushNotification(tokens: ["deviceToken"], platform: .ios, message: "Push message", title: "Push title")

let gorush = container.make(Gorush.self)
gorush.dispatch(notification, on: worker).map { (response: GorushResponse) in
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
