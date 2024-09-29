from pulsar import Client
import time


def main():
    # Pulsar client configuration
    pulsar_url = "pulsar://localhost:6650"
    request_topic = "my-request-topic"
    response_topic = "my-response-topic"

    # Create a Pulsar client
    client = Client(pulsar_url)

    # Create producers and consumers for request and response topics
    request_consumer = client.subscribe(
        request_topic, subscription_name="my-request-subscription"
    )
    response_producer = client.create_producer(response_topic)

    while True:
        msg = request_consumer.receive(timeout_millis=None)  # No timemout
        try:
            print(f"Received request: {msg.data().decode('utf-8')}")
            # Echo the message back
            response_producer.send(msg.data())
        except Exception as e:
            print(f"Error: {e}")
        finally:
            request_consumer.acknowledge(msg)
        time.sleep(1)


if __name__ == "__main__":
    main()
