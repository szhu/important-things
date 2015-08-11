DomainsToProxy = [
    // Google
    "1e100.net",
    "abc.xyz",
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
    "googlevideo.com",
    "gstatic.com",
    "youtube.com",
    "ytimg.com",

    // Facebook
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

    // Reddit
    "reddit.com",
    "redditstatic.com",

    // Dropbox
    "dropbox.com",

    // Third-party
    "adzerk.net",  // reddit
    "akamaihd.net",  // facebook

    // Journalism
    "nytimes.com",

    // Others
    "genius.com",
    "tecmint.com",
    "cdn9.howtogeek.com", // wordpress
    "zh.wikipedia.org",
]
HttpsDomainsToProxy = [
    // Third-party
    "s3.amazonaws.com",
]

var DIRECT = "DIRECT";
var SOCKS = "SOCKS5 localhost:31280; SOCKS5 localhost:31281; DIRECT";

function FindProxyForURL(url, host) {
    if (isPlainHostName(host)) return DIRECT;

    for (var i = DomainsToProxy.length - 1; i >= 0; --i) {
        var domainToProxy = DomainsToProxy[i];
        if (dnsDomainIs(host, domainToProxy)) return SOCKS;
        if (dnsDomainIs(host, '.' + domainToProxy)) return SOCKS;
    }

    for (var i = HttpsDomainsToProxy.length - 1; i >= 0; --i) {
        var domainToProxy = HttpsDomainsToProxy[i];
        if (url.substring(0, 6) !== 'https:') continue;
        if (dnsDomainIs(host, domainToProxy)) return SOCKS;
        if (dnsDomainIs(host, '.' + domainToProxy)) return SOCKS;
    }

    return DIRECT;
}
