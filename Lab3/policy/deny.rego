package main

deny[msg] {
  count(input.declaration.label) > 64
  msg := "declaration.label must not exceed 64 charachters"
}
deny[msg] {
  count(input.declaration.remark) > 64
  msg := "declaration.remark must not exceed 64 charachters"
}

deny[msg] {
  port := input.apps[_].port
  not is_number(port)
  msg = sprintf("port is not a number: %v", [port])
}
deny[msg] {
  port := input.apps[_].port
  port > 65535
  msg = sprintf("port out of range: %v", [port])
}
deny[msg] {
  port := input.apps[_].port
  port < 0
  msg = sprintf("port out of range: %v", [port])
}
