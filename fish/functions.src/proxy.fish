function proxy
    for var in ALL_PROXY http_proxy https_proxy
        set -gx $var socks5://localhost:31280
    end
    true
end

function unproxy
    for var in ALL_PROXY http_proxy https_proxy
        set -gxe $var
    end
    true
end
