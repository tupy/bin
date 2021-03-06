#!/usr/bin/env bats

load bootstrap

PATH="$PATH:$BATS_TEST_DIRNAME/../bin"

export GITHUB_EVENT_PATH="$BATS_TEST_DIRNAME/fixtures/event.json"

@test "action: matches" {
  run action created
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "action: does not match" {
  run action edited
  [ "$status" -eq 78 ]
  [ "$output" = "action is \"created\", not \"edited\"" ]
}

@test "action: matches a or b" {
  run action "deleted|created"
  [ "$status" -eq 0 ]
  [ "$output" = "" ]
}

@test "action: does not match a or b" {
  run action "edited|deleted"
  [ "$status" -eq 78 ]
  [ "$output" = "action is \"created\", not \"edited|deleted\"" ]
}
