document.getElementById('gist-form').addEventListener('submit', (e) => {
  e.preventDefault()

  values = []
  formData = new FormData(e.target)
  for (var key of formData.keys()) {
    values.push([key, formData.get(key)])
  }

  query = values.map(([value, name]) => {
    if (value && name) { return `${value}=${name}` }
  }).filter(i => i).join('&');

  fetch(`${e.target.action}?${query}`)
    .then(response => response.text())
    .then(result => {
      const preview = document.getElementById('gist-preview')
      preview.style.display = 'block'
      preview.innerText = result
    })
})
