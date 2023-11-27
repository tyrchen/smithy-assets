$version: "2.0"

namespace com.example

use aws.protocols#restJson1
use smithy.framework#ValidationException

/// Echoes input
@restJson1
service EchoService {
    version: "2006-03-01"
    operations: [EchoMessage]
}

@http(uri: "/echo", method: "POST")
operation EchoMessage {
    input := {
        @required
        @httpHeader("x-echo-message")
        message: String
    }
    output := {
        @required
        message: String
    }
    errors: [ValidationException]
}
