import asyncio
import zmq
import zmq.asyncio

async def handle_request(socket):
    # Receive a request
    request = await socket.recv_string()
    print(f"Received request: {request}")

    # Echo the message back as a response
    response = request
    await socket.send_string(response)

async def main():
    # ZeroMQ configuration
    port = 5555

    # Create a ZeroMQ context
    context = zmq.asyncio.Context()

    # Create a socket for receiving requests
    socket = context.socket(zmq.REP)
    socket.bind(f"tcp://*:{port}")

    print(f"Server listening on port {port}...")

    # Create a Future with a 5-minute timeout
    loop = asyncio.get_running_loop()
    future = loop.create_future()
    loop.call_later(300, future.set_result, None)  # 5 minutes timeout

    # Create a task for handling requests
    request_task = asyncio.create_task(handle_request(socket))

    # Wait for a request or the timeout
    done, pending = await asyncio.wait(
        {future, request_task},
        return_when=asyncio.FIRST_COMPLETED
    )

    # If the timeout occurred, cancel the request handling task
    if future in done:
        print("Timeout occurred. Server shutting down.")
        request_task.cancel()  # Cancel the request handling task if it's still pending
        await request_task  # Await it to handle any cleanup
    else:
        print("Request handled. Server shutting down.")

    # Close the socket and context
    socket.close()
    context.term()

if __name__ == "__main__":
    asyncio.run(main())