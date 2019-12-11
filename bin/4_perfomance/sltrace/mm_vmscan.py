from common_event import *

class MmVmScanEvent(CommonEvent):
	def __init__(self, comm, pid, cpu, ts, event,
		nid, zid, nr_scanned, nr_reclaimed, priority, flags):
		CommonEvent.__init__(self, comm, pid, cpu, ts, event)
		self.nid = nid
		self.zid = zid
		self.nr_scanned = nr_scanned
		self.nr_reclaimed = nr_reclaimed
		self.priority = priority
		self.flags = flags

class MmVmScanDirectEvent(CommonEvent):
	def __init__(self, comm, pid, cpu, ts, event,
		order, may_writepage, gfp_flags, nr_reclaimed):
		CommonEvent.__init__(self, comm, pid, cpu, ts, event)
		self.order = order
		self.may_writepage = may_writepage
		self.gfp_flags = gfp_flags
		self.nr_reclaimed = 0
		self.run_time = 0

class MmVmScanHandler(CommonHandler):
	def __init__(self):
		self.re_vmscan_lru_shrink_inactive = re.compile(r'nid=(.+) zid=(.+) nr_scanned=(.+) nr_reclaimed=(.+) priority=(.+) flags=(.+)')
		self.re_vmscan_direct_reclaim_begin = re.compile(r'order=(.+) may_writepage=(.+) gfp_flags=(.+)')
		self.re_vmscan_direct_reclaim_end = re.compile(r'nr_reclaimed=(.+)')
		self.functions = {"mm_vmscan_lru_shrink_inactive" :
					self.vmscan_lru_shrink_inactive,
				"mm_vmscan_direct_reclaim_begin" :
					self.vmscan_direct_reclaim_begin,
				"mm_vmscan_direct_reclaim_end" :
					self.vmscan_direct_reclaim_end}
		self.nr_anon_reclaimed = 0
		self.nr_anon_scanned = 0
		self.nr_file_reclaimed = 0
		self.nr_file_scanned = 0
		self.interval = {}
		self.run_time_direct_reclaim = 0
		self.nr_direct_reclaim = {}

	def vmscan_lru_shrink_inactive(self, task, event_raw, event_arg):
		res = self.re_vmscan_lru_shrink_inactive.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmVmScanEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event,
					int(groups[0]),
					int(groups[1]),
					int(groups[2]),
					int(groups[3]),
					int(groups[4]),
					groups[5])

		task.reclaim += int(groups[3])
		task.done_list[EventType.mm_vmscan].append(event)

	def vmscan_direct_reclaim_begin(self, task, event_raw, event_arg):
		res = self.re_vmscan_direct_reclaim_begin.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmVmScanDirectEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event,
					int(groups[0]),
					int(groups[1]),
					groups[2],
					0)

		task.event_list[EventType.mm_vmscan_direct].append(event)

	def vmscan_direct_reclaim_end(self, task, event_raw, event_arg):
		res = self.re_vmscan_direct_reclaim_end.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmVmScanDirectEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event,
					0,
					0,
					"",
					int(groups[0]))

		if len(task.event_list[EventType.mm_vmscan_direct]) == 0:
			return

		prev_event = task.event_list[EventType.mm_vmscan_direct].pop()
		if not prev_event:
			return

		prev_event.nr_reclaimed = event.nr_reclaimed
		prev_event.run_time = event.timestamp - prev_event.timestamp

		task.done_list[EventType.mm_vmscan_direct].append(prev_event)

	def show_stat(self, task, table):
		nr_anon_reclaimed = 0
		nr_anon_scanned = 0
		nr_file_reclaimed = 0
		nr_file_scanned = 0
		run_time_direct_reclaim = 0

		for event in task.done_list[EventType.mm_vmscan]:
			if event.flags.find("RECLAIM_WB_ANON") >= 0:
				nr_anon_reclaimed += event.nr_reclaimed
				nr_anon_scanned += event.nr_scanned
			else:
				nr_file_reclaimed += event.nr_reclaimed
				nr_file_scanned += event.nr_scanned

		table.add_row(["nr_anon_reclaimed", nr_anon_reclaimed])
		table.add_row(["nr_anon_scanned", nr_anon_scanned])
		table.add_row(["nr_file_reclaimed", nr_file_reclaimed])
		table.add_row(["nr_file_scanned", nr_file_scanned])

		for event in task.done_list[EventType.mm_vmscan_direct]:
			run_time_direct_reclaim += event.run_time

		table.add_row(["reclaim run time", run_time_direct_reclaim])

	def __calc_total_stat(self, tasks, interval = 0):
		for pid in tasks.keys():
			task = tasks[pid]
			for event in task.done_list[EventType.mm_vmscan]:
				if event.flags.find("RECLAIM_WB_ANON") >= 0:
					self.nr_anon_reclaimed += event.nr_reclaimed
					self.nr_anon_scanned += event.nr_scanned
				else:
					self.nr_file_reclaimed += event.nr_reclaimed
					self.nr_file_scanned += event.nr_scanned

				if not interval:
					continue

				idx = event.timestamp / interval
				try:
					self.interval[idx] += event.nr_reclaimed
				except KeyError:
					self.interval[idx] = event.nr_reclaimed

			for event in task.done_list[EventType.mm_vmscan_direct]:
				self.run_time_direct_reclaim += event.run_time
				if not self.nr_direct_reclaim.has_key(event.order):
					self.nr_direct_reclaim[event.order] = 0
				self.nr_direct_reclaim[event.order] += 1

	def show_stat_wide(self, tasks, table):
		self.__calc_total_stat(tasks)
		table.add_row(["total nr_anon_reclaimed", self.nr_anon_reclaimed])
		table.add_row(["total nr_anon_scanned", self.nr_anon_scanned])
		table.add_row(["total nr_file_reclaimed", self.nr_file_reclaimed])
		table.add_row(["total nr_file_scanned", self.nr_file_scanned])
		table.add_row(["total direct reclaim run time",
					self.run_time_direct_reclaim])
		for order in self.nr_direct_reclaim.keys():
			col = "order-"+ str(order) + " direct_reclaim"
			table.add_row([col, self.nr_direct_reclaim[order]])

	def show_period_wide(self, tasks, interval):
		self.__calc_total_stat(tasks, interval)

                table = PrettyTable(["period", "nr_reclaimed"])
                table.align["period"] = "l"
                table.align["nr_reclaimed"] = "r"
                table.padding_width = 1

		for ts in self.interval.keys():
			nr_reclaimed = self.interval[ts]
			start = ts * interval / 1000000.0
			end = (ts * interval + interval) / 1000000.0
			table.add_row([str(start) + "-" + str(end) , nr_reclaimed])
		print table

		"""
		largest = max(self.interval)
		largest = self.interval[largest]

		scale = 20.0 / largest
		for ts in self.interval.keys():
			nr_reclaimed = self.interval[ts]
			bar = "*" * int(nr_reclaimed * scale)
			start = ts * interval / 1000000.0
			end = (ts * interval + interval) / 1000000.0
			print("%s - %s (%10d) %s" %(start, end, nr_reclaimed, bar))
		"""
