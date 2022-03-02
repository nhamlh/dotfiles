
# Syntax is as follow:
# curl-tls -H 'Host: foo.com' https://bar.com/api
function curl-tls () {
    local _host_one=""
    local _port_one=""
    local _host_two=""
    local _port_two=""

    # Connect to host_one, under the hood resolve host_one to host_two
    # Same as:
    # curl-tls -H 'Host: host_one' https://host_two/api
    curl \
        --connect-to ${_host_one}:${_port_one}:${_host_two}:${_port_two} \
        https://${host_one}
}
