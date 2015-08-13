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
    "instagram.com",

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

    // Tumblr
    "tumblr.com",

    // Dropbox
    "dropbox.com",

    // Journalism
    "nytimes.com",
    "bloomberg.com",
    "wsj.com",

    // Other large sites
    "berkeley.edu",  // w t f :(
    "genius.com",
    "paypal.com",
    "vzw.com",
    "zh.wikipedia.org",

    // Generic CDNs and ad sites
    "adzerk.net",  // reddit
    "akamaihd.net",  // facebook

    // Small sites and their CDNs
    "cdn9.howtogeek.com",  // wordpress
    "paperlesspost.com", "ppassets.com",
    "tecmint.com",
    "dn2.xda-developers.com",

]
HttpsDomainsToProxy = [
    // Generic CDNs and ad sites
    "s3.amazonaws.com",
    "cloudfront.net",

    // Small sites and their CDNs
    "s3-cdn.invisionapp.com",
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
