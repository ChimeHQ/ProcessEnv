[![Github CI](https://github.com/ChimeHQ/ProcessEnv/workflows/CI/badge.svg)](https://github.com/ChimeHQ/ProcessEnv/actions)

# ProcessEnv

ProcessEnv is a small library for capturing the shell configuration used by a Foundation/AppKit process. This is very handy for launching `Task`/`NSTask` instances with the same configuration.

## Integration

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/ProcessEnv.git")
]
```

Carthage:

You can use [Carthage](https://github.com/Carthage/Carthage) to install this as a static library.

```
github "ChimeHQ/ProcessEnv"
```

## Extensions

The bulk of code is in the form of extensions on `ProcessInfo`, for accessing various environment variables. A single `[String:String]` dictionary of the user's environment is available as the `userEnvironment` property.

```swift
ProcessInfo.processInfo.userEnvironment

ProcessInfo.processInfo.path // $PATH
ProcessInfo.processInfo.homePath
ProcessInfo.processInfo.shellExecutablePath
```

### Suggestions or Feedback

We'd love to hear from you! Get in touch via [twitter](https://twitter.com/chimehq), an issue, or a pull request.

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
