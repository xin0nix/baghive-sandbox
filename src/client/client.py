import json
from pulsar import Client


def main():
    # Pulsar client configuration
    pulsar_url = "pulsar://localhost:6650"
    request_topic = "my-request-topic"
    response_topic = "my-response-topic"

    # Create a Pulsar client
    client = Client(pulsar_url)

    # Create producers and consumers for request and response topics
    producer = client.create_producer(request_topic)
    consumer = client.subscribe(response_topic, subscription_name="my-subscription")

    # Prepare a message
    message = {"id": 1, "message": "Hello, Pulsar!"}
    producer.send(json.dumps(message).encode("utf-8"))

    # Wait for response
    msg = consumer.receive(timeout_millis=None)  # 30 seconds timeout
    try:
        print(f"Received response: {msg.data().decode('utf-8')}")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        consumer.acknowledge(msg)
        client.close()


if __name__ == "__main__":
    main()
