#!/bin/bash
set -euo pipefail

wget -O ~/$1 "https://github.com/SpaceManiac/SpacemanDMM/releases/download/suite-1.2/$1"
chmod +x ~/$1
~/$1 --version