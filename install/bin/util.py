from sys import stdout, stderr
from subprocess import Popen, PIPE

STDOUT = 1
STDERR = 2

def _do_command(cmd, process_lines, process, popen_kwargs):
    p = Popen(cmd, **popen_kwargs)
    if process in (STDOUT, STDERR):
        dev = p.stderr if process == STDERR else p.stdout
        if dev is None:
            p.kill()
            raise RuntimeError("only piped output can be filtered")
        for line in process_lines(dev):
            stdout.write(line)
            stdout.flush()
    p.wait()
    exit(p.returncode)

def do_command(*cmd, **popen_kwargs):
    def do_command_wrapper(process_lines):
        if 'process' in popen_kwargs:
            process = popen_kwargs['process']
            del popen_kwargs['process']
        else:
            process = None
        _do_command(cmd, process_lines, process, popen_kwargs)
    return do_command_wrapper

def rstrip(s, suffix):
    return s[:-len(suffix)] if s.endswith(suffix) else s

def lstrip(s, prefix):
    return s[len(prefix):] if s.startswith(prefix) else s

def sort_lines(func):
    def sort_lines_wrapper(lines):
        lines_as_list = [line for line in func(lines)]
        sort_key = lambda line: line.decode('utf8').lower()
        return sorted(lines_as_list, key=sort_key).__iter__()
    return sort_lines_wrapper

__all__ = ['do_command', 'stdout', 'stderr', 'PIPE', 'STDOUT', 'STDERR', 'sort_lines']
