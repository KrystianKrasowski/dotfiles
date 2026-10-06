#!/usr/bin/env bash

if [ x"$@" = x"Foo" ]; then
    exit 0
fi

echo -ne "Foo\n"
echo -ne "Bar\n"

exit 0
