import asyncio
import zmq
import zmq.asyncio

# Асинхронная функция для обработки запросов
async def handle_request(socket):
    # Ожидаем получения строки запроса от клиента
    request = await socket.recv_string()
    print(f"Received request: {request}")

    # Эхо-ответ: отправляем обратно тот же запрос
    response = request
    await socket.send_string(response)

# Основная асинхронная функция
async def main():
    # Конфигурация ZeroMQ: указываем порт, на котором будет работать сервер
    port = 5555

    # Создаем контекст для ZeroMQ (это нужно для работы с сокетами)
    context = zmq.asyncio.Context()

    # Создаем сокет для получения запросов (типа REP - ответ на запросы)
    socket = context.socket(zmq.REP)
    # Привязываем сокет к указанному порту, чтобы слушать входящие соединения
    socket.bind(f"tcp://*:{port}")

    print(f"Server listening on port {port}...")

    # Создаем Future с таймаутом в 5 минут (300 секунд)
    loop = asyncio.get_running_loop()
    future = loop.create_future()
    # Устанавливаем таймаут: через 300 секунд вызываем future.set_result(None)
    loop.call_later(300, future.set_result, None)  # 5 минут таймаута

    # Создаем задачу для обработки запросов
    request_task = asyncio.create_task(handle_request(socket))

    # Ожидаем либо завершения обработки запроса, либо истечения таймаута
    done, pending = await asyncio.wait(
        {future, request_task},
        return_when=asyncio.FIRST_COMPLETED  # Завершаем, когда завершится одна из задач
    )

    # Если таймаут произошел, отменяем задачу обработки запроса
    if future in done:
        print("Timeout occurred. Server shutting down.")
        request_task.cancel()  # Отменяем задачу обработки запроса, если она еще не завершена
        await request_task  # Ждем завершения задачи для очистки ресурсов
    else:
        print("Request handled. Server shutting down.")

    # Закрываем сокет и контекст ZeroMQ для освобождения ресурсов
    socket.close()
    context.term()

# Запуск основной асинхронной функции при запуске скрипта
if __name__ == "__main__":
    asyncio.run(main())