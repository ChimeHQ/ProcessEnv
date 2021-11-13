//
//  ProcessInfo+UserEnvironment.swift
//  ProcessEnv
//
//  Created by Matthew Massicotte on 2019-02-12.
//

import Foundation

extension ProcessInfo {
    /// The path to the current user's shell executable
    ///
    /// This attempts to query the `SHELL` environment variable, the
    /// password directory (via `getpwuid`), or if those fail
    /// falls back to "/bin/bash".
    public var shellExecutablePath: String {
        if let value = environment["SHELL"], !value.isEmpty {
            return value
        }

        if let value = pwShell, !value.isEmpty {
            return value
        }

        // this is a terrible fallback, but we need something
        return "/bin/bash"
    }

    public var pwShell: String? {
        guard let passwd = getpwuid(getuid()) else {
            return nil
        }

        guard let cString = passwd.pointee.pw_shell else {
            return nil
        }

        return String(cString: cString)
    }

    public var pwUserName: String? {
        guard let passwd = getpwuid(getuid()) else {
            return nil
        }

        guard let cString = passwd.pointee.pw_name else {
            return nil
        }

        return String(cString: cString)
    }

    public var pwDir: String? {
        guard let passwd = getpwuid(getuid()) else {
            return nil
        }

        guard let cString = passwd.pointee.pw_dir else {
            return nil
        }

        return String(cString: cString)
    }
    /// Returns the value of PATH
    ///
    /// If PATH is set in the envrionment, it is returned. If not,
    /// the fallback value of "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    /// is returned.
    public var path: String {
        return environment["PATH"] ?? "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    }

    public var homePath: String {
        if let path = environment["HOME"] {
            return path
        }

        if let path = pwDir {
            return path
        }

        if #available(macOS 12.0, *) {
            return "/Users/\(userName)"
        }

        if let name = pwUserName {
            return "/Users/\(name)"
        }

        // I'm not sure there is a reasonable fallback in this situation
        return ""
    }

    public var userEnvironment: [String : String] {
        let args = ["-lc", "/usr/bin/env"]
        let defaultEnv = ["TERM": "xterm-256color",
                          "HOME": homePath,
                          "PATH": path]
        let env = environment.merging(defaultEnv, uniquingKeysWith: { (a, _) in a })

        guard let data = Process.readOutput(from: shellExecutablePath, arguments: args, environment: env) else {
            return env
        }

        return parseEnvOutput(data)
    }

     func parseEnvOutput(_ data: Data) -> [String : String] {
        guard let string = String(data: data, encoding: .utf8) else {
            return [:]
        }

        var env: [String: String] = [:]
        let charSet = CharacterSet.whitespaces

        string.enumerateLines { (line, _) in
            let components = line.split(separator: "=")

            guard let key = components.first?.trimmingCharacters(in: charSet) else {
                return
            }

            let value = components.dropFirst().joined(separator: "=").trimmingCharacters(in: charSet)

            env[key] = value
        }

        return env
    }
}
