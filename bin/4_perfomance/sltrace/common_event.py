import re
import sys
try:
        from prettytable import PrettyTable
except:
        print("cannot find '%s' module" % 'prettytable')
        print("pleae run 'sudo easy_install %s'" % 'prettytable')
        sys.exit(1)

class EventType:
	mm_fault = 1
	mm_vmscan = 2
	mm_vmscan_direct = 3

class CommonEvent:
        def __init__(self, comm, pid, cpu, ts, event):
                self.common_comm = comm
                self.common_pid = pid
                self.common_cpu = cpu
                self.timestamp = ts
                self.event = event

        def __str__(self):
                info = (self.common_comm + " " + "pid:" + " " + str(self.common_pid) + " " +
                        "ts:" + " " + str(self.timestamp) + " " + str(self.event))
                return info

class CommonHandler:
	def __init__(self):
		return

	def show_stat(self, task, table):
		return

	def show_stat_system(self, tasks, table):
		return

	def show_inode_wide(self, table):
		return

	def show_period_wide(self, tasks, interval):
		return
