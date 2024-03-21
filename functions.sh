# # # Functions # # #

function merge_request
{
  echo "https://gitlab.db-gla.net/Core/Core/-/merge_requests/new?merge_request%5Bsource_project_id%5D=13&merge_request%5Bsource_branch%5D=$(git symbolic-ref --short HEAD)&merge_request%5Btarget_project_id%5D=13&merge_request%5Btarget_branch%5D=$1"
}

function transfer_bin
{
  ldd $1 | awk '{ print $3 }' | grep Core | xargs -r -n1 -I'{}' rsync -avzLKP $1 '{}' $2
}

function ssh_on
{
  curl 'http://192.168.20.1/config/ssh_on' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H "Cookie: $1" \
  --data-raw '{}' 
}

function ssh_off
{
  curl 'http://192.168.20.1/config/ssh_off' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -H "Cookie: $1" 
}

function wget_play {
  echo Playing $1
  wget -qO- $1 | ffplay -
}

function cpu_usage() {
  top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}'
}

function mem_usage() {
   top -bn1 | grep "MiB Mem" | sed 's/ used,//g' | awk '{print $8}'
}

function download_ca_cert() {
  true | openssl s_client -connect $1:443 2>/dev/null | openssl x509 > $1.crt
}

function get_benchmark_log()
{
    vms_log $1 $2 | zlib-flate -uncompress
}

crypt() {
  bash -c 'read -p "Enter Password: " -s PASS && echo -n $PASS | sha256sum | cut -c 1-64 | xclip && echo "" && echo "Copied to clipboard!" '
}

vms_login() {
  curl -s --location --request POST "$1:$2/login" --header 'Content-Type: application/json' --data-raw '{ "password": "root" }'  | jq '.authorization' | sed -e 's/^"//' -e 's/"$//'
}

vms_perf() {
  curl -s --location --request GET "$1:$2/performance" --header "Authorization: Bearer $(vms_login $1 $2)"
}

vms_perf_csv() {
  echo "$(date +%s),$(vms_perf | jq --raw-output '.mem_percentage, .mem_used, .mem_total, .cpu_percentage' | paste -sd, -)"
}

vms_log() {
  curl --location --request GET "$1:$2/log" --header "Authorization: Bearer $(vms_login $1 $2)"  | zlib-flate -uncompress
}

