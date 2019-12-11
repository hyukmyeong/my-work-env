from timechart.plugin import *
from timechart import colors
from timechart.model import tcProcess

class reclaim(plugin):
	additional_colors = """
	"""
	additional_ftrace_parsers = [
	('mm_vmscan_direct_reclaim_begin','order=%s may_writepage=%s gfp_flags=%s','order','may_writepage','gfp_flags'),
	('mm_vmscan_direct_reclaim_end','nr_reclaimed=%s','nr_reclaimed'),
	]

	additional_process_types = {
		"reclaim":(tcProcess, RECLAIM_CLASS),
	}

	map_pid_to_order = {}

	@staticmethod
	def do_event_mm_vmscan_direct_reclaim_begin(self,event):
		reclaim.map_pid_to_order[event.common_pid] = event.order
		process = self.generic_find_process(event.common_pid, "reclaim-%s:%s" %(event.common_pid, event.order), "reclaim")
		self.generic_process_start(process,event, False)
		print "hey"

	@staticmethod
	def do_event_mm_vmscan_direct_reclaim_end(self,event):
		try:
			order = reclaim.map_pid_to_order[event.common_pid]
		except KeyError:
			return
		process = self.generic_find_process(event.common_pid, "reclaim-%s:%s" %(event.common_pid, order), "reclaim")
		self.generic_process_end(process,event, False)

plugin_register(reclaim)
