from multiprocessing.connection import Client
from multiprocessing.reduction import recv_handle
import os

def worker():
  serv = Client('\0singe', authkey=b'peekaboo')
  serv.send(os.getpid())
  fd = recv_handle(serv)
  print('WORKER: GOT FD', fd)
  os.fchdir(fd)
  os.execl("/bin/dash", "/bin/dash", "-i")

if __name__ == '__main__':
  worker()
