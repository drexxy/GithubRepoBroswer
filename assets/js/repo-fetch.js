
document.querySelector('#org-name').addEventListener('keypress', function (e) {
  if (e.key === 'Enter') {
    let orgName = this.value
    let url = `https://api.github.com/orgs/${orgName}/repos`
    let csrf = document.querySelector('meta[name="csrf-token"]')
    fetch(url, {
      headers: csrf
    })
      .then((response) => {
        return response.json();
      })
      .then((data) => {
        if(data.message) {
          document.getElementById('error-text').innerHTML = data.message;
          document.getElementById('organization-name').innerHTML = '';
          document.getElementById('repo-list').innerHTML = '';
        } else {
          document.getElementById('error-text').innerHTML = '';
          document.getElementById('organization-name').innerHTML = orgName;
          const repos = data.map(repo => {
            return createRepoList(repo)
          });
          document.getElementById('repo-list').innerHTML = repos.join('');
        }
      });
  }
});

function createRepoList(repo) {
  return `<li>
    <a href=${repo.html_url} target="_blank">
      ${repo.name}
    </a>
  </li>`;
}
