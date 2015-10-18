'''
A text command which takes multiple views and enables an event listener to
monitor them. If the visible region of the active view changes, the other views
get moved by the same amount either up or down.

Example use cases:
- Opening two or more files side by side in order to diff them.
- Opening a file and it's clone side by side to diff it.

Known limitations:
- Scrolling of slaves is row-wise. I don't get pixel-wise values.
- Hiding a view which is glued drops it from the list. This is due to Sublime
  returning None on view.window() if it's not visible anymore.

For use add something like this to your user definable key bindings file:
{ "keys": ["alt+plus"], "command": "glue_views_add"},
{ "keys": ["alt+minus"], "command": "glue_views_remove"},
{ "keys": ["alt+#"], "command": "glue_views_clear"}

@author: Oktay Acikalin <ok@ryotic.de>

@license: MIT (http://www.opensource.org/licenses/mit-license.php)

@since: 2011-04-08
'''

import sublime
import sublime_plugin


if 'views' not in globals():
    views = []
if 'active_syncer' not in globals():
    active_syncer = 0


class GlueViewsAddCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        for view in views:
            if view.id() == self.view.id():
                sublime.status_message('View already in glued group.')
                return
        views.append(self.view)
        sublime.status_message('Added view to glued group.')
        syncer.timeout = syncer.timeout_min


class GlueViewsRemoveCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        id = self.view.id()
        for view in views:
            if view.id() == id:
                views.remove(view)
                sublime.status_message('Removed view from glued group.')
                return
        sublime.status_message('View not in glued group.')


class GlueViewsClearCommand(sublime_plugin.TextCommand):

    def run(self, edit):
        global views
        views = []
        sublime.status_message('Removed all views from glued group.')


class ViewSynchronizer(object):

    def __init__(self, id):
        self.id = id
        self.timeout_min = 10
        self.timeout_max = 1000
        self.timeout = self.timeout_max
        self.timeout_inc_step = 10

    def prune_views(self):
        for view in views[:]:
            if not view.window():
                print('remove view', view.id())
                views.remove(view)
        if len(views) == 0:
            self.timeout = self.timeout_max

    def get_active_view(self):
        for view in views:
            window = view.window()
            if window:
                if window.active_view().id() == view.id():
                    return view
        return None

    def get_other_views(self):
        active_view = self.get_active_view()
        other_views = []
        for view in views:
            if view.id() == active_view.id():
                continue
            other_views.append(view)
        return other_views

    def run(self):
        global active_syncer
        if active_syncer != self.id:
            return
        # print '---', self.id, len(views), self.timeout
        self.prune_views()
        active_view = self.get_active_view()
        if active_view:
            settings = active_view.settings()
            last_row = settings.get('glue_views_last_row', None)
            cur_row, _ = active_view.rowcol(active_view.visible_region().begin())
            if last_row is not None:
                if last_row != cur_row:
                    self.timeout = self.timeout_min
                    diff = cur_row - last_row
                    # print 'active view', active_view.id(), 'diff', diff
                    for view in self.get_other_views():
                        row, _ = view.rowcol(view.visible_region().begin())
                        # print 'view', view.id(), 'currently at row', row
                        view.run_command('scroll_lines', dict(amount=-diff))
                        sels = view.sel()
                        if sels:
                            row, col = view.rowcol(sels[0].end())
                            sels.clear()
                            row += diff
                            sels.add(sublime.Region(view.text_point(int(row), col)))
                        view.settings().set('glue_views_last_row', None)
            settings.set('glue_views_last_row', cur_row)
        sublime.set_timeout(self.run, self.timeout)
        self.timeout += self.timeout_inc_step
        self.timeout = min(self.timeout, self.timeout_max)


active_syncer += 1
syncer = ViewSynchronizer(active_syncer)
syncer.run()


class GlueViewsListener(sublime_plugin.EventListener):

    def on_activated(self, view):
        view.settings().set('glue_views_last_row', None)
