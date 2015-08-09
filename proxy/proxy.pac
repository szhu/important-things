DomainsToProxy = [
    // Google
    "1e100.net",
    "appspot.com",
    "blogger.com",
    "blogspot.com",
    "doubleclick.net",
    "ggpht.com",
    "gmail.com",
    "goo.gl",
    "google.com",
    "googleapis.com",
    "googleusercontent.com",
    "gstatic.com",
    "youtube.com",
    "ytimg.com",

    // Facebook
    "akamaihd.net",
    "facebook.com",
    "facebook.net",
    "fbcdn.net",
    "messenger.com",
    "xx.fbcdn.net",

    // Automattic
    "gravatar.com",
    "w.org",
    "wordpress.com",
    "wp.com",

    // Twitter
    "twitter.com",
    "twimg.com",

    // Others
    "tecmint.com",
    "zh.wikipedia.org",
]

function ShouldProxy(url, host) {
    for (var i = DomainsToProxy.length - 1; i >= 0; --i) {
        if (dnsDomainIs(host, DomainsToProxy[i])) return true;
        if (dnsDomainIs(host, '.' + DomainsToProxy[i])) return true;
    }
    return false;
}

function FindProxyForURL(url, host) {
    if (ShouldProxy(url, host))
        return "SOCKS5 localhost:31280; SOCKS5 localhost:31281; DIRECT";
    else
        return "DIRECT";
}
