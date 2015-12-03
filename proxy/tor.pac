function FindProxyForURL(url, host) {
    if (host.match(/\.onion$/)) {
        return "SOCKS4a 127.0.0.1:9050";
    }
    else {
        return "DIRECT";
    }
}
