from common_event import *

class Task:
	def __init__(self, pid, comm):
		self.pid = pid
		self.comm = comm
		self.s_time = sys.maxint
		self.e_time = 0
		self.reclaim = 0
		self.fault_run_time = 0

		# mm_fault, mm_vmscan
		self.event_list = {EventType.mm_fault:[], EventType.mm_vmscan_direct:[]}
		self.done_list = {EventType.mm_fault:[],
					EventType.mm_vmscan:[],
					EventType.mm_vmscan_direct:[]}
