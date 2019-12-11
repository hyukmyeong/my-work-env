from common_event import *
from operator import itemgetter

class Inode():
	def __init__(self, ino):
		self.ino = ino
		self.offset = {}
		self.io_read = 0
		self.dup_io_read = 0

	def add_to_page_cache(self, ofs):
		if not self.offset.has_key(ofs):
			self.offset[ofs] = 0

		self.io_read += 1
		self.offset[ofs] += 1

		if self.offset[ofs] >= 2:
			self.dup_io_read += 1

class MmFilemapEvent(CommonEvent):
	def __init__(self, comm, pid, cpu, ts, event,
		dev, ino, page, pfn, ofs):
		CommonEvent.__init__(self, comm, pid, cpu, ts, event)
		self.dev = dev
		self.ino = ino
		self.page = page
		self.pfn = pfn
		self.ofs = ofs

class MmFilemapHandler(CommonHandler):
	def __init__(self):
		self.re_filemap_add_to_page_cache = re.compile(r'dev (.+) ino (.+) page=(.+) pfn=(.+) ofs=(.+)')
		self.functions = {"mm_filemap_add_to_page_cache" : self.filemap_add_to_page_cache}
		self.inodes = {}
		self.total_io_read = 0
		self.total_dup_io_read = 0

	def filemap_add_to_page_cache(self, task, event_raw, event_arg):
		res = self.re_filemap_add_to_page_cache.match(event_arg)
		if res == None:
			sys.exit()

		groups = res.groups()
		event = MmFilemapEvent(event_raw.common_comm,
					event_raw.common_pid,
					event_raw.common_cpu,
					event_raw.timestamp,
					event_raw.event,
					groups[0],
					int(groups[1], 16),
					int(groups[2], 16),
					int(groups[3]),
					int(groups[4]))

		if not self.inodes.has_key(event.ino):
			self.inodes[event.ino] = Inode(event.ino)
		inode = self.inodes[event.ino]
		inode.add_to_page_cache(event.ofs)

	def __calc_total_stat(self, tasks, interval = 0):
		for ino in self.inodes.keys():
			inode = self.inodes[ino]
			self.total_io_read += inode.io_read
			self.total_dup_io_read += inode.dup_io_read

	def show_stat_wide(self, tasks, table):
		self.__calc_total_stat(tasks)
		table.add_row(["total io_read(PageUnit)", self.total_io_read])
		table.add_row(["total dup io_read(PageUnit)", self.total_dup_io_read])

	def show_inode_wide(self, table):

		# x = {1: 2, 3: 4, 4: 3, 2: 1, 0: 0}
		# sorted_x = sorted(x.items(), key=operator.itemgetter(1))
		# for ino in self.inodes.keys():

	#sorted = dict.items()
	#sorted.sort(key = lambda item: item[1].total, reverse=True)
		sorted_inodes = self.inodes.items()
		sorted_inodes.sort(key = lambda item: item[1].io_read, reverse=True)
		# sorted_inodes = sorted(self.inodes.items(), key=itemgetter(1))
		# sorted_inodes.sort(key = lambda c: c.io_read, reverse=True)

		# for ino in self.inodes.keys():
		for ino in sorted_inodes:
			inode = ino[1]
			# print inode
			table.add_row([inode.ino, inode.io_read, inode.dup_io_read])
