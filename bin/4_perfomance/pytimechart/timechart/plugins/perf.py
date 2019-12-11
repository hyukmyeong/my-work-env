from timechart.plugin import *
from timechart import colors
from timechart.model import tcProcess, _pretty_time
from enthought.traits.api import Bool

#by default it is hidden...
class tcPerfEvent(tcProcess):
    show = Bool(False)
    def _get_name(self):
        return "%s (%s)"%(self.comm, _pretty_time(self.total_time))

class perf(plugin):
    additional_colors = """
sample			#ee8888
sample_bg		#eeeeaa
"""
    additional_process_types = {
        "sample":(tcPerfEvent,PERF_CLASS),
        }

plugin_register(perf)
