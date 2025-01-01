#!/usr/bin/env bash
set -e

red=$(tput setaf 1)
none=$(tput sgr0)

show_help() {
    printf "usage: $0 [--help] [--report] [--test] [<path to package>]
Script for running all unit and widget tests with code coverage.
(run from root of repo)
where:
    <path to package>
        runs all tests with coverage and reports
    -t, --test
        runs all tests with coverage, but no report
    -r, -c, --report
        generate a coverage report
        (requires lcov, install with Homebrew)
    -h, --help
        print this message
"
}

run_tests() {
    if [[ -f "pubspec.yaml" ]]; then
        rm -f coverage/lcov.info
        rm -f coverage/lcov-final.info
        rm -f coverage/lcov_cleaned.info
        flutter test --no-test-assets --coverage $directory

    else
        printf "\n${red}Error: this is not a Flutter project${none}"
        exit 1
    fi
}

run_report() {
    if [[ -f "coverage/lcov.info" ]]; then
        lcov -r coverage/lcov.info '*/__test*__/*' '**/*.freezed.dart' '**/*.g.dart' '**/*.graphql.dart' '**/*.part.dart' '**/*.config.dart' '**/*_event.dart' '**/*_state.dart' '**/generated/*' '**/.dart_tool/*' '**/l10n/*' '**/config/*' '**/di/*' -o coverage/lcov_cleaned.info --ignore-errors unused
        genhtml coverage/lcov_cleaned.info -o coverage/html
        open coverage/html/index.html # Sort by Directory
        # open coverage/html/index-sort-f.html # Sort by Function Coverage
        # open coverage/html/index-sort-l.html # Sort by Line Coverage
    else
        printf "\n${red}Error: no coverage info was generated${none}"
        exit 1
    fi
}


case $1 in
-h | --help)
    show_help
    ;;
-t | --test)
    printf "Start Test"
    if [ ! -z "$2" ]; then
      directory=$2
    fi
    printf "TEST IN $directory"
    run_tests
    ;;
-r | -c | --report)
    run_report
    ;;
*)
    if [ ! -z "$1" ]; then
      directory=$1
    fi
    run_tests
    run_report
    printf "Running Tests Done !!!"
    ;;
esac
