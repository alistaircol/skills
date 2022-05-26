# Skills

My skill tree.

```text
$ make
Ally's skill tree

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

The `build` uses `envsubst` in `skills.sh` with `skills.tmpl` to make a `skills.dot` that is generated and then various assets are built from the source file.

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

## Example

![skills](https://static.ac93.uk/resume/skills.png)
