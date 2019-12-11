import re
import operator
from common_event import *
from mm_fault import *
from mm_vmscan import *
from mm_filemap import *
from task import *
import prettytable

class EventParser:
	def __init__(self):
                self.event_re = re.compile(
                        r'\s*(.+)-([0-9]+)\s+\[([0-9]+)\][^:]*\s+([0-9.]+): ([^:]*): (.*)')

		self.event_traces = []
		self.event_traces.append(MmFaultHandler())
		self.event_traces.append(MmVmScanHandler())
		self.event_traces.append(MmFilemapHandler())
		self.tasks = {}
		self.s_time = sys.maxint
		self.e_time = 0

	def get_task(self, pid, comm):
		if self.tasks.has_key(pid):
			return self.tasks[pid]

		new_task = Task(pid, comm)
		self.tasks[pid] = new_task
		return new_task
			
			
	def process(self, line):
		line = line.rstrip()
		res = self.event_re.match(line)
		if res == None:
			return

		groups = res.groups()
                event = CommonEvent(groups[0], int(groups[1]), int(groups[2]),
                        int(float(groups[3])*1000000), groups[4])

		self.s_time = min(event.timestamp, self.s_time)
		self.e_time = max(event.timestamp, self.e_time)

		task = self.get_task(event.common_pid, event.common_comm)
		for trace in self.event_traces:
			function = None
			if trace.functions.has_key(event.event):
				function = trace.functions[event.event]
				function(task, event, groups[5])
				task.s_time = min(task.s_time, event.timestamp)
				task.e_time = event.timestamp

	def show_stat(self, sort, task_filter):
		# move dict into list
		sltraces = []
		for pid in self.tasks.keys():
			sltraces.append(self.tasks[pid])

		if sort == "pid":
			sltraces = sorted(sltraces, key=operator.attrgetter("pid"),
				reverse = True)
		elif sort == "reclaim":
			sltraces = sorted(sltraces, key=operator.attrgetter("reclaim"),
				reverse = True)
		elif sort == "fault":
			sltraces = sorted(sltraces, key=operator.attrgetter("fault_run_time"),
				reverse = True)


		for task in sltraces:
			# there is no event
			if task.s_time == sys.maxint:
				continue

			try:
				if eval(task_filter) == False:
					continue
			except:
				pass

			table = PrettyTable([task.comm + '-' + str(task.pid),
				str(task.s_time / 1000000.0) + '-' + str(task.e_time/1000000.0)])
			table.align[task.comm + '-' + str(task.pid)] = "l"
			table.align["elapsed time(us)"] = "r"
			table.padding_width = 1
			for trace in self.event_traces:
				trace.show_stat(task, table)
			print table

	def show_stat_wide(self):
		header = ("total" + '(' + str(self.s_time / 1000000.0) +
				'-' + str(self.e_time / 1000000.0) + ')')
		table = PrettyTable([header, "stat"])
		table.align[header] = "l"
		table.align["stat"] = "r"
		table.padding_width = 1

		for trace in self.event_traces:
			trace.show_stat_wide(self.tasks, table)
		print table

	def show_inode_wide(self):
		table = PrettyTable(["ino", "read", "dup_read"])
		# table.set_style(prettytable.PLAIN_COLUMNS)
		table.align["ino"] = "r"
		table.align["read"] = "r"
		table.align["dup_read"] = "r"
		table.padding_width = 1

		for trace in self.event_traces:
			trace.show_inode_wide(table)
		print table

	def show_period_wide(self, interval):
		for trace in self.event_traces:
			trace.show_period_wide(self.tasks, interval)
