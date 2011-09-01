#!/bin/bash
#
# Copyright (C) 2011 - David Goulet <david.goulet@polymtl.ca>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; only version 2
# of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#

SESSIOND_BIN="ltt-sessiond"
RESULTS_PATH="/tmp/lttng-bench-results.txt"
BASEDIR=`dirname $0`

echo "Session daemon boot"

`BENCH_UST_NOTIFY=1 $BASEDIR/../ltt-sessiond/$SESSIOND_BIN --daemonize --quiet`
if [ $? -ne 0 ]; then
	echo -e '\e[1;31mFAILED\e[0m'
	exit 1
else
	echo -e "\e[1;32mOK\e[0m"
fi

PID_SESSIOND=`pidof lt-$SESSIOND_BIN`

echo -e "\nResults will be available shortly in $RESULTS_PATH"
echo ""

kill $PID_SESSIOND
tail -F $RESULTS_PATH --pid $PID_SESSIOND 2>/dev/null

exit 0
