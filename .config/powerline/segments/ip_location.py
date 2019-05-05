from __future__ import (unicode_literals, division, absolute_import, print_function)

import urllib
import json


def date(pl, format='%Y-%m-%d', istime=False):
	result = json.load(urllib.request.urlopen('https://freegeoip.app/json/'))
	return [{
		'contents': result['city'],
		'divider_highlight_group': 'time:divider',
	}]





