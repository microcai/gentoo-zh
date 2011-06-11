# Copyright: 2005 Gentoo Foundation
# Author(s): Brian Harring (ferringb@gentoo.org)
# License: GPL2
# $Id: cdb.py,v 1.1 2006/06/14 11:35:04 scsi Exp $


cdb_module = __import__("cdb")
try:
	import cPickle as pickle
except ImportError:
	import pickle
import copy
import os
import fs_template
from template import reconstruct_eclasses
import cache_errors


class database(fs_template.FsBased):

	autocommits = True
	cleanse_keys = True
	serialize_eclasses = False

	def __init__(self, *args, **config):
		super(database,self).__init__(*args, **config)

		self._db_path = os.path.join(self.location, fs_template.gen_label(self.location, self.label)+".cdb")
		self.__db = None
		try:
			self.__db = cdb_module.init(self._db_path)

		except cdb_module.error:
			try:
				self._ensure_dirs()
				self._ensure_dirs(self._db_path)
				self._ensure_access(self._db_path)
			except (OSError, IOError), e:
				raise cache_errors.InitializationError(self.__class__, e)

			try:
				cm = cdb_module.cdbmake(self._db_path, self._db_path+".tmp")
				cm.finish()
				self._ensure_access(self._db_path)
				self.__db = cdb_module.init(self._db_path)
			except cdb_module.error, e:
				raise cache_errors.InitializationError(self.__class__, e)
		self._adds = {}
		self._dels = {}


	def iteritems(self):
		self.commit()
		return iter(self.__db.each, None)


	def _getitem(self, cpv):
		if cpv in self._adds:
			d = copy.deepcopy(self._adds[cpv])
		else:
			d = pickle.loads(self.__db[cpv])
		return d


	def _setitem(self, cpv, values):
		if cpv in self._dels:
			del self._dels[cpv]
		self._adds[cpv] = values


	def _delitem(self, cpv):
		if cpv in self._adds:
			del self._adds[cpv]
		self._dels[cpv] = True


	def commit(self):
		if not self._adds and not self._dels:
			return
		cm = cdb_module.cdbmake(self._db_path, self._db_path+str(os.getpid()))
		for (key, value) in iter(self.__db.each, None):
			if key in self._dels:
				del self._dels[key]
				continue
			if key in self._adds:
				cm.add(key, pickle.dumps(self._adds.pop(key), pickle.HIGHEST_PROTOCOL))
			else:
				cm.add(key, value)
		for (key, value) in self._adds.iteritems():
			cm.add(key, pickle.dumps(value, pickle.HIGHEST_PROTOCOL))
		cm.finish()
		self._ensure_access(self._db_path)
		self.__db = cdb_module.init(self._db_path)
		self._adds = {}
		self._dels = {}


	def iterkeys(self):
		self.commit()
		return iter(self.__db.keys())


	def has_key(self, cpv):
		return cpv not in self._dels and (cpv in self._adds or cpv in self.__db)


	def __del__(self):
		if getattr(self, "__db", None):
			self.commit()
			self.__db.finish()
