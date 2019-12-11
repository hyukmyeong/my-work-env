import os
from timechart.model import tcProject
class Event():
    def __init__(self,name,kw):
        self.__dict__=kw
        self.event = name
        self.timestamp = self.common_s*1000000+self.common_ns/1000
        self.linenumber = 0
class Sample():
    def __init__(self,name,kw):
        kw.update(kw['sample'])
        self.__dict__=kw
        self.event = name
        self.common_comm = self.comm
        self.common_pid = self.tid
        self.common_cpu = self.cpu
        self.timestamp = self.time/1000
        self.linenumber = 0

def get_partial_text(fn,start,end):
    return "text trace unsupported with perf backend"
def trace_begin():
    global proj
    proj = tcProject()
    proj.start_parsing(get_partial_text)
def trace_end():
    from timechart.window import tcWindow
    proj.finish_parsing()
    # Create and open the main window.
    window = tcWindow(project = proj)
    window.configure_traits()


def process_event(param_dict):
    event_name = param_dict["ev_name"]
    proj.handle_sample_event(Sample(event_name,param_dict))

def trace_unhandled(event_name, context, field_dict):
    event_name = event_name[event_name.find("__")+2:]
    proj.handle_trace_event(Event(event_name,field_dict))

def load_perf(filename):
    dotpy = __file__
    # perf python wants a .py file and not .pyc...
    if dotpy.endswith("pyc"):
        dotpy = dotpy[:-1]
    perf = "perf"
    if "PERF" in os.environ:
        perf = os.environ["PERF"]
    os.execlp(perf, perf, "script", "-i", filename, "-s", dotpy)
    # this will be executed only if perf script doesn't exist
    os.execlp(perf, perf, "trace", "-i", filename, "-s", dotpy)
    return None
def detect_perf(filename):
    name, ext = os.path.splitext(os.path.basename(filename))
    if ext == ".data":
        return load_perf
    return None
