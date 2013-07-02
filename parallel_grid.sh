rm -rf static/webtest_report/
mkdir -p static/webtest_report/

find . -iname "*test_*.txt" -exec grep -l "  core" {} \; | parallel --tty -j15 pybot -v remote:yes -v SELENIUM_HOST:qa-shire-rc -v SELENIUM_PORT:4444 -v DEFAULT_INIT_TIMEOUT:60 -v AJAX_TIMEOUT:15 -v NOT_INIT:yes -v DEFAULT_TIMEOUT:30  `./shireconfig.py --webtest` -i core --timestampoutputs --outputdir static/webtest_report/{} {} \; {0..255}\>/dev/null

#find webtests/ -iname "*test_*.txt" -exec grep -l "  core" {} \;  | parallel --tty -j15 pybot -v remote:yes -v SELENIUM_HOST:qa-dev -v SELENIUM_PORT:4444 -v DEFAULT_INIT_TIMEOUT:60 -v AJAX_TIMEOUT:15 -v NOT_INIT:yes -v DEFAULT_TIMEOUT:30  -v HOST:http://qa-dev.intra.douban.com:10110 -v CONTROL_HOST:http://qa-dev.intra.douban.com:10111 -v DOUBAN_MOVIE:http://movie.qa-dev.intra.douban.com:10110 -v DOUBAN_TOWN:http://alphatown.qa-dev.intra.douban.com:10110 -v DOUBAN_SITE:http://site.qa-dev.intra.douban.com:10110 -v DOUBAN_BOOK:http://book.qa-dev.intra.douban.com:10110 -v DOUBAN_MUSIC:http://music.qa-dev.intra.douban.com:10110 -v DOUBAN_FM:http://qa-dev.intra.douban.fm:10110 -v DOUBAN_DOU:http://dou.qa-dev.intra.douban.com:10110 -i core --timestampoutputs --outputdir static/webtest_report/regression/{} {}\; {0..255}\>/dev/null
#testcases=`python ./print_parallel_testcase_name.py`
#cat $testcases
#| parallel --tty -j15 pybot -v remote:yes -v SELENIUM_HOST:qa-dev -v SELENIUM_PORT:4444 -v DEFAULT_INIT_TIMEOUT:60 -v AJAX_TIMEOUT:15 -v NOT_INIT:yes -v DEFAULT_TIMEOUT:30 -v HOST:http://qa-dev.intra.douban.com:10190 -v CONTROL_HOST:http://qa-dev.intra.douban.com:10191 -v DOUBAN_MOVIE:http://movie.qa-dev.intra.douban.com:10190 -v DOUBAN_TOWN:http://alphatown.qa-dev.intra.douban.com:10190 -v DOUBAN_SITE:http://site.qa-dev.intra.douban.com:10190 -v DOUBAN_BOOK:http://book.qa-dev.intra.douban.com:10190 -v DOUBAN_MUSIC:http://music.qa-dev.intra.douban.com:10190 -v DOUBAN_FM:http://qa-dev.intra.douban.fm:10190 -v DOUBAN_DOU:http://dou.qa-dev.intra.douban.com:10190 -t {} --timestampoutputs --outputdir static/webtest_report/{} /Users/jollychang/Work/shire \; {0..255}\>/dev/null
cd static/webtest_report
xml_list=`find . -iname '*.xml'`
rebot $xml_list
find . -iname '*.png*' -exec ln -s {} ./ \;