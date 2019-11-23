#!/usr/bin/env bats

function wait_for () {
  let retries=5
  while ! nc -z -w 5 $1 $2; do
    if [ $retries -le 0 ]; then
      return 1
    fi

    retries=$(( $retries - 1 ))
    sleep 1
  done
}

@test "test tl_2009_us_uac00_url.shp.xml" {
  wait_for app 8080
  curl -v --fail http://app:8080/fgdc2iso -d @$BATS_TEST_DIRNAME/fixtures/tl_2009_us_uac00_url.shp.xml
}
