import pika
import cv2

# connect to broker 
broker = MessageBroker()

#Camera capture
camcap = cv2.VideoCapture(0)

if not (camcap.isOpened()):
    print('Could not open video device')
else:
    print("Video device is ready")

while(True):
    ret, frame = camcap.read()
    cv2.imshow('preview',frame)
    broker.send(frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        print("Exited")
        break

camcap.release()

broker.closeConnection()

cv2.destroyAllWindows()



class MessageBroker: 
    
    def __init__(self):
        self.connection = pika.BlockingConnection(
            pika.ConnectionParameters(host='localhost')
        )
        self.channel = self.connection.channel()

    def send(self, data):
        self.channel.queue_declare(queue = 'PImusic')

        self.channel.basic_publish(exchange='', routing_key='PImusic', body=data)

    def startConsuming(self):
        self.channel.queue_declare(queue = 'PImusic')
        self.channel.basic_consume(queue='PImusic', on_message_callback=callback, auto_ack=True)
        print(' [*] Waiting for messages. To exit press CTRL + C')
        self.channel.start_consuming()
        
    
    def stopConsuming(self):
        self.channel.stop_consuming()

    def closeConnection(self):
        self.channel.close()

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)