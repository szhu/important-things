#!/bin/bash
find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print | sed 's#.app/Contents/_MASReceipt/receipt$##g; s#^/Applications/##'
