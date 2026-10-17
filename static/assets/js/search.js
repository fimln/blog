(() => {
  const form = document.querySelector('#search-form');
  const input = document.querySelector('#search-input');
  const status = document.querySelector('#search-status');
  const results = document.querySelector('#search-results');
  const template = document.querySelector('#search-result-template');
  const normalize = value => value.normalize('NFKC').toLowerCase();
  let indexPromise;
  let timer;
  let revision = 0;

  function loadIndex() {
    if (!indexPromise) {
      indexPromise = fetch(results.dataset.index)
        .then(response => {
          if (!response.ok) throw new Error('Could not load search index');
          return response.json();
        })
        .then(posts => posts.map(post => ({
          ...post,
          titleText: normalize(post.title),
          topicText: normalize(`${post.tags} ${post.categories}`),
          allText: normalize(`${post.title} ${post.tags} ${post.categories} ${post.content}`)
        })))
        .catch(error => {
          indexPromise = undefined;
          throw error;
        });
    }
    return indexPromise;
  }

  async function search() {
    const currentRevision = ++revision;
    const query = normalize(input.value.trim());
    results.replaceChildren();
    if (query.length < 2) {
      status.textContent = '';
      return;
    }
    status.textContent = '';
    try {
      const posts = await loadIndex();
      if (currentRevision !== revision) return;
      const words = query.split(/\s+/);
      const matches = posts
        .filter(post => words.every(word => post.allText.includes(word)))
        .map(post => ({
          post,
          score: words.reduce((score, word) => score +
            (post.titleText.includes(word) ? 3 : post.topicText.includes(word) ? 2 : 1), 0)
        }))
        .sort((a, b) => b.score - a.score || b.post.date.localeCompare(a.post.date));
      const visible = matches.slice(0, 10);
      status.textContent = matches.length
        ? ''
        : 'No posts found.';
      for (const { post } of visible) {
        const card = template.content.cloneNode(true);
        const title = card.querySelector('.result-title');
        title.textContent = post.title;
        title.href = post.url;
        const date = card.querySelector('time');
        date.dateTime = post.date;
        date.textContent = post.dateLabel;
        card.querySelector('.post-excerpt').textContent = post.excerpt;
        const link = card.querySelector('.read-more');
        link.href = post.url;
        link.setAttribute('aria-label', `Read ${post.title}`);
        results.append(card);
      }
    } catch {
      if (currentRevision === revision) status.textContent = 'Could not load search. Check your connection and try again.';
    }
  }

  input.addEventListener('input', () => {
    ++revision;
    clearTimeout(timer);
    timer = setTimeout(search, 150);
  });
  form.addEventListener('submit', event => {
    event.preventDefault();
    clearTimeout(timer);
    search();
  });
})();
