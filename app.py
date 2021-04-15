# -*- mode: python -*- -*- coding: utf-8 -*-
import os

import contentful
import html2markdown
from rich_text_renderer import RichTextRenderer


PUB_DIR = './public'


def main():
    os.makedirs(PUB_DIR, exist_ok=True)
    contentful.__version__
    html2markdown.__dict__
    RichTextRenderer.__dict__

    with open(os.path.join(PUB_DIR, 'index.html'), mode='w') as f:
        f.write('<h1>hello</h1><p>Welcome Github Actions</p>')


if __name__ == "__main__":
    main()
