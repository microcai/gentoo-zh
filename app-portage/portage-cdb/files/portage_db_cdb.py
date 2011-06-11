# Copyright 2004, 2005 Tobias Bell <tobias.bell@web.de>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA

import portage_db_template
import os
import os.path
import cPickle
import cdb


class _data(object):

    def __init__(self, path, category, uid, gid):
        self.path = path
        self.category = category
        self.uid = uid
        self.gid = gid
        self.addList = {}
        self.delList = []
        self.modified = False
        self.cdbName = os.path.normpath(os.path.join(
            self.path, self.category) + ".cdb")
        self.cdbObject = None

    def __del__(self):
        if self.modified:
            self.realSync()

        self.closeCDB()

    def realSync(self):
        if self.modified:
            self.modified = False
            newDB = cdb.cdbmake(self.cdbName, self.cdbName + ".tmp")
           
            for key, value in iter(self.cdbObject.each, None):
                if key in self.delList:
                    if key in self.addList:
                        newDB.add(key, cPickle.dumps(self.addList[key], cPickle.HIGHEST_PROTOCOL))
                        del self.addList[key]
                elif key in self.addList:                   
                    newDB.add(key, cPickle.dumps(self.addList[key], cPickle.HIGHEST_PROTOCOL))
                    del self.addList[key]
                else:
                    newDB.add(key, value)
               

            self.closeCDB()

            for key, value in self.addList.iteritems():
                newDB.add(key, cPickle.dumps(value, cPickle.HIGHEST_PROTOCOL))
           
            newDB.finish()
            del newDB
           
            self.addList = {}
            self.delList = []

            self.openCDB()

    def openCDB(self):
        prevmask = os.umask(0)
       
        if not os.path.exists(self.path):
            os.makedirs(self.path, 02775)
            os.chown(self.path, self.uid, self.gid)
           
        if not os.path.isfile(self.cdbName):
            maker = cdb.cdbmake(self.cdbName, self.cdbName + ".tmp")
            maker.finish()
            del maker
            os.chown(self.cdbName, self.uid, self.gid)
            os.chmod(self.cdbName, 0664)

        os.umask(prevmask)
           
        self.cdbObject = cdb.init(self.cdbName)

    def closeCDB(self):
        if self.cdbObject:
            self.cdbObject = None


class _dummyData:
    cdbName = ""

    def realSync():
        pass
    realSync = staticmethod(realSync)


_cacheSize = 4
_cache = [_dummyData()] * _cacheSize


class database(portage_db_template.database):   

    def module_init(self):
        self.data = _data(self.path, self.category, self.uid, self.gid)

        for other in _cache:
            if other.cdbName == self.data.cdbName:
                self.data = other
                break
        else:
            self.data.openCDB()
            _cache.insert(0, self.data)           
            _cache.pop().realSync()
           
    def has_key(self, key):
        self.check_key(key)
        retVal = 0

        if self.data.cdbObject.get(key) is not None:
            retVal = 1

        if self.data.modified:
            if key in self.data.delList:
                retVal = 0
            if key in self.data.addList:
                retVal = 1
           
        return retVal

    def keys(self):
        myKeys = self.data.cdbObject.keys()

        if self.data.modified:
            for k in self.data.delList:
                myKeys.remove(k)
            for k in self.data.addList.iterkeys():
                if k not in myKeys:
                    myKeys.append(k)
                   
        return myKeys

    def get_values(self, key):
        values = None
       
        if self.has_key(key):
            if key in self.data.addList:
                values = self.data.addList[key]
            else:
                values = cPickle.loads(self.data.cdbObject.get(key))

        return values
   
    def set_values(self, key, val):
        self.check_key(key)
        self.data.modified = True
        self.data.addList[key] = val

    def del_key(self, key):
        retVal = 0
       
        if self.has_key(key):
            self.data.modified = True
            retVal = 1
            if key in self.data.addList:
                del self.data.addList[key]
            else:
                self.data.delList.append(key)

        return retVal
                   
    def sync(self):
        pass
   
    def close(self):
        pass


if __name__ == "__main__":
    import portage
    uid = os.getuid()
    gid = os.getgid()
    portage_db_template.test_database(database,"/tmp", "sys-apps", portage.auxdbkeys, uid, gid)
