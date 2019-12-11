from common_event import *
from prettytable import PLAIN_COLUMNS

class MmFaultEvent(CommonEvent):
	def __init__(self, comm, pid, cpu, ts, event,
		address, flags, ret, major, emulate = False):
		CommonEvent.__init__(self, comm, pid, cpu, ts, event)
		self.address = address
		self.flags = flags
		self.ret = ret
		self.major = major
		self.run_time = 0

class MmFaultHandler(CommonHandler):
	def __init__(self):
		self.entry_re = re.compile(r'address=(.+) flags=(.+)')
		self.exit_re = re.compile(r'ret=(.+) major=(.+)')

		self.functions = {"mm_fault_begin" : self.fault_begin,
					"mm_fault_end" : self.fault_end}
		self.run = 0
		self.count = 0
		self.maj_count = 0
		self.maj_run = 0
		self.max_maj_run = 0

		self.interval = {}
		self.maj_interval = {}

	def fault_begin(self, task, event_raw, event_arg):
		res = self.entry_re.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmFaultEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event, int(groups[0], 16),
					int(groups[1], 16), int("0x0", 16),
					0)

		task.event_list[EventType.mm_fault].append(event)

	def fault_end(self, task, event_raw, event_arg):
		res = self.exit_re.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmFaultEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event, int("0x0", 16),
					int("0x0", 16), int(groups[0], 16),
					int(groups[1]))

		if len(task.event_list[EventType.mm_fault]) == 0:
			return

		prev_event = task.event_list[EventType.mm_fault].pop()
		if not prev_event:
			return

		prev_event.major = event.major
		prev_event.ret = event.ret
		prev_event.run_time = event.timestamp - prev_event.timestamp

		task.fault_run_time += prev_event.run_time
		task.done_list[EventType.mm_fault].append(prev_event)

	def show_stat(self, task, table):
		run = 0
		maj_run = 0
		count = 0
		maj_count = 0
		max_maj_run = 0

		for event in task.done_list[EventType.mm_fault]:
			run += event.run_time
			count += 1
			if event.major == 1:
				maj_run += event.run_time
				maj_count += 1
				max_maj_run = max(max_maj_run, event.run_time)

		table.add_row(["fault run", run])
		table.add_row(["major fault run", maj_run])
		table.add_row(["fault count", count])
		table.add_row(["major fault count", maj_count])
		table.add_row(["max major fault run", max_maj_run])

	def __calc_total_stat(self, tasks, interval = 0):
		for pid in tasks.keys():
			task = tasks[pid]
			for event in task.done_list[EventType.mm_fault]:
				self.run += event.run_time
				self.count += 1
				if event.major:
					self.maj_count+=1
					self.maj_run += event.run_time
					self.max_maj_run = max(
						event.run_time, self.max_maj_run)

				if interval:
					idx = event.timestamp / interval
					try:
						if event.major:
							self.maj_interval[idx] += 1
						else:
							self.interval[idx] += 1
					except KeyError:
						if event.major:
							self.maj_interval[idx] = 1
						else:
							self.interval[idx] = 1

	def show_stat_wide(self, tasks, table):
		self.__calc_total_stat(tasks)

		table.add_row(["total fault run", self.run])
		table.add_row(["total major fault run", self.maj_run])
		table.add_row(["total fault count", self.count])
		table.add_row(["total major fault count", self.maj_count])
		table.add_row(["max major fault run", self.max_maj_run])

	def show_period_wide(self, tasks, interval):
		self.__calc_total_stat(tasks, interval)

		table = PrettyTable(["period", "fault", "maj_fault"])
		table.align["period"] = "l"
		table.align["fault"] = "r"
		table.align["maj_fault"] = "r"
		table.padding_width = 1
		# table.set_style(PLAIN_COLUMNS)

		for ts in self.interval.keys():
			sample = self.interval[ts]
			try:
				maj_sample = self.maj_interval[ts]
			except KeyError:
				maj_sample = 0
			start = ts * interval / 1000000.0
			end = (ts * interval + interval) / 1000000.0
			table.add_row([str(start) + "-" + str(end) , sample, maj_sample])

		print table
