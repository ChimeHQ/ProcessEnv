import Foundation

#if os(macOS) || os(Linux)

public extension Process {
	/// Wraps up all of the parameters needed for starting a Process into one single type.
	struct ExecutionParameters: Codable, Hashable, Sendable {
        public var path: String
        public var arguments: [String]
        public var environment: [String : String]?
        public var currentDirectoryURL: URL?

        public init(path: String, arguments: [String] = [], environment: [String : String]? = nil, currentDirectoryURL: URL? = nil) {
            self.path = path
            self.arguments = arguments
            self.environment = environment
            self.currentDirectoryURL = currentDirectoryURL
        }

        public var command: String {
            return ([path] + arguments).joined(separator: " ")
        }

        /// Returns parameters that emulate an invocation in the user's shell
        ///
        /// This is done by executing:
        ///
        ///     shellExecutablePath -ilc <command>
        ///
        /// This method executes this with the `environment` environment
        /// variables set. But, it also ensures that the `TERM`, `HOME`, and
        /// `PATH` variables have values, if aren't present in `environment`.
        ///
        /// The `-i` and `-l` flags are critical, as they control how many
        /// shells read configuration files.
        public func userShellInvocation() -> ExecutionParameters {
            let processInfo = ProcessInfo.processInfo

            #if !os(Linux)
                let shellPath = processInfo.shellExecutablePath
                let args = ["-ilc", command]
            #else
                let shellPath = "setsid"
                let args = [processInfo.shellExecutablePath, "-ilc", command]
            #endif
            let cwdURL = currentDirectoryURL

            let defaultEnv = ["TERM": "xterm-256color",
                              "HOME": processInfo.homePath,
                              "PATH": processInfo.path]

            let baseEnv = environment ?? defaultEnv

            let env = baseEnv.merging(defaultEnv, uniquingKeysWith: { (a, _) in a })

            return ExecutionParameters(path: shellPath,
                                       arguments: args,
                                       environment: env,
                                       currentDirectoryURL: cwdURL)
        }
    }

    private var compatibleCurrentDirectoryURL: URL? {
        get {
            if #available(macOS 10.13, *) {
                return currentDirectoryURL
            } else {
                return URL(fileURLWithPath: currentDirectoryPath, isDirectory: true)
            }
        }
        set {
            if #available(macOS 10.13, *) {
                currentDirectoryURL = newValue
                return
            }

            if let cwdPath = newValue?.path {
                self.currentDirectoryURL = URL(fileURLWithPath: cwdPath, isDirectory: true)
            }
        }
    }

    var parameters: ExecutionParameters {
        get {
            var path = ""
            if let url = self.executableURL {
                path = url.path
            }
            return ExecutionParameters(path: path,
                                       arguments: arguments ?? [],
                                       environment: self.environment,
                                       currentDirectoryURL: self.compatibleCurrentDirectoryURL)
        }
        set {
            self.executableURL = URL(fileURLWithPath: newValue.path, isDirectory: true)
            self.arguments = newValue.arguments
            self.environment = newValue.environment
            self.compatibleCurrentDirectoryURL = newValue.currentDirectoryURL

        }
    }

    convenience init(parameters: ExecutionParameters) {
        self.init()

        self.parameters = parameters
    }
}

#endif
