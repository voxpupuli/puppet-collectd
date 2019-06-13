#!/usr/bin/env python3

import os, sys
import subprocess
import socket

sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python_task_helper', 'files'))
from task_helper import TaskHelper


HOSTNAME = socket.gethostname()
class GetVal(TaskHelper):
    def task(self, args):
        fullmetric = HOSTNAME+'/'+args['metric']
        results = subprocess.check_output(['/usr/bin/collectdctl', 'getval',fullmetric]).rstrip().decode().split('\n')
        values = { k:v for k,v in (x.split('=')  for x in results)}
        return {
                  'metric': args['metric'],
                  'values': values
               }

if __name__ == '__main__':
    GetVal().run()

