from multiprocessing.connection import Listener
from multiprocessing.reduction import send_handle
import socket
import os

def server():
  work_serv = Listener('\0singe', authkey=b'peekaboo')
  worker = work_serv.accept()
  print ('Got a worker')
  worker_pid = worker.recv()
  print (worker_pid)

  client = os.open("/", os.O_RDONLY)
  send_handle(worker, client, worker_pid)

if __name__ == '__main__':
  server()
