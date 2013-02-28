#!/bin/bash
# Makes sure the sub modules are all updated and correct
git submodule sync
git submodule update --init
