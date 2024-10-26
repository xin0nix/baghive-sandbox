import json
import zmq

def main():
    # ZeroMQ configuration
    port = 5555

    # Create a ZeroMQ context
    context = zmq.Context()

    # Create a socket for sending requests
    socket = context.socket(zmq.REQ)
    socket.connect(f"tcp://localhost:{port}")

    # Prepare a message
    message = {"id": 1, "message": "Hello, ZeroMQ!"}
    request = json.dumps(message)

    # Send the request
    socket.send_string(request)

    # Receive the response
    response = socket.recv_string()
    print(f"Received response: {response}")

    # Close the socket and context
    socket.close()
    context.term()

if __name__ == "__main__":
    main()