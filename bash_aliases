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
# to see if patch would apply cleanly in the first place
alias p1='patch -p1 -g1 --dry-run'

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

# cp arg1 to public-share
share()
{
    sudo cp "$1" /mnt/lava_share/USER/zongmincui/
}

# command hint
alias ch='echo "tar -czf xx.tar.gz xx" | echo "tar -xzvf xx.tar.gz" | echo "tar -cf xx.tar xx" | echo "tar -xf xx.tar" | echo "vimdiff do dp [c ]c [[ ]]" | echo "cscope -Rbq" | echo "git push ssh://zongmincui@source.asrmicro.com:29418/kernel/common HEAD:refs/for/fvp_ve_aemv8a_dev_4.4" | echo "git push ssh://zongmincui@source.asrmicro.com:29418/baremetal-test HEAD:refs/for/master:" | echo "git rebase -i HEAD~2"| echo "smbclient //fileserver/public-share -U asrmicro/zongmincui"'

# mv to trash
# alias rm=trash
# alias rl='ls ~/.trash'
# alias ur=undelfile

undelfile()
{
    mv -i ~/.trash/$@ ./
}

trash()
{
    mv $@ ~/.trash/
}

cleartrash()
{
    /bin/rm -rf ~/.trash/*
    # read -p "clear sure?[n]" confrim
    # case "$confirm" in
    #     Y)
    #            /bin/rm -rf ~/.trash/*
    #     ;;
    #     y)
    #            /bin/rm -rf ~/.trash/*
    #     ;;
    # esac;
    #["$confirm" == "y"] || ["$confirm" == "Y"] && [/usr/bin/rm -rf ~/.trash/*]
}

#tombstone2line is a function
tombstone2line () 
{ 
    OPTIND=1;
    while getopts "l:s:" opt; do
        case "$opt" in 
            l)
                log="$OPTARG";
                echo "log=$log" 1>&2
            ;;
            s)
                symbols="$OPTARG";
                echo "symbols=$symbols" 1>&2
            ;;
            ?)
                echo "Invalid Arguments, please use:" 1>&2;
                echo "./dump_data_process.sh -l adb_logcat [ -s symbols_folder ]" 1>&2;
                return 2
            ;;
        esac;
    done;
    if [ -n "$ANDROID_PRODUCT_OUT" ] && [ -z "$symbols" ]; then
        echo "Use current android product out folder $ANDROID_PRODUCT_OUT/symbols as symbols folder" 1>&2;
        symbols="$ANDROID_PRODUCT_OUT/symbols";
    fi;
    if [ "$symbols" == "" ]; then
        echo "Absent Arguments, please use:" 1>&2;
        echo "./dump_data_process.sh -l adb_logcat [ -s symbols_folder ]" 1>&2;
        return 2;
    fi;
    if [ "$log" == "" ]; then
        echo "Use ~/ll as default log param!";
        log=~/ll;
    fi;
    if [ ! -e "$log" ]; then
        echo "$log" does not exist 1>&2;
        return 2;
    fi;
    if [ ! -d "$symbols" ]; then
        echo "$symbols does not exist or it's not a folder" 1>&2;
        return 2;
    fi;
    while read line; do
        if echo "$line" | grep --color=auto --exclude-dir=.git -e 'Fatal signal ' &> /dev/null; then
            echo;
            echo "$line";
            continue;
        fi;
        tmp="${line#*pc }";
        tmp="${tmp%
}";
        echo "/${tmp#*/}";
        tmp="${tmp% (*}";
        relativepc="${tmp%% *}";
        lib="${tmp##* }";
        addr2line -e "$symbols/$lib" "$relativepc";
    done <<< "$(sed $log -ne '/Fatal signal/,/Tombstone written to/p' | grep -e '#[0-9]\{1,\}  *pc\|Fatal signal ')"
}

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
	CRASH_EXTENSIONS=~/Workspace/ramdump/devtools/crash_analysis_suite/extensions/ ~/Workspace/ramdump/devtools/crash_analysis_suite/bin/crash -x "$1" "$2"
}

backdoor()
{
    /home/zongmincui/bin/backdoor "$1" "$2" "$3"
}
