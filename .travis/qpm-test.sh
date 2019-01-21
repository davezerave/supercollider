#!/usr/bin/env bash

set -eou pipefail

qpm test.run -l "$TRAVIS_BUILD_DIR/BUILD/travis_test_run.json" --path "$SCLANG" --include "$HOME/Quarks"
