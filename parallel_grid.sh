rm -rf static/webtest_report/
mkdir -p static/webtest_report/

find . -iname "*test_*.txt" -exec grep -l "  core" {} \; | parallel --tty -j15 pybot -v GRAB_SERVER_ERROR:NO -v remote:yes -v SELENIUM_HOST:qa-shire-rc -v SELENIUM_PORT:4444 -v DEFAULT_INIT_TIMEOUT:60 -v AJAX_TIMEOUT:15 -v NOT_INIT:yes -v DEFAULT_TIMEOUT:30  `./shireconfig.py --webtest` -i core --timestampoutputs --outputdir static/webtest_report/{} {} \; {0..255}\>/dev/null
cd static/webtest_report
xml_list=`find . -iname '*.xml'`
rebot $xml_list
find . -iname '*.png*' -exec ln -s {} ./ \;