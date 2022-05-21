#!/bin/bash
clear
echo -e "\033[31m\e[5m
███████╗ ██████╗ ██╗     ██╗    ███████╗███╗   ██╗██████╗ 
██╔════╝██╔═══██╗██║     ██║    ██╔════╝████╗  ██║██╔══██╗
███████╗██║   ██║██║     ██║    ███████╗██╔██╗ ██║██████╔╝
╚════██║██║▄▄ ██║██║     ██║    ╚════██║██║╚██╗██║██╔══██╗
███████║╚██████╔╝███████╗██║    ███████║██║ ╚████║██║  ██║
╚══════╝ ╚══▀▀═╝ ╚══════╝╚═╝    ╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝
                [Bhone Myat Han]                        version(1.0)                                                                                                                                         
\033[m\e[0m"
echo -e "\e[1;43m\e[4mMYSQLI scanner version(1.0)|You can dicover that the site have vuln or not vuln easily|But this tool is not exactly get sqli vuln error in some website because it is version 1.0\e[0m\e[0m
"
read -p '[Enter the site address]:' url
echo -e "\033[32m [1]Normal Check
 [2]Normal-2 Check
 \033[m"
read -p $'\033[32m Enter Option::\033[m' option
case $option in
1)
urlbalance=("'" "''" '"')
for balance in ${urlbalance[@]}; do
check_url=$(curl -ks -A "Chrome" -L $url$balance)
if echo $check_url | grep -q -i "you have an error in your sql syntax" || echo $check_url | grep -q -i "unclosed quotation mark after the character string" || echo $check_url | grep -q -i "warning: mysql" || echo $check_url | grep -q -i "quoted string not properly terminated" || echo $check_url | grep -q -i "check the manual that corresponds to your MySQL server version for the right syntax to use near"; then
echo -e "\e[1;31mVuln Found::\e[0m\e[4m $url$balance\e[0m"
else
echo -e "\e[1;33mNo Vuln Found::\e[0m\e[4m $url$balance\e[0m"
fi
done
;;
2)
check=$(curl -ks -A "Chrome" -L $url)
urlbalance=("'" "''" "')" "]" ")" "))" "}" '"')
for balance in ${urlbalance[@]}; do
check_url=$(curl -ks -A "Chrome" -L $url$balance)
if [ "$check_url" != "$check" ] || echo $check_url | grep -q -i "you have an error in your sql syntax" || echo $check_url | grep -q -i "unclosed quotation mark after the character string" || echo $check_url | grep -q -i "warning: mysql" || echo $check_url | grep -q -i "quoted string not properly terminated" || echo $check_url | grep -q -i "check the manual that corresponds to your MySQL server version for the right syntax to use near"; then
echo -e "\e[1;31mVuln Found::\e[0m\e[4m $url$balance\e[0m"
else
echo -e "\e[1;33mNo Vuln Found::\e[0m\e[4m $url$balance\e[0m"
fi
done
;;
*)
echo -e "\e[1;34mNothing in input form\e[0m"
;;
esac
