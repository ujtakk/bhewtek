#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import argparse

class VerilogFile:
    #TODO
    @staticmethod
    def read_ignore_list(self, fname):
        VerilogFile.ignore_file = []
        VerilogFile.ignore_com = []
        data_dict = {}
        data = open(fname, 'r').read()
        data = re.sub(r'#.*$', '', data)
        data = re.sub(r'\s+', ' ', data, re.I | re.S)
        for i in re.findall(r'(\S+)\s*\{(.*?)\}'):
            typ, d = i
            d = d.strip().split()
            if typ == 'ignore_file':
                VerilogFile.ignore_file = d
            elif typ == 'ignore_com':
                VerilogFile.ignore_com = [ i+'.com' for i in d ]
            else:
                raise

    def __init__(self, module_name):
        self._module_name = module_name
        self.filename = module_name + '.v'
        #self.filename_body = self.filename.split('.')[0]
        #self.filename_ext = '.'.join(self.filename.split('.')[1:])
        self.filename_body, self.filename_ext = re.findall(r'^([^.]*)\.(.*)$')[0]
        self.dep = None

    def have_v_in(self):
        if self.have_v_erb():
            return True
        else:
            return os.path.exists(self.v_in())

    def have_v_erb(self):
        return os.path.exists(self.v_erb())

    def v_in(self):
        return self.filename_body + '.v.in'
    def v_erb(self):
        return self.filename_body + '.v.erb'
    def com(self):
        return self.filename_body + '.com'

    def walk(self, files):
        text = ''
        if self.have_v_in():
            if not len(self.dep) != 0:
                text += '{}: {}\n'.format(self.filename, ' '.join(self.dep))
        files.append(self.filename)
        if self.have_v_erb():
            text += '{}: {}\n'.format(self.v_in(), self.v_erb())
            files.append(self.v_in())
        if not any([
            self.com() in self.ignore_com,
            len(self.com_dep()) != 0,
            '<' in self.com()
        ]):
            text += '{}: {}\n'.format(self.com(), ' '.join(self.com_dep()))
            files.append(self.com())
            files += [h for h in self.com_dep() if h.endswith('.vh')]
            for i in self.submodules():
                if not i+'.v' in files:
                    if i in self.ignore_file or '<' in i:
                        continue
                    else:
                    files.append(i+'.v')
                    text += VerilogFile(i).walk(files)

        return text

    def com_dep(self):
        text = self.includes() + [ VerilogFile(i).com() for i in submodules]
        text = [ i for i in text if not i in self.ignore_com and not '<' in i ]
        return text

    def dep(self):
        if self.dep != None:
            return self.dep
        self.dep = []
        self.dep += [ i+'v' for i in self.submodules() if not '<' in i ]
        return self.dep

    def data(self):
        if self.data != None:
            return self.data
        if self.have_v_erb():
            self.data = open(self.v_erb, 'r').read()
        elif self.have_v_in():
            self.data = open(self.v_in, 'r').read()
        else:
            if os.path.exists(self.filename()):
                self.data = open(self.filename(), 'r').read()
            else:
                self.data = ''
        return self.data

    def _submodules(self, string):
    v_files = []
    data0 = [ i[0] for i in re.findall(r'([a-zA-Z_0-9]+)\s+\S+\s*\((?:\s*\.\S+\s*\([^\)]*\)\s*,{0,1}){0,}(?:\s*\/\*AUTOINST\*\/\s*){1}\);', string) ]
    v_files += data0
    data1 = [ i[0] for i in re.findall(r'([a-zA-Z_0-9]+)\s+\S+\s*\((?:\s*\.\S+\s*\([^\)]*\)\s*,{0,1}){1,}\);', string) ]
    v_files += data1
    return list(set(v_files))

    #TODO
    def submodules(self):
        v_files = self._submodules(data)
        sdata = #TODO
        v_files += self._submodules(sdata)
        text_list = v_files

        return  sorted(text_list, key=str.lower)

    #TODO
    def includes(self):
    v_files = [ [i[0]] + VHeaderFile(i[0]).includes()
                    for i in re.findall(r'^\s*`include\s+"([^"]*)"\s*$') ]

    return 

    #TODO
    def to_dot_sub(self):
        text = []
        text.append('node_{} [label=\"{}\"];'.format(self.filename_body, filename_body))
        text += [ 

    def to_dot(self):
        return 'digraph sample {{\n' \
               '{}\n'.format(self.to_dot_sub()) \
               '}}\n' \

class VHeaderFile(VerilogFile):
    def __init__(self, filename):
        self.filename = filename
        self.filename_body = self.filename.split('.')[0]
        self.filename_ext = '.'.join(self.filename.split('.')[1:])
        self.dep = []

class VFiles(list):
    def to_str(self):
        f = list(set(self))
        f = self.purge(f)
        f = r' \\\n'.join(sorted(f, key=str.lower)) + '\n'
        return r'{}= \\\n{}\n'.format(self.name(), f)
    def name(self):
        return 'VFILES'
    def purge(self, f):
        f = [ i for i in f if i.endswith('.v') ]
        f = [ i for i in f if not i.startswith('alt') ]
        return

class VHFiles(VFiles):
    def name(self):
        return 'VHFILES'
    def purge(self, f):
        f = [ i for i in f if i.endswith('.vh') ]
        f = [ i for i in f if not i.startswith('alt') ]

parser = argparse.ArgumentParser(
    description='Verilog-mode Source Parser')
parser.add_argument('--dc', help='design compiler readfile script')
parser.add_argument('--dot', help='generate dot file')
parser.add_argument('--make', help='generate Makefile (default)')
parser.add_argument('files', help='verilog source files')
args = parser.parse_args()

VerilogFile.read_ignore_list('dep.in')

top_v_files = [ VFile(top) for top in args.files ]

#TODO
top_vfiles_str =

files = files_all

if args.make:
    print('## This Makefile is generated by dep.py\n')
    print(VFiles(files).to_str())
    print(VHFiles(files).to_str())
    print('\n'.join(top_vfiles_str))
elif args.dc:
    files = [ i for i in files if i.endswith('.v') ]
    for i in list(set(files)):
        print('read_file -format verilog {}\n'.format(i))
elif args.dot:
    for t in top_vfiles:
        print t.to_dot()
