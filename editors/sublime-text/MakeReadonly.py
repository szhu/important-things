#!/usr/bin/env python
# https://forum.sublimetext.com/t/read-only-files/5102

import os
import sublime
import sublime_plugin

class MakeReadOnly(sublime_plugin.EventListener):
    def on_load(self, view):
        file_name = view.file_name()
        if not file_name:
            return
        exists = os.path.exists(file_name)
        can_write = os.access(file_name, os.W_OK)
        if exists and not can_write:
            view.set_read_only(True)
            sublime.status_message("Readonly")
