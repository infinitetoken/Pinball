# Pinball

Pinball is a tiny networking library for Swift!

- [Installation](#installation)
- [Usage](#usage)
- [Reference](#reference)
- [License](#license)

## Installation

Pinball can be installed using the Swift Package Manager. Add the following to your `Package.swift` file:

```swift

dependencies: [
    .Package(url: "https://github.com/infinitetoken/Pinball.git", from: "1.0.0")
]

```

## Usage

```swift

import Pinball

let paths: [String] = ["widgets"]
let queries: [Pinball.Query] = [
    Pinball.Query(key: "foo", value: "bar")
]
let headers: [Pinball.Header] = [
    Pinball.Header.accept("application/json"),
    Pinball.Header.contentType("application/json")
]
let data: Data = ...

let endpoint = Pinball.Endpoint(method: .get, scheme: .https, host: "localhost", port: 3000, user: "example", password: "password", paths: paths, queries: queries, headers: headers, data: data)

do {
    let dataTask = try URLSession.shared.dataTask(for: endpoint)
    
    // Do something with the data task!
} catch {
    // Failed!
}

do {
    let _ = try URLSession.shared.dataTask(for: endpoint, completionHandler: { (data, response, error) in 
        // Do something with response!
    })
} catch {
    // Failed!
}

do {
    let publisher = try URLSession.shared.dataTaskPublisher(for: endpoint)
    
    // Do something with the Combine publisher!
} catch {
    // Failed!
}

```

## Reference

- [Introducing Pinball](https://medium.com/infinite-token/introducing-pinball-6ba3ee93771c)

## License

Pinball is released under the MIT license. [See LICENSE](https://github.com/infinitetoken/Pinball/blob/master/LICENSE) for details.
