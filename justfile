sync-pcad:
    rsync --verbose --progress --recursive --links --times \
    --exclude='.git/' \
    --exclude='data/' \
    --exclude='paper/' \
    --exclude='final/' \
    --exclude='plots/' \
    --exclude='slides/' \
    --exclude='*.out' \
    --exclude='sbc/' \
    --exclude='pcad/' \
    ./ "pcad:~/intro_hpc/"

get-pcad:
    rsync --verbose --progress --recursive --links --times "pcad:~/intro_hpc/" ./

slides name="sscad":
    marp --pdf --allow-local-files slides/{{name}}/{{name}}.md -o slides/{{name}}/{{name}}.pdf
