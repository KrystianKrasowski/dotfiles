if [[ $- != *i* ]] ; then
	return
fi

if [ -d "${HOME}/.bashrc.d/" ]; then
    for i in "${HOME}/.bashrc.d/"*; do
        [ -r "$i" ] && . "$i"
    done
fi
