measure_size() {
  echo "$((du -s node_modules 2>/dev/null || echo 0) | awk '{print $1}')"
}

list_dependencies() {
  local build_dir="$1"

  cd "$build_dir"
  if $YARN; then
    echo ""
    (yarn list --depth=0 || true) 2>/dev/null
    echo ""
  else
    (npm ls --depth=0 | tail -n +2 || true) 2>/dev/null
  fi
}
