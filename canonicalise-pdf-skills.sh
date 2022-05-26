#!/usr/bin/env bash
original_file=build/skills.pdf
temporary_file=build/skills-temp.pdf
meta_file=build/skills-meta.txt

cat <(docker run \
  --rm \
  --user="$(id -u):$(id -g)" \
  --volume="$(pwd):/app" \
  --workdir="/app" \
  mnuessler/pdftk $original_file dump_data_utf8 \
  | sed '/^Info/d'
) - <<EOF > $meta_file
InfoBegin
InfoKey: Creator
InfoValue: https://ac93.uk/cv
InfoBegin
InfoKey: Producer
InfoValue: Alistair Collins - with Graphviz
InfoBegin
InfoKey: Title
InfoValue: Alistair Collins - Skills
InfoBegin
InfoKey: Subject
InfoValue: Skills
InfoBegin
InfoKey: Author
InfoValue: Alistair Collins
InfoBegin
InfoKey: Keywords
InfoValue: PHP, Laravel, MySQL, Linux, Docker, AWS
EOF

cp $original_file $temporary_file
rm $original_file

docker run \
  --rm \
  --interactive \
  --user="$(id -u):$(id -g)" \
  --volume="$(pwd):/app" \
  --workdir="/app" \
  mnuessler/pdftk \
  $temporary_file \
  update_info_utf8 - \
  output $original_file < $meta_file

rm $meta_file $temporary_file
