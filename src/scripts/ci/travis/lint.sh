#!/bin/bash
set -ev
which shellcheck > /dev/null && shellcheck "$0" # Run shellcheck on this if available

# Disabled rules in Python 2 only
# superfluous-parens: needed for print statements
# too-many-locals: variable counting differs from pylint3

echo "travis_fold:start:pylint_configure"
python3 -m pylint configure.py
python2 -m pylint --disable=superfluous-parens,too-many-locals configure.py
echo "travis_fold:end:pylint_configure"

echo "travis_fold:start:pylint_botanpy"
python3 -m pylint src/python/botan2.py || true
python2 -m pylint --disable=superfluous-parens,too-many-locals src/python/botan2.py || true
echo "travis_fold:end:pylint_botanpy"
