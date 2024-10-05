# Basic Client-Server Demo

This sequence diagram illustrates the interaction between a client (client.py) and a server (server.py) using Apache Pulsar as a messaging system. The sequence shows how the client sends a request to the server, and the server responds back to the client through Pulsar topics.

```mermaid
sequenceDiagram
    participant Client as client.py
    participant Server as server.py
    participant Pulsar as Apache Pulsar

    Note over Client,Server: Pulsar client configuration
    Client->>Pulsar: Subscribe to response topic ("my-response-topic")
    Server->>Pulsar: Subscribe to request topic ("my-request-topic")

    Note over Client: Prepare message
    Client->>Pulsar: Send message to request topic ("my-request-topic") with payload {"id": 1, "message": "Hello, Pulsar!"}
    Pulsar->>Server: Forward message to request consumer

    Note over Server: Receive request
    Server->>Pulsar: Send response to response topic ("my-response-topic") with payload (echoed message)
    Pulsar->>Client: Forward response to response consumer

    Note over Client: Receive response
    Client->>Pulsar: Acknowledge response on response topic ("my-response-topic")
    Server->>Pulsar: Acknowledge request on request topic ("my-request-topic")
```