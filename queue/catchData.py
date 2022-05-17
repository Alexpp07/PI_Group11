import pika
import json
import cv2

# connect to broker 
broker = Broker()

#Camera capture
camcap = cv2.VideoCapture(0)

if not (camcap.isOpened()):
    print('Could not open video device')
else:
    print("Video device is ready")

while(True):
    ret, frame = camcap.read()
    cv2.imshow('preview',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        print("Exited")
        break

camcap.release()
cv2.destroyAllWindows()






class Broker:
    def __init__(self):
        credentials = pika.PlainCredentials('myuser', 'mypassword')
        self.connection = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.160.197', port='5672', credentials=credentials))  
        self.channel = self.connection.channel()
        self.channel.queue_declare(queue='vaccination_queue', durable=True)
        
        
        '''
        self.waiting_list = list()
        self.minutes = 0
        self.hours = 8
        self.initial_date = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
        self.arriving_date = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0) + timedelta(days=2)
        self.date_to_change = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
        self.capacity_day_date = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0) + timedelta(days=2)
        self.first_name_temp = None
        self.first_time = True
        '''
    def send(self, topic="vaccination_queue", mes=None):
        """Send the message to the broker"""
        try:
            message = json.dumps(mes)
            self.channel.basic_publish(exchange='', routing_key=topic, body=message)
        except:
            print('\033[91m' + "ERROR: Could not send message to broker" + '\033[0m')
