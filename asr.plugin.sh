## logcf
alias logcf='LL="$(date +%F.%T).logcat"; touch /tmp/"$LL"; ln -s /tmp/"$LL" "$LL"; adb wait-for-device; adb logcat -c | grep permitted && (adb root; adb wait-for-device; adb logcat -c); adb logcat -v time *:v | tee /tmp/"$LL"'
# alias logcf='bash ~/Templates/bash/logcf.sh'

## kimedia
alias kimedia='adb root; adb wait-for-device; adb shell pkill -l KILL cameraserver; (adb shell pkill -l KILL gallery; adb shell pkill -l KILL camera; adb shell pkill -l KILL GoogleCamera) &>/dev/null'

function asrDocrash()
{
    export DOVECRASHROOT=/home/zongmincui/workspace/devtools/crash_analysis_suite/dove_bin/
    export PATH=$DOVECRASHROOT:$PATH
    # CRASH_EXTENSIONS=~/workspace/devtools/crash_analysis_suite/dove_bin/extensions/ ~/workspace/devtools/crash_analysis_suite/dove_bin/crash -x "$1" "$2"
}

function asrManuMount()
{
    sudo mount -t cifs //10.1.24.167/isp /mnt/fileserver/isp -o credentials=~/asr/.cifscredentials,rw,uid=1000
    sudo mount -t cifs //10.1.24.167/fpga /mnt/fileserver/FPGA -o credentials=~/asr/.cifscredentials,rw,uid=1000
}

function asrAfbcDec()
{
    export AFBCROOT=/home/zongmincui/Repositories/ctest/camera-ctest/modules/gt_cppv3/cppv3_smu/simulator_fbc/
    export PATH=$AFBCROOT:$PATH
}

function asrDwtCalc()
{
    if [[ $# -eq 0 ]]; then
        echo "USAGE: $FUNCNAME [ImgW] [ImgH]"
        return
    fi
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

    echo "dwtLL0 = $ExtW * $ExtH"
    echo "dwtLL1 = $LL1W * $LL1H"
    echo "dwtLL2 = $LL2W * $LL2H"
    echo "dwtLL3 = $LL3W * $LL3H"
    echo "dwtLL4 = $LL4W * $LL4H"

    LL1W=$(((((ImgW >> 1) + 3) >> 2) << 2))
    LL1H=$(((((ImgH >> 1) + 1) >> 1) << 1))
    LL2W=$(((((ImgW >> 2) + 3) >> 2) << 2))
    LL2H=$(((((ImgH >> 2) + 1) >> 1) << 1))
    LL3W=$(((((ImgW >> 3) + 3) >> 2) << 2))
    LL3H=$(((((ImgH >> 3) + 1) >> 1) << 1))
    LL4W=$(((((ImgW >> 4) + 3) >> 2) << 2))
    LL4H=$(((((ImgH >> 4) + 1) >> 1) << 1))

    echo "dwtValidLL0 = $ImgW * $ImgH"
    echo "dwtValidLL1 = $LL1W * $LL1H"
    echo "dwtValidLL2 = $LL2W * $LL2H"
    echo "dwtValidLL3 = $LL3W * $LL3H"
    echo "dwtValidLL4 = $LL4W * $LL4H"

}

function asrKgainCalc()
{
    if [[ $# -eq 0 ]]; then
        echo "USAGE: $FUNCNAME [ImgW] [ImgH]"
        return
    fi
    local ImgW=$1
    local ImgH=$2
    local ExtW=$(((($ImgW + 63) >> 6) << 6))
    local ExtH=$(((($ImgH + 31) >> 5) << 5))
    local LL0W=$((ExtW >> 1))
    local LL0H=$((ExtH >> 1))
    local LL1W=$((ExtW >> 2))
    local LL1H=$((ExtH >> 2))
    local LL2W=$((ExtW >> 3))
    local LL2H=$((ExtH >> 3))
    local LL3W=$((ExtW >> 4))
    local LL3H=$((ExtH >> 4))
    local LL4W=$((ExtW >> 5))
    local LL4H=$((ExtH >> 5))

    echo "kLL0 = $LL0W * $LL0H"
    echo "kLL1 = $LL1W * $LL1H"
    echo "kLL2 = $LL2W * $LL2H"
    echo "kLL3 = $LL3W * $LL3H"
    echo "kLL4 = $LL4W * $LL4H"
}
