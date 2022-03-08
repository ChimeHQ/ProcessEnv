import Foundation

public extension Process {
    static func execute(_ parameters: Process.ExecutionParameters) throws -> Data? {
        let task = Process(parameters: parameters)

        return try? task.runAndReadStdout()
    }

    static func executeAsUser(_ parameters: Process.ExecutionParameters) throws -> Data? {
        let userParams = parameters.userShellInvocation()

        let task = Process(parameters: userParams)

        return try? task.runAndReadStdout()
    }

    static func readOutput(from launchPath: String, arguments: [String] = [], environment: [String : String] = [:]) -> Data? {
        let params = Process.ExecutionParameters(path: launchPath, arguments: arguments, environment: environment)

        return try? execute(params)
    }

    func runAndReadStdout() throws -> Data? {
        let pipe = Pipe()

        standardOutput = pipe

        if #available(macOS 10.13, *) {
            try run()
        } else {
            if let launchPath = launchPath, FileManager.default.isExecutableFile(atPath: launchPath) == false {
                return nil
            }

            launch()
        }

        waitUntilExit()

        if #available(macOS 10.15.4, *) {
            return try pipe.fileHandleForReading.readToEnd()
        } else {
            return pipe.fileHandleForReading.readDataToEndOfFile()
        }
    }
}
