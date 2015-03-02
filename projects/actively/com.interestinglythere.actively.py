#!/usr/bin/env python


def init():
	idletime = getidletime()
	#print idletime
	if idletime == None or idletime < 70:
		result = osascript( 'com.interestinglythere.Actively.scpt' )
		response = result[0].splitlines()
		print '\t'.join([gettime()] + response)

def gettime():
	import time
	return time.strftime('%Y-%m-%d %H:%M:%S %Z:')

def getidletime():
	'''Return idle time in seconds'''

	# Get the output from 
	# ioreg -c IOHIDSystem
	s = readscript(["ioreg", "-c", "IOHIDSystem"], 0.1)[0]
	lines = s.splitlines()

	raw_line = ''
	for line in lines:
		if line.find('HIDIdleTime') > 0:
			raw_line = line
			break

	try:
		nano_seconds = long(raw_line.split('=')[-1])
		seconds = nano_seconds/1e9
		return seconds
	except ValueError:
		return None

def osascript(script, args=[]):
	if type(args) == str: args = [args,]
	return readscript( ['/usr/bin/osascript', script] + args )
def osascript_interpreter(code, args=[]):
	if type(args) == str: args = [args,]
	return readscript( ['/usr/bin/osascript', '-e', code] + args )

def readscript(script, delay=True):
	import subprocess
	shellout = subprocess.Popen(script, stdout=subprocess.PIPE)
	if delay==True: shellout.wait()
	else: import time; time.sleep(delay)
	return shellout.stdout.read(), None

if __name__ == '__main__': init()