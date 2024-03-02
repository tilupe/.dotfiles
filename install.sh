#!/bin/bash

if command -v apt &> /dev/null; then
    echo "apt package manager is available on this system."
else
    echo "apt package manager is not available on this system."
fi

