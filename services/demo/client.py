import json
import zmq

def main():
    # Конфигурация ZeroMQ: указываем порт, к которому будет подключаться клиент
    port = 5555

    # Создаем контекст для ZeroMQ (это нужно для работы с сокетами)
    context = zmq.Context()

    # Создаем сокет для отправки запросов (типа REQ - запрос)
    socket = context.socket(zmq.REQ)
    # Подключаем сокет к указанному адресу сервера
    socket.connect(f"tcp://localhost:{port}")

    # Подготавливаем сообщение в виде словаря
    message = {"id": 1, "message": "Hello, ZeroMQ!"}
    # Преобразуем словарь в строку JSON для отправки
    request = json.dumps(message)

    # Отправляем запрос на сервер
    socket.send_string(request)

    # Ожидаем и получаем ответ от сервера
    response = socket.recv_string()
    print(f"Received response: {response}")

    # Закрываем сокет и контекст для освобождения ресурсов
    socket.close()
    context.term()

# Запуск основной функции при запуске скрипта
if __name__ == "__main__":
    main()