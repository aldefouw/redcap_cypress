const rctf_versions = ['v1.0.18.html','v1.0.19.html']
  window.versions = ''
rctf_versions.forEach(function(v) {
  window.versions += `<li><a href="${v}">${v.split(".html")[0]}</a></li>`
})
