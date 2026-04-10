#!/bin/bash
# test-cql.sh - Automated CQL Test Execution
# Runs CQL tests using CQF Tooling without deploying to a FHIR server

set -e

echo "======================================"
echo "CQL Automated Test Suite"
echo "======================================"
echo ""

# Configuration
TOOLING_JAR="input-cache/tooling-cli-3.10.0.jar"
IG_INI="$PWD/ig.ini"
TEST_OUTPUT="output/test-results"

# Check prerequisites
if [ ! -f "$TOOLING_JAR" ]; then
    echo "CQF Tooling not found at $TOOLING_JAR"
    echo "Run ./_updateCQFTooling.sh first"
    exit 1
fi

if ! command -v java &> /dev/null; then
    echo "Java is required but not found. Please install JDK 11+."
    exit 1
fi

# Clean previous test results
rm -rf "$TEST_OUTPUT"
mkdir -p "$TEST_OUTPUT"

# Run tests
# Note: -RefreshIG is the only way to run CQL tests locally with CQF Tooling.
# It always refreshes Library/PlanDefinition resources as a side effect (including
# stamping the current date), so we revert those changes after the run.
echo "Running CQL tests..."
echo "Command: java -jar $TOOLING_JAR -RefreshIG -ini=$IG_INI -t -d"
echo ""

java -jar "$TOOLING_JAR" \
    -RefreshIG \
    -ini="$IG_INI" \
    -t \
    -d \
    2>&1 | tee "$TEST_OUTPUT/test-run.log"

EXIT_CODE=${PIPESTATUS[0]}

# Revert resource files modified by -RefreshIG (date stamps, re-encoded ELM, etc.)
echo ""
echo "Reverting resource side effects from RefreshIG..."
git checkout -- input/resources/ 2>/dev/null || true

if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "All CQL tests passed"
    exit 0
else
    echo ""
    echo "CQL tests failed (exit code: $EXIT_CODE). Check $TEST_OUTPUT/test-run.log"
    exit $EXIT_CODE
fi
