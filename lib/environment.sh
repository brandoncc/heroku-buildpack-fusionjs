get_os() {
  uname | tr A-Z a-z
}

get_cpu() {
  if [[ "$(uname -p)" = "i686" ]]; then
    echo "x86"
  else
    echo "x64"
  fi
}

os=$(get_os)
cpu=$(get_cpu)
platform="$os-$cpu"
export JQ="$BP_DIR/vendor/jq-$os"
