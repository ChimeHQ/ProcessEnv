[![Build Status][build status badge]][build status]
[![License][license badge]][license]
[![Platforms][platforms badge]][platforms]

# ProcessEnv

ProcessEnv is a small library for capturing the shell configuration used by a Foundation/AppKit process. This is very handy for launching `Process`/`NSTask` instances with the same configuration.

## Integration

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/ProcessEnv")
]
```

## Extensions

The bulk of code is in the form of extensions on `ProcessInfo`, for accessing various environment variables. A single `[String : String]` dictionary of the user's environment is available as the `userEnvironment` property.

```swift
ProcessInfo.processInfo.userEnvironment

ProcessInfo.processInfo.path // $PATH
ProcessInfo.processInfo.homePath
ProcessInfo.processInfo.shellExecutablePath
```

### Suggestions or Feedback

We'd love to hear from you! Get in touch via an issue or pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

[build status]: https://github.com/ChimeHQ/ProcessEnv/actions
[build status badge]: https://github.com/ChimeHQ/ProcessEnv/workflows/CI/badge.svg
[license]: https://opensource.org/licenses/BSD-3-Clause
[license badge]: https://img.shields.io/github/license/ChimeHQ/ProcessEnv
[platforms]: https://swiftpackageindex.com/ChimeHQ/ProcessEnv
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FChimeHQ%2FProcessEnv%2Fbadge%3Ftype%3Dplatforms
