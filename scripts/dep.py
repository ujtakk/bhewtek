#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import argparse

class VerilogFile:

    def __init__(self, filename, module_name):
        self._module_name = module_name
        self.filename = module_name + '.v'
        self.filename_body = self.filename.split('.')[0]
        self.filename_ext = '.'.join(self.filename.split('.')[1:])
        dep = None

    def read_ignore_list(self, fname):
        self.ignore_file = []
        self.ignore_com = []

        data_dict = {}
        with open(fname, 'r') as f:
            for line in f:

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
            self.com() # TODO
        ]):
            text += '{}: ()\n'.format(self.com(), ' '.join(self.com_dep()))
            files.append(self.com())
            files += [h for h in self.com_dep() if h.endswith('.vh')]
            for i in self.submodules():
                if not i+'.v' in files:

        return text

    def com_dep(self):

    def dep(self):

    def data(self):

    def _submodules(self, string):

    def submodules(self):

    def includes(self):

    def to_dot_sub(self):

    def to_dot(self):

class VHeaderFile(VerilogFile):
    def __init__(self, filename):


parser = argparse.ArgumentParser(
    description='Verilog-ERB Source Parser')
parser.add_argument('train', help='Path to training image-label list file')
parser.add_argument('val', help='Path to validation image-label list file')
parser.add_argument('--mean', '-m', default='mean.npy',
                    help='Path to the mean file (computed by compute_mean.py)')
args = parser.parse_args()
