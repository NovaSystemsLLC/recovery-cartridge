#!/bin/bash

# Build GWZ
[ -f RecoveryCartridge.gwz ] && rm RecoveryCartridge.gwz
zip RecoveryCartridge.gwz _cartridge.lua LICENSE README.md

echo "RecoveryCartridge.gwz was created. Head to https://www.wherigo.com/cartridge/compile.aspx to build it into a GWC."