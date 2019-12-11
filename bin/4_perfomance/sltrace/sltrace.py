#!/usr/bin/python
import argparse
from event_parser import *

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='Profiler for start-up latency.')
	parser.add_argument("-f", "--file", required=True, help="trace file")
	parser.add_argument("-s", "--sort", default="pid", help="sort option",
				choices=["pid", "reclaim", "fault"])
	parser.add_argument("-F", "--filter", help="task filter")
	parser.add_argument("-i", "--interval", type=int, help="interval msec")
	parser.add_argument("-ino", action='store_true', help="inode info")

	args = parser.parse_args()
	sort = args.sort
	filter = args.filter
	option_inode = args.ino
	trace_file = args.file

	try:
		fd = open(trace_file, 'r')
	except:
		print("Not) found %s" % trace_file)
		sys.exit(1)
	
	parser = EventParser()
	while 1:
		line = fd.readline()
		if not line:
			break
		parser.process(line)

	fd.close()

	parser.show_stat(sort, filter)
	parser.show_stat_wide()
	if option_inode:
		parser.show_inode_wide()

	# print system-wide information by period
	if args.interval:
		# change usec from msec
		parser.show_period_wide(args.interval * 1000)
