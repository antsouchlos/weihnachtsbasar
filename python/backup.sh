name=/root/weihnachtsbasar/python/db_backup
if [[ -e $name.json || -L $name.ext ]] ; then
    i=0
    while [[ -e $name-$i.json || -L $name-$i.json ]] ; do
        let i++
    done
    name=$name-$i
fi

cp /root/weihnachtsbasar/python/db.json "$name".json
