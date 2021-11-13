//
//  ProcessEnvTests.swift
//  ProcessEnvTests
//
//  Created by Matthew Massicotte on 2021-03-10.
//

import XCTest
@testable import ProcessEnv

class ProcessEnvTests: XCTestCase {
    func testParseEnvOutput() throws {
        let output = """
            TERM=xterm-256color
            TERM_PROGRAM=Apple_Terminal
            """

        let data = ProcessInfo.processInfo.parseEnvOutput(output.data(using: .utf8)!)

        XCTAssertEqual(data, ["TERM" : "xterm-256color", "TERM_PROGRAM" : "Apple_Terminal"])
    }

    func testEnvOutputWithEqualsInValue() throws {
        let output = """
            KEY=tricky=value
            """

        let data = ProcessInfo.processInfo.parseEnvOutput(output.data(using: .utf8)!)

        XCTAssertEqual(data, ["KEY" : "tricky=value"])
    }

    func testEnvironmentVariables() throws {
        let env = ProcessInfo.processInfo.userEnvironment

        XCTAssertFalse(env.isEmpty)
        
        XCTAssertNotNil(env["SHELL"])
        XCTAssertNotNil(env["HOME"])
    }
}
