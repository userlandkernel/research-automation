from idautils import *
from idc import *
from idaapi import *
import re

def decompile_func(ea):

	if not init_hexrays_plugin():
		return False

	f = get_func(ea)
	if f is None:
		return False

	cfunc = decompile(f)
	if cfunc is None:
		return False

	lines = []
	sv = cfunc.get_pseudocode()
	for sline in sv:
		line = tag_remove(sline.line)
		lines.append(line)

	return lines


def find_function(which = ""):
	for ea in Segments():
		for funcAddr in Functions(SegStart(ea), SegEnd(ea)):
			funcName = GetFunctionName(funcAddr)
			if which in funcName:
				return funcAddr

def find_callers(whichFn = ""):
	sub_funcs = []
	iosvm = find_function(whichFn)
	if iosvm is None:
		return sub_funcs
	for xref in idautils.XrefsTo(iosvm):
		subf = idc.get_func_name(xref.frm)
		if not subf or subf in sub_funcs:
			continue
		sub_funcs.append([subf, xref])
	return sub_funcs

def find_callers_args(whichFn):
	callers = find_callers(whichFn)
	for caller in callers:
		name = caller[0]
		addr = caller[1].frm
		to = caller[1].to
		func = idaapi.get_func(addr)
		if func:
			func = func.startEA
			decompiled = decompile_func(func)
			for line in decompiled:
				if whichFn in line:
					service = line.split(whichFn+'("')[-1][:-3]
					print("Found: " + service)
					print("Location: " + name + " " + hex(addr))
find_callers_args("IOServiceMatching")
find_callers_args("IOServiceNameMatching")
find_callers_args("IOConnectCall")
