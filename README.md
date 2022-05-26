# Skills

My skills tree.

```text
$ make
Ally's skills tree

subcommands:
  lint   runs yamllint for workflow files local only
  image  builds a docker image (basically dot with custom font)
  build  builds skills tree assets
```

## Local

```bash
make image
make build
```

---

The `make image` creates an image which is basically has `graphviz` but with a custom font installed.

The `make build` uses the above image and:

* uses `envsubst`
* from `skills.sh`
* to interpolate variables in `skills.tmpl.dot`
* to make a `skills.dot` source file
  
the source file is then used to build various assets files in `build/`.

## Release

There is a GitHub action that runs on `tag` that generates a release and uploads build assets to an S3 bucket.

```bash
# changes
git add ..
git commit -m '...'
git push

# bump next release when ready
make version # git --no-pager tag | grep -v "^v" | sort -V
git tag 1.0.0 -m 'skills tree released'
git push origin 1.0.0
```

The following variables should be added to the repository's actions secrets:

* `AWS_ACCESS_KEY_ID` - self-explanatory
* `AWS_SECRET_ACCESS_KEY` - self-explanatory
* `AWS_S3_BUCKET` - i.e. part before region.aws

## Example

![skills](https://static.ac93.uk/resume/skills.png)
