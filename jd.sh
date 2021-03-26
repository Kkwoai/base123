#!/usr/bin/env bash

## 路径
ShellDir=${JD_DIR:-$(
  cd $(dirname $0)
  pwd
)}
[ ${JD_DIR} ] && HelpJd=jd || HelpJd=jd.sh
ScriptsDir=${ShellDir}/scripts
ConfigDir=${ShellDir}/config
FileConf=${ConfigDir}/config.sh
FileConfSample=${ShellDir}/sample/config.sh.sample
LogDir=${ShellDir}/log
ListScripts=($(
  cd ${ScriptsDir}
  ls *.js | grep -E "j[drx]_"
))
ListCron=${ConfigDir}/crontab.list

## 导入config.sh
function Import_Conf() {
  if [ -f ${FileConf} ]; then
    . ${FileConf}
    if [ -z "${Cookie1}" ]; then
      echo -e "请先在config.sh中配置好Cookie...\n"
      exit 1
    fi
  else
    echo -e "配置文件 ${FileConf} 不存在，请先按教程配置好该文件...\n"
    exit 1
  fi
}

## 更新crontab
function Detect_Cron() {
  if [[ $(cat ${ListCron}) != $(crontab -l) ]]; then
    crontab ${ListCron}
  fi
}

## 用户数量UserSum
function Count_UserSum() {
  for ((i = 1; i <= 30; i++)); do
    Tmp=Cookie$i
    CookieTmp=${!Tmp}
    [[ ${CookieTmp} ]] && UserSum=$i || break
  done

  for ((d = 31; d <= 1000; d++)); do
    Del=Cookie$d
    sed -i "/${!Del}/d" ${FileConf} || break
  done
}

## 组合Cookie和互助码子程序
function Combin_Sub() {
  CombinAll=""
  if [[ ${AutoHelpOther} == true ]] && [[ $1 == ForOther* ]]; then

    ForOtherAll=""
    MyName=$(echo $1 | perl -pe "s|ForOther|My|")

    for ((m = 1; m <= ${UserSum}; m++)); do
      TmpA=${MyName}$m
      TmpB=${!TmpA}
      ForOtherAll="${ForOtherAll}@${TmpB}"
    done

    for ((n = 1; n <= ${UserSum}; n++)); do
      for num in ${TempBlockCookie}; do
        [[ $n -eq $num ]] && continue 2
      done
      CombinAll="${CombinAll}&${ForOtherAll}"
    done

  else
    for ((i = 1; i <= ${UserSum}; i++)); do
      for num in ${TempBlockCookie}; do
        [[ $i -eq $num ]] && continue 2
      done
      Tmp1=$1$i
      Tmp2=${!Tmp1}
      CombinAll="${CombinAll}&${Tmp2}"
    done
  fi

  echo ${CombinAll} | perl -pe "{s|^&||; s|^@+||; s|&@|&|g; s|@+&|&|g; s|@+|@|g; s|@+$||}"
}
## 组合Cookie、Token与互助码
function Combin_All() {
  export JD_COOKIE=$(Combin_Sub Cookie)
  #东东农场(jd_fruit.js)
  export FRUITSHARECODES=$(Combin_Sub ForOtherFruit "e2d8c5cc012d4d9aa89ec3c38d9c32dc@1c7be7a24e5649e9a671d445a4eea876@d4b229884eef4e19b912404c4458cac8@fa24bc6934de42dda27eb2a6524f13c0@55997ff9382d4d68a96226bac50e1543@415f1b2c77ab49349cc0745b2817bdef@9dc01d97749f49aeaeee0a00c8486989@cd2a466b397b4ac59aa993b34b401afd")
  #东东萌宠(jd_pet.js)
  export PETSHARECODES=$(Combin_Sub ForOtherPet "MTE1NDQ5OTUwMDAwMDAwMzY1NjIzMjE=@MTAxODExNDYxMTAwMDAwMDAwMzk3NDM3MjE=@MTE1NDUyMjEwMDAwMDAwNDA5Mzk3OTE=@MTE1NDUyMjEwMDAwMDAwNDMyODE3OTE=@MTAxODcxOTI2NTAwMDAwMDAxMTE5MzMyNw==@MTE1NDQ5OTUwMDAwMDAwMzk4NDE2Mjk=@MTAxODExNDYxMTEwMDAwMDAwNDA3MTE1MzE=")
  #种豆得豆(jd_plantBean.js)
  export PLANT_BEAN_SHARECODES=$(Combin_Sub ForOtherBean "icahbcqcnjkiinztca5ei7idi2hqondffv7jggq@itplnhngh2a7eqz4pniowqquwpiecuhj3xtqnvq@vhftr7wn6fwbijooakct7wsjdy5ac3f4ijdgqji@bknudbr7e4sqxqidhwwarcezykgoiac6yvflawi@4npkonnsy7xi2z4l5p4mvqlbwr2ioj5mbxre45a@4npkonnsy7xi27jrutdkomlebwsgebumxlv6yia@olmijoxgmjutyqhokmwnp7ulzuy2q5pberuv6aq")
  #京喜工厂(jd_dreamFactory.js)
  export DREAM_FACTORY_SHARE_CODES=$(Combin_Sub ForOtherDreamFactory "yjxvuYphwul173ilsQDxpw==@B4Lq4EoIgKc4zRrbjNUigQ==@CWbxPZIhH9Qa0x45kTXNUA==@wf3GSRycYA4ghclHw-rNqA==@qXfP0cp2rM8BHilLMotdbA==@EP-T1EG1Q_ide7t13hE1OQ==@QJdc4lWBGlD6uKUZZuvTqg==" )
  #东东工厂(jd_jdfactory.js)
  export DDFACTORY_SHARECODES=$(Combin_Sub ForOtherJdFactory "T019vfV2RxwE8V3UJRP1lvcCjVWnYaS5kRrbA@T0205KkcHFpxsRCXRWa90qpJCjVWnYaS5kRrbA@T016a3r3lqWgIMJ59YxaCjVWnYaS5kRrbA@T0205KkcNmptqiGeXH-S8JFUCjVWnYaS5kRrbA@T0225KkcRxYZpFbXI0uhkfNecACjVWnYaS5kRrbA@T0225KkcRk9LpgLWJx-nnfQLJgCjVWnYaS5kRrbA@T0225KkcRxpKoFHTJx2hwaEJcACjVWnYaS5kRrbA" )
  #京东赚赚(jd_jdzz.js)
  export JDZZ_SHARECODES=$(Combin_Sub ForOtherJdzz "SvfV2RxwE8V3UJRP1lvc@S5KkcHFpxsRCXRWa90qpJ@Sa3r3lqWgIMJ59Yxa@S5KkcNmptqiGeXH-S8JFU@S5KkcRxYZpFbXI0uhkfNecA")
  #crazyJoy(jd_crazy_joy.js)
  export JDJOY_SHARECODES=$(Combin_Sub ForOtherJoy "B8TaKS2BaXKhwuuui2kc5A==@yar0ag5yv0wnzGNBHuD-og==@bv9H42Fku0AomKC2CtKsnw==@u_XLp4AY3oQTMrpZvwP5Uw==@")
  #口袋书店(jd_bookshop.js)
  export BOOKSHOP_SHARECODES=$(Combin_Sub ForOtherBookShop "ea51cb0a7749483c92e42fee04461153@dbb6bc5d12784b219d8efb49182ddcb5@79c70caa932340cd813603e87fed7c63@7d433aae765a4beab257de3970985b1f" )
  #签到领现金(jd_cash.js)
  export JD_CASH_SHARECODES=$(Combin_Sub ForOtherCash "IBMya-6vYvUl9GfUyXM@eU9YMKjaIrhmlBKcjS5Q@9pyzulcLs2qIJPh7@eU9YGpjGOYlvjQuzrxVN@eU9Ya-SyN_4m8j-AzndH0g")
  #闪购盲盒(jd_sgmh.js)
  export JDSGMH_SHARECODES=$(Combin_Sub ForOtherSgmh "T019vfV2RxwE8V3UJRP1lvcCjVWmIaW5kRrbA@T0205KkcHFpxsRCXRWa90qpJCjVWmIaW5kRrbA@T016a3r3lqWgIMJ59YxaCjVWmIaW5kRrbA@T0205KkcNmptqiGeXH-S8JFUCjVWmIaW5kRrbA@T0225KkcRxYZpFbXI0uhkfNecACjVWmIaW5kRrbA" )
  ## 京喜农场(jd_jxnc.js)
  export JXNC_SHARECODES=$(Combin_Sub ForOtherJxnc)
  ## 京喜财富岛(jd_cfd.js)
  export JDCFD_SHARECODES=$(Combin_Sub ForOtherCfd)
  ## 环球挑战赛(jd_global.js)
  export JDGLOBAL_SHARECODES=$(Combin_Sub ForOtherGlobal)
}

## 转换JD_BEAN_SIGN_STOP_NOTIFY或JD_BEAN_SIGN_NOTIFY_SIMPLE
function Trans_JD_BEAN_SIGN_NOTIFY() {
  case ${NotifyBeanSign} in
  0)
    export JD_BEAN_SIGN_STOP_NOTIFY="true"
    ;;
  1)
    export JD_BEAN_SIGN_NOTIFY_SIMPLE="true"
    ;;
  esac
}

## 转换UN_SUBSCRIBES
function Trans_UN_SUBSCRIBES() {
  export UN_SUBSCRIBES="${goodPageSize}\n${shopPageSize}\n${jdUnsubscribeStopGoods}\n${jdUnsubscribeStopShop}"
}

## 申明全部变量
function Set_Env() {
  Count_UserSum
  Combin_All
  Trans_JD_BEAN_SIGN_NOTIFY
  Trans_UN_SUBSCRIBES
}

## 随机延迟
function Random_Delay() {
  if [[ -n ${RandomDelay} ]] && [[ ${RandomDelay} -gt 0 ]]; then
    CurMin=$(date "+%-M")
    if [[ ${CurMin} -gt 2 && ${CurMin} -lt 30 ]] || [[ ${CurMin} -gt 31 && ${CurMin} -lt 59 ]]; then
      CurDelay=$((${RANDOM} % ${RandomDelay} + 1))
      echo -e "\n命令未添加 \"now\"，随机延迟 ${CurDelay} 秒后再执行任务，如需立即终止，请按 CTRL+C...\n"
      sleep ${CurDelay}
    fi
  fi
}

## 使用说明
function Help() {
  echo -e "本脚本的用法为："
  echo -e "1. bash ${HelpJd} xxx      # 如果设置了随机延迟并且当时时间不在0-2、30-31、59分内，将随机延迟一定秒数"
  echo -e "2. bash ${HelpJd} xxx now  # 无论是否设置了随机延迟，均立即运行"
  echo -e "3. bash ${HelpJd} hangup   # 重启挂机程序"
  echo -e "4. bash ${HelpJd} resetpwd # 重置控制面板用户名和密码"
  echo -e "\n针对用法1、用法2中的\"xxx\"，可以不输入后缀\".js\"，另外，如果前缀是\"jd_\"的话前缀也可以省略。"
  echo -e "当前有以下脚本可以运行（仅列出以jd_、jr_、jx_开头的脚本）："
  cd ${ScriptsDir}
  for ((i = 0; i < ${#ListScripts[*]}; i++)); do
    Name=$(grep "new Env" ${ListScripts[i]} | awk -F "'|\"" '{print $2}')
    echo -e "$(($i + 1)).${Name}：${ListScripts[i]}"
  done
}

## nohup
function Run_Nohup() {
  if [[ $(ps -ef | grep "${js}" | grep -v "grep") != "" ]]; then
    ps -ef | grep "${js}" | grep -v "grep" | awk '{print $2}' | xargs kill -9
  fi
  [ ! -d ${LogDir}/${js} ] && mkdir -p ${LogDir}/${js}
  LogTime=$(date "+%Y-%m-%d-%H-%M-%S")
  LogFile="${LogDir}/${js}/${LogTime}.log"
  nohup node ${js}.js >${LogFile} &
}

## 运行挂机脚本
function Run_HangUp() {
  HangUpJs="jd_crazy_joy_coin"
  cd ${ScriptsDir}
  for js in ${HangUpJs}; do
    Import_Conf ${js} && Set_Env
    if type pm2 >/dev/null 2>&1; then
      pm2 stop ${js}.js 2>/dev/null
      pm2 flush
      pm2 start -a ${js}.js --watch "${ScriptsDir}/${js}.js" --name="${js}"
    else
      Run_Nohup >/dev/null 2>&1
    fi
  done
}

## 重置密码
function Reset_Pwd() {
  cp -f ${ShellDir}/sample/auth.json ${ConfigDir}/auth.json
  echo -e "控制面板重置成功，用户名：useradmin，密码：supermanito\n"
}

## 运行京东脚本
function Run_Normal() {
  Import_Conf $1 && Detect_Cron && Set_Env

  FileNameTmp1=$(echo $1 | perl -pe "s|\.js||")
  FileNameTmp2=$(echo $1 | perl -pe "{s|jd_||; s|\.js||; s|^|jd_|}")
  SeekDir="${ScriptsDir} ${ScriptsDir}/backUp ${ConfigDir}"
  FileName=""
  WhichDir=""

  for dir in ${SeekDir}; do
    if [ -f ${dir}/${FileNameTmp1}.js ]; then
      FileName=${FileNameTmp1}
      WhichDir=${dir}
      break
    elif [ -f ${dir}/${FileNameTmp2}.js ]; then
      FileName=${FileNameTmp2}
      WhichDir=${dir}
      break
    fi
  done

  if [ -n "${FileName}" ] && [ -n "${WhichDir}" ]; then
    [ $# -eq 1 ] && Random_Delay
    LogTime=$(date "+%Y-%m-%d-%H-%M-%S")
    LogFile="${LogDir}/${FileName}/${LogTime}.log"
    [ ! -d ${LogDir}/${FileName} ] && mkdir -p ${LogDir}/${FileName}
    cd ${WhichDir}
    node ${FileName}.js | tee ${LogFile}
  else
    echo -e "\n在${ScriptsDir}、${ScriptsDir}/backUp、${ConfigDir}三个目录下均未检测到 $1 脚本的存在，请确认...\n"
    Help
  fi
}

## 命令检测
case $# in
0)
  echo
  Help
  ;;
1)
  if [[ $1 == hangup ]]; then
    Run_HangUp
  elif [[ $1 == resetpwd ]]; then
    Reset_Pwd
  else
    Run_Normal $1
  fi
  ;;
2)
  if [[ $2 == now ]]; then
    Run_Normal $1 $2
  else
    echo -e "\n命令输入错误...\n"
    Help
  fi
  ;;
*)
  echo -e "\n命令过多...\n"
  Help
  ;;
esac
