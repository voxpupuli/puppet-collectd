#!/usr/bin/env python3

import os, sys
import subprocess
import socket

sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python_task_helper', 'files'))
from task_helper import TaskHelper


HOSTNAME = socket.gethostname()
class ListVal(TaskHelper):
    def task(self, args):
        values = subprocess.check_output(['/usr/bin/collectdctl', 'listval']).rstrip().decode().split('\n')
        metrics = [v.replace(HOSTNAME+'/', '') for v in values]
        return {'metrics': metrics}

if __name__ == '__main__':
    ListVal().run()

