git config --global user.email "sachinuppar129@gmail.com"
git config --global user.name "Sidd"
export latest_tag="1.0.1"
sudo yq -i ".landscapes[0].grafana.targetRevision=env(latest_tag)" ./argocd/values.yml
if git diff --quiet; then
  echo "targetRevision was not changed"
else
  echo "targetRevision was changed"
  git checkout -b updated_targetrevision
  git commit -m "Update targetRevision in values.yml"
  git push origin updated_targetrevision_values_file
  curl -H "Authorization: token $GITHUB_TOKEN" -X POST -d '{"title":"Updated targetRevision in values.yml","head":"updated_targetrevision","base":"main"}' https://api.github.com/repos/$GITHUB_USER/$GITHUB_REPO/pulls
fi
