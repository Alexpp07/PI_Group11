import pika
import cv2

# connect to broker 
broker = MessageBroker()

# receive messages
broker.startConsuming()


class Broker: 
    
    def __init__(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host='localhost')
        )
        self.channel = self.connection.channel()

    def send(self):
        self.channel.queue_declare(queue = 'PImusic')

        self.channel.basic_publish(exchange='', routing_key='PImusic', body="Hello World!")

    def startConsuming(self):
        self.channel.queue_declare(queue = 'PImusic')
        self.channel.basic_consume(queue='PImusic', on_message_callback=callback, auto_ack=True)
        print(' [*] Waiting for messages. To exit press CTRL + C')
        self.channel.start_consuming()
        
        
    
    def stopConsuming(self):
        self.channel.stop_consuming()

    def closeConnection(self):
        self.channel.close()

def callback(ch, method, properties, data):
    print(" [x] Received %r" % data)
    cv2.imwrite("newimage.png", data)