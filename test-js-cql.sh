#!/bin/bash
# test-js-cql.sh - Refresh IG content and run CQL tests
set -e

TOOLING_JAR="input-cache/tooling-cli-3.10.0.jar"

# Check prerequisites
if [ ! -f "$TOOLING_JAR" ]; then
    echo "CQF Tooling not found at $TOOLING_JAR"
    echo "Run ./_updateCQFTooling.sh first"
    exit 1
fi

if ! command -v java &> /dev/null; then
    echo "Java is required but not found."
    exit 1
fi

if ! command -v node &> /dev/null; then
    echo "Node.js is required but not found."
    exit 1
fi

# Step 1: Refresh IG (compiles CQL → ELM, embeds in Library resources)
echo "=== Refreshing IG ==="
java -jar "$TOOLING_JAR" -RefreshIG -ini=ig.ini -t 2>&1 | tail -5
echo ""

# Step 2: Run CQL tests
echo "=== Running CQL tests ==="
cd cql-js-tests
npm test
