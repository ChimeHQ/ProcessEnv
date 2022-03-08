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

    func testParameterCommand() throws {
        let params = Process.ExecutionParameters(path: "cmd", arguments: ["-u", "-v"])

        XCTAssertEqual(params.command, "cmd -u -v")
    }

    func testUserShellParameters() throws {
        let params = Process.ExecutionParameters(path: "cmd", arguments: ["-u", "-v"])

        let userParams = params.userShellInvocation()

        XCTAssertEqual(userParams.path, ProcessInfo.processInfo.shellExecutablePath)
        XCTAssertEqual(userParams.arguments, ["-ilc", "cmd -u -v"])
    }
}
