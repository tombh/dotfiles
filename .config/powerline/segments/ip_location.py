from __future__ import (unicode_literals, division, absolute_import, print_function)

from powerline.segments import Segment, with_docstring
from powerline.theme import requires_segment_info, requires_filesystem_watcher

@requires_filesystem_watcher
@requires_segment_info
class CustomSegment(Segment):
    divider_highlight_group = None

def __call__(self, pl, segment_info, create_watcher):
    return [{
        'contents': 'hello',
        'highlight_groups': ['information:regular'],
    }]

hello = with_docstring(CustomSegment(), '''Return a custom segment.''')

