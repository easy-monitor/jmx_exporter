#!/bin/bash
# Name    : start_script.py
# Date    : 2016.03.28
# Func    : 启动脚本
# Note    : 注意：当前路径为应用部署文件夹

#############################################################
# 初始化环境

# 用户自定义
app_folder="jmx_exporter"                 # 项目根目录
process_name="jmx_exporter"              # 进程名
install_base="/data/exporter"              # 安装根目录

#############################################################

# 执行准备
install_path="${install_base}/${app_folder}/"
if [[ ! -d ${install_path} ]]; then
    echo "${install_path} is not exist"
    exit 1
fi

# 配置文件
config_path="$install_path/conf/config.yml"
if [[ ! -f ${config_path} ]]; then
    config_path="$install_path/conf/httpserver_sample_config.yml"
fi


# 启动命令
jar=$(ls ${install_path}/jmx_prometheus_httpserver-*.jar)
start_cmd="java -jar .${jar} 9108 ${config_path} >/dev/null 2>log/${app_folder}.log &"


# 日志目录
log_path="${install_base}/${app_folder}/log"
mkdir -p ${log_path}


#############################################################

# 启动程序
echo "start by cmd: ${start_cmd}"
cd ${install_path} && eval "${start_cmd}"
if [[ $? -ne 0 ]];then
    echo "start error, exit"
    exit 1
fi
#############################################################
