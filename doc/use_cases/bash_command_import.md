```shell
. ./sandboxing.sh
```

Some times, you want to share some pieces of code in several bash commands.

You can put that code in another directory called lib sibling to the commands.

Say you want to provide a function called shout that capitalize the input.

```shell
shout () {
   tr '[:lower:]' '[:upper:]'
}
```

Let's put this code in a file called mylib.

```shell
  mkdir -p "${CLKCONFIGDIR}/bin/lib"
  cat<<EOF > "${CLKCONFIGDIR}/bin/lib/mylib"
shout () {
   tr '[:lower:]' '[:upper:]'
}
EOF
```

Then you can simply import this code in your code, using clk\_import.

```shell
clk command create bash somecommand --no-open
cat <<"EOH" > "$(clk command which somecommand)"
#!/bin/bash -eu

source "_clk.sh"

clk_import mylib

clk_usage () {
    cat<<EOF
$0

This command does something
--

EOF
}

clk_help_handler "$@"

echo something | shout

EOH
```

```shell
test "$(clk somecommand)" = "SOMETHING"
```