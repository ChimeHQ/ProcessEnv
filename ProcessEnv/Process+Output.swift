//
//  Process+Output.swift
//  ProcessEnv
//
//  Created by Matthew Massicotte on 2019-02-13.
//

import Foundation

extension Process {
    public static func readOutput(from launchPath: String, arguments: [String] = [], environment: [String : String] = [:]) -> Data? {
        if !FileManager.default.isExecutableFile(atPath: launchPath) {
            return nil
        }

        let task = Process()
        let pipe = Pipe()

        task.launchPath = launchPath
        task.environment = environment
        task.arguments = arguments

        task.standardOutput = pipe

        task.launch()
        task.waitUntilExit()

        return pipe.fileHandleForReading.readDataToEndOfFile()
    }
}
