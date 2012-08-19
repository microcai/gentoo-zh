#!/bin/bash

cd /opt/wink

export LD_LIBRARY_PATH=/opt/wink

./wink ${*}

