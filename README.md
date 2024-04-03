<div align="center">

[![Build Status][build status badge]][build status]
[![Platforms][platforms badge]][platforms]

</div>

# ProcessEnv

ProcessEnv is a small library for capturing a user's shell configuration. This is very handy for launching `Process` instances with the same configuration. It also contains a few niceties for working with `Process`.

## Integration

Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ChimeHQ/ProcessEnv", branch: "main")
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

## Contributing and Collaboration

I would love to hear from you! Issues or pull requests work great. A [Discord server][discord] is also available for live help, but I have a strong bias towards answering in the form of documentation.

I prefer collaboration, and would love to find ways to work together if you have a similar project.

I prefer indentation with tabs for improved accessibility. But, I'd rather you use the system you want and make a PR than hesitate because of whitespace.

By participating in this project you agree to abide by the [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

[build status]: https://github.com/ChimeHQ/ProcessEnv/actions
[build status badge]: https://github.com/ChimeHQ/ProcessEnv/workflows/CI/badge.svg
[platforms]: https://swiftpackageindex.com/ChimeHQ/ProcessEnv
[platforms badge]: https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FChimeHQ%2FProcessEnv%2Fbadge%3Ftype%3Dplatforms
[discord]: https://discord.gg/esFpX6sErJ
[discord badge]: https://img.shields.io/badge/Discord-purple?logo=Discord&label=Chat&color=%235A64EC
