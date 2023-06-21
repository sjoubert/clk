# [[file:sandboxing.org::tmpdir][tmpdir]]
SRCDIR="$(pwd)"
CLK_COV="$(readlink -f "$(dirname "$BASH_SOURCE")/../clk_coverage.sh")"
clk ( ) {
    "${CLK_COV}" "$@"
}
if test -n "${CLK_TEST_ROOT-}"
then
    TMP="${CLK_TEST_ROOT}"
else
    TMP="$(mktemp -d)"
fi
mkdir -p "${TMP}/clk-root"
cat <<EOF > "${TMP}/clk-root/clk.json"
  {
      "parameters": {
          "clk": [
              "--keyring", "clk.keyrings.DummyFileKeyring"
          ],
          "command.create.python": [
              "--no-open"
          ],
          "command.create.bash": [
              "--no-open"
          ]
      }
  }
EOF
cd "${TMP}"
eval "$(direnv hook bash)"
cat<<EOF > "${TMP}/.envrc" && direnv allow
export CLKCONFIGDIR="${TMP}/clk-root"
export DUMMYFILEKEYRINGPATH="${TMP}/keyring.json"
export CLK_NETRC_LOCATION="${TMP}/netrc"
EOF
# source the env file to use it in automatic test
source "${TMP}/.envrc"
export TERM=dumb # to avoid possible issues with colors
echo "${TMP}"
# tmpdir ends here
