#!/bin/sh

PKG_CONFIG=/etc/sudoers

if grep -q "^%wheel.*ALL.*ALL" $PKG_CONFIG; then
	sed -i 's/%wheel/#%wheel/g' $PKG_CONFIG
fi

if ! grep -q "Cmnd_Alias SHELLS = /bin/sh, /bin/csh, /bin/tcsh, /usr/bin/rsh, /bin/bash" $PKG_CONFIG; then
	echo "Cmnd_Alias SHELLS = /bin/sh, /bin/csh, /bin/tcsh, /usr/bin/rsh, /bin/bash" >> $PKG_CONFIG
fi

if ! grep  -q "Cmnd_Alias SU = /usr/bin/su" $PKG_CONFIG; then
	echo "Cmnd_Alias SU = /usr/bin/su" >> $PKG_CONFIG
fi

if ! grep -q "Cmnd_Alias VI = /usr/bin/vi" $PKG_CONFIG; then
	echo "Cmnd_Alias VI = /usr/bin/vi" >> $PKG_CONFIG
fi


if ! grep  -q "%wheel  ALL=ALL, !SHELLS, !SU, !VI" $PKG_CONFIG; then
	echo "%wheel  ALL=ALL, !SHELLS, !SU, !VI" >> $PKG_CONFIG
fi

