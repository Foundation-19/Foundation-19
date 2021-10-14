#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
python3 ss13_genchangelog.py ../../html/changelog.html ../../html/changelogs