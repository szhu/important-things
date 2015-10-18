function generate-app
  if not test $argv[2]
    echo 'usage: generate-app <app_name> <exe_name>'
    return 1
  end
  set -l APP_NAME $argv[1]
  set -l EXE_NAME $argv[2]

  mkdir $APP_NAME.app
  and cd $APP_NAME.app
  and mkdir Contents
  and cd Contents
  and defaults write (pwd)/Info CFBundleExecutable $EXE_NAME
  and mkdir MacOS
  and touch MacOS/$EXE_NAME
  and chmod +x MacOS/$EXE_NAME
  and touch MacOS/$EXE_NAME
  and eval $EDITOR \"MacOS/$EXE_NAME\"
end
