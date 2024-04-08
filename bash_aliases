#user defined 
#grep 
alias gp='egrep -nr --exclude={tags,*.out} --exclude-dir={\.git,obj}' 
#dirs operation command 
alias ..='cd ..' 
alias ...='cd ../..' 
alias ....='cd ../../..' 
alias .....='cd ../../../..' 
# git relevent 
alias gts='git status .' 
# change directory to the git root directory 
alias gtr='cd "$(git rev-parse --show-toplevel)"'
# open (in vim) all modified files in a git rep
alias diffvim='vim `git diff --name-only` -p'

#logcf
#alias logcf='LL="$(date +%F.%T).logcat"; touch /tmp/"$LL"; ln -s /tmp/"$LL" "$LL"; adb wait-for-device; adb logcat -c | grep permitted && (adb root; adb wait-for-device; adb logcat -c); adb logcat -v time *:v | tee /tmp/"$LL"'
alias logcf='bash ~/Templates/bash/logcf.sh'

#kimedia
alias kimedia='adb root; adb wait-for-device; adb shell pkill -l KILL cameraserver; (adb shell pkill -l KILL gallery; adb shell pkill -l KILL camera; adb shell pkill -l KILL GoogleCamera) &>/dev/null'

#mminit
function mminit() {
pushd . &>/dev/null
selected_product=
while [ ! -f "./build/envsetup.sh" ]; do
    if [ "$PWD" = "/" ]; then
        echo envsetup.sh not found!
        popd &>/dev/null
        return 2
    fi
    cd ..
done
 
pushd ./device/ &>/dev/null
products="$(for i in marvell/* asr/*; do grep $i -rle 'PRODUCT_NAME\s*:=' 2>/dev/null | sort -r; done)"
#echo "$products"
 
if [ -n "$1" ]; then
    for arg in $products; do
        if echo "$arg" | grep "$1" &>/dev/null; then
            selected_product=$arg
            #echo arg=$arg
            break
        fi
    done
fi
 
if [ -n "$selected_product" ]; then
    echo "Selected product:"
    echo "$products" | grep -ne '.' | grep "^\|^.*$selected_product.*"
else
    echo "Auto selecting the first product: (use \"mminit pattern\" to override)"
    selected_product=$( echo "$products" | head -1 )
    echo "$products" | grep -ne '.' | grep "^\|^.*$selected_product"
fi
 
pn=$(grep $selected_product -e "PRODUCT_NAME.*=" | head -1 | sed -e"s/^.*:= *\(\w*\)/\1/g")
echo " "$'\n'"PRODUCT_NAME=$pn" | grep -e '.'
popd &>/dev/null
 
source "./build/envsetup.sh" &>/dev/null
echo "LUNCH=$pn-userdebug" | grep -e '.'
lunch "$pn-userdebug"
 
popd &>/dev/null
}
 
#mmr
function mmr() {
    if [ -z "$ANDROID_PRODUCT_OUT" ]; then
        echo Run mminit first! | grep .
        mminit
    fi
    trap "popd; trap - SIGINT" SIGINT
    pushd . &>/dev/null
    dst=~/.mmreplace
    if [ ! -d "$dst" ]; then
        mkdir "$dst"
    fi
    rm -f "$dst/push"
    while [ ! -f "Android.mk" ]; do
        if [ "$PWD" = "/" ]; then
            echo Project not found!
            popd &>/dev/null
            return
        fi
        cd ..
    done
    echo Current project is $(pwd) | grep '/.*'
    pwdsum=$(echo $TARGET_PRODUCT.$(pwd) | md5sum | sed -e's/ .*//')
    if [[ "$1" =~ [Bb] ]]; then
        echo Delete record: "$dst/$pwdsum" | grep '/.*'
        rm "$dst/$pwdsum"
    fi
    if [ -e "$dst/$pwdsum" ] && grep "$dst/$pwdsum" -e '.' &>/dev/null; then
        echo Found record: "$dst/$pwdsum" | grep '/.*'
        ( mm -j8 && touch "$dst/push" ) | grep "Install:" | sed -e"s/^.*Install: //" | while read so; do
            if ! grep "$dst/$pwdsum" -Fe "$so" &>/dev/null; then
                echo Append to record: "$so" | grep -e 'out.*'
                echo "$so" >> "$dst/$pwdsum"
            fi
        done
    else
        echo Record not found: "$dst/$pwdsum" | grep '/.*'
        find . -iname "*.c" -o -iname "*.cpp" | while read line; do echo "workaround: touching $line"; touch $line; done
        ( mm -B -j8 && touch "$dst/push" ) | grep "Install:" | sed -e"s/^.*Install: //" > "$dst/$pwdsum"
        echo New record:
        cat "$dst/$pwdsum" | grep -e '.'
    fi
 
    if [ -f "$dst/push" ]; then
        if [[ "$1" =~ [Ll] ]]; then
            if [[ "$1" =~ [Kk] ]]; then
                echo Keep /system !
            else
                echo Clean /system !
                find /system/ -type f | xargs rm
            fi
        else
            echo Trying to remount /system !
            if [[ "$1" =~ [Ss] ]]; then
                adb -s "$2" wait-for-device
                (adb -s "$2" remount | grep succeeded || (adb -s "$2" root; adb -s "$2" wait-for-device; adb -s "$2" remount)) | cat
            else
                adb wait-for-device
                (adb remount | grep succeeded || (adb root; adb wait-for-device; adb remount)) | cat
            fi
        fi
 
        cat "$dst/$pwdsum" | while read so; do
            if [[ "$1" =~ [Aa] ]]; then
                if [[ "$so" == *.yuv ]]; then
                    continue
                fi
            else
                if [[ "$so" == *.xml || "$so" == *.yuv || "$so" == *.data || "$so" == *.txt ]]; then
                    continue
                fi
            fi
            pushd . &>/dev/null
            while [ ! -e "./build/envsetup.sh" ]; do
                if [ "$PWD" = "/" ]; then
                    echo Code Base not found!
                    popd &>/dev/null
                    break
                fi
                cd ..
            done
 
            if [[ "$1" =~ [Ll] ]]; then
                echo "$PWD/$so -> /system/${so#*/system/}" | grep " /system/.*"
                cp "./$so" "/system/${so#*/system/}"
            else
                if [[ "$1" =~ [Ss] ]]; then
                    echo "$PWD/$so -> /system/${so#*/system/} [$2] " | grep " /system/.*"
                    adb -s "$2" push "./$so" "/system/${so#*/system/}"
                else
                    echo "$PWD/$so -> /system/${so#*/system/}" | grep " /system/.*"
                    adb push "./$so" "/system/${so#*/system/}"
                fi
            fi
            popd &>/dev/null
        done
        if [[ "$1" =~ [Ll] ]]; then
            rm /smb/system.tgz
            tar -cvzf /smb/system.tgz /system
        fi
    fi
    popd &>/dev/null
    trap - SIGINT
}

function docrash()
{
    export DOVECRASHROOT=/home/zongmincui/workspace/devtools/crash_analysis_suite/dove_bin/
    export PATH=$DOVECRASHROOT:$PATH
	# CRASH_EXTENSIONS=~/workspace/devtools/crash_analysis_suite/dove_bin/extensions/ ~/workspace/devtools/crash_analysis_suite/dove_bin/crash -x "$1" "$2"
}

function zmMount()
{
    sudo mount -t cifs //10.1.24.167/isp /mnt/fileserver/isp -o user=zongmincui,password=AAbbcc123,domain=asrmicro,rw,uid=1000
    sudo mount -t cifs //10.1.24.167/fpga /mnt/fileserver/FPGA -o user=zongmincui,password=AAbbcc123,domain=asrmicro,rw,uid=1000
}

function dwtCalc()
{
    local ImgW=$1
    local ImgH=$2
    local ExtW=$(((($ImgW + 63) >> 6) << 6))
    local ExtH=$(((($ImgH + 31) >> 5) << 5))
    local LL1W=$((ExtW >> 1))
    local LL1H=$((ExtH >> 1))
    local LL2W=$((ExtW >> 2))
    local LL2H=$((ExtH >> 2))
    local LL3W=$((ExtW >> 3))
    local LL3H=$((ExtH >> 3))
    local LL4W=$((ExtW >> 4))
    local LL4H=$((ExtH >> 4))

    echo "dwtLL1 = $LL1W * $LL1H"
    echo "dwtLL2 = $LL2W * $LL2H"
    echo "dwtLL3 = $LL3W * $LL3H"
    echo "dwtLL4 = $LL4W * $LL4H"
}

# Go language environment variables GOROOT , GOPATH and PATH
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
export GOPROXY=https://goproxy.io

# autojump
source /usr/share/autojump/autojump.bash
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ;} history -a"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'

# enable case insensitive completion
bind 'set completion-ignore-case on'

# git completion
source /usr/share/bash-completion/completions/git

# catapult environment variables CATAPULTROOT , TRACINGPATH and PATH
export CATAPULTROOT=/home/zongmincui/workspace/github/catapult/
export TRACINGPATH=$CATAPULTROOT/tracing/bin/
export PATH=$TRACINGPATH:$PATH

# ctrl-] then will copy whatever is on the current bash prompt to the clipboard.
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
bind '"\C-]":"\C-e\C-u pbcopy <<"EOF"\n\C-y\nEOF\n"'
