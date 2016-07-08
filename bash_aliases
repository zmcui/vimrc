#user defined 
#grep 
alias gp='grep -nr --exclude={tags,cscope.out}' 
#dirs operation command 
alias ..='cd ..' 
alias ...='cd ../..' 
alias ....='cd ../../..' 
alias .....='cd ../../../..' 
# git relevent 
alias gts='git status .' 
# change directory to the git root directory 
alias gtr='cd "$(git rev-parse --show-toplevel)"'
# rm -rf
alias rm='rm -rf'

# mm replace libraries 
alias mmreplace='(mm | grep "^Install:" || mm -B | grep "^Install:") | sed -e"s/^Install: //" | grep -ve "\(\.txt\|\.data\|\.bin\|\.yuv\)$" |
while read so; do
    pushd . &>/dev/null
    while [ ! -e "./build/envsetup.sh" ]; do
        if [ "$PWD" = "/" ]; then
            echo envsetup.sh not found!
            popd &>/dev/null
            break
        fi
        cd ..
    done
    (adb remount | grep succeeded || (adb root; sleep 5; adb remount)) | cat
    if [ -z "$MMREPLACETO" ]; then
        echo "$PWD/$so -> /system/${so#*/system/}" | grep " /system/.*"
        adb push "./$so" "/system/${so#*/system/}"
    else
        echo "$PWD/$so -> $MMREPLACETO" | grep " $MMREPLACETO"
        adb push "./$so" "$MMREPLACETO"
    fi
    popd &>/dev/null
done'

# cd path/to/code
alias tocs='cd ~/work/asrc/frameworks/av/services/camera/libcameraservice/'
alias toce='cd ~/work/asrc/vendor/marvell/generic/cameraengine'
alias tohal='cd ~/work/asrc/vendor/marvell/generic/camera-hal-32'
