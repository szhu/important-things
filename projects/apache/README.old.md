**Command:**

	/usr/sbin/httpd -f ~/Library/usr/etc/apache2/httpd.conf

I made this into a LaunchAgent.

**`~/Library/usr/etc/apache2/httpd.conf`:**

Don't run as a different user:

	# User _www
	# Group _www

Write logs to user-owned locations:

	ErrorLog "/Users/Me/Library/Logs/apache2/apache2.log"

Same with `PidFile` and `LockFile`, although these need to go at the end to prevent being overridden by `Include /private/etc/apache2/other/*.conf`:

	PidFile "/Users/Me/Library/Logs/apache2/apache2.pid"
	LockFile "/Users/Me/Library/Logs/apache2/apache2.lock"

Add CGI and .htaccess support:

	<Directory "/Users/Me/Library/WebServer">
	    AddHandler cgi-script .cgi .pl
	    Options Indexes FollowSymLinks MultiViews +ExecCGI
	    AllowOverride All
	    Order allow,deny
	    Allow from all
	</Directory>

Put virtual host information in a separate file:

	Include /Users/Me/Library/usr/etc/apache2/hosts.conf

Not sure if this is good, but I didn't like the idea of keeping many `httpd` processes around.

	MaxClients 5

**`~/Library/usr/etc/apache2/hosts.conf`:**

	Listen 1234
	<VirtualHost *:1234>
	    DocumentRoot "/Users/Me/Library/WebServer/1234"
	</VirtualHost>

Not sure if `~`-relative paths were allowed, so I kept it absolute.