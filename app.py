# -*- mode: python -*- -*- coding: utf-8 -*-
import os

import contentful
import html2markdown
from rich_text_renderer import RichTextRenderer


PUB_DIR = './public'


def main():
    os.makedirs(PUB_DIR, exist_ok=True)
    print(contentful.__version__)
    print(html2markdown.__dict__)
    print(RichTextRenderer.__dict__)


if __name__ == "__main__":
    main()
