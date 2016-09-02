if test -e ~/Library/Android/sdk
	set -x ANDROID_HOME ~/Library/Android/sdk
	set -x PATH $PATH ~/Library/Android/sdk/tools
	set -x PATH $PATH ~/Library/Android/sdk/platform-tools
end
