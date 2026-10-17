"""Check a production build: python tests/site_test.py dist/site."""
from html.parser import HTMLParser
from pathlib import Path
import json
import sys
import xml.etree.ElementTree as ET
from urllib.parse import unquote, urlsplit


class Page(HTMLParser):
    def __init__(self, text):
        super().__init__()
        self.elements = []
        self.feed(text)

    def handle_starttag(self, tag, attrs):
        self.elements.append((tag, dict(attrs)))


root = Path(sys.argv[1] if len(sys.argv) > 1 else 'dist/site').resolve()
origin = 'https://blog.alfi.ai.id'
posts = json.loads((root / 'search.json').read_text(encoding='utf-8'))
assert posts, 'Search index is empty'
assert len({post['url'] for post in posts}) == len(posts), 'Duplicate post URLs'
for post in posts:
    assert set(post) == {'title', 'url', 'date', 'dateLabel', 'tags', 'categories', 'excerpt', 'content'}
    assert all(isinstance(value, str) for value in post.values())
    assert post['title'] and post['content'] and post['excerpt']
    assert post['date'].endswith('+07:00'), post['date']
    assert '{{' not in post['content'] and '{%' not in post['content']
    assert (root / post['url'].lstrip('/') / 'index.html').is_file(), post['url']

for path in root.rglob('*.html'):
    text = path.read_text(encoding='utf-8')
    assert '{{' not in text and '{%' not in text and 'raw HTML omitted' not in text, path
    page = Page(text)
    canonical = [a['href'] for t, a in page.elements if t == 'link' and a.get('rel') == 'canonical']
    assert len(canonical) == 1 and canonical[0].startswith(origin + '/'), path
    assert any(t == 'main' and a.get('id') == 'content' for t, a in page.elements), path
    assert 'application/ld+json' in text, path
    for tag, attrs in page.elements:
        for key in ('href', 'src'):
            url = urlsplit(attrs.get(key, ''))
            if url.scheme or url.netloc or not url.path:
                continue
            target = (root / unquote(url.path).lstrip('/')).resolve()
            assert target.is_relative_to(root), attrs
            assert target.is_file() or (target / 'index.html').is_file(), (path, attrs)
    post = next((p for p in posts if canonical[0] == origin + p['url']), None)
    if post:
        assert any(t == 'meta' and a.get('property') == 'og:type' and a.get('content') == 'article' for t, a in page.elements)

locations = {node.text for node in ET.parse(root / 'sitemap.xml').iter() if node.tag.endswith('}loc')}
assert {origin + p['url'] for p in posts}.issubset(locations)
assert origin + '/search.json' not in locations
assert origin + '/404.html' not in locations
assert (root / 'CNAME').read_text().strip() == 'blog.alfi.ai.id'
assert (root / 'robots.txt').read_text().strip() == f'Sitemap: {origin}/sitemap.xml'
assert not any(root.rglob('*.ps1')), 'Build scripts must not be published'
assert not (root / 'assets/fonts/README.md').exists()
assert not (root / 'assets/fonts/SOURCE.txt').exists()
print(f'PASS: {len(posts)} indexed posts, HTML links/assets, canonical/SEO, sitemap, robots, domain, source exclusions.')
