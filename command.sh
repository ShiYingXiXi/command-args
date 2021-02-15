#!/bin/bash

declare -a OtherArgArray ## 声明一个数组，用来存储非选项参数
while [ $# -ne 0 ]
do
   OPTIND=0 # 索引为0

   ## 处理选项参数
   while getopts "a:b:c:d:" opt
   do
       case $opt in
        a)
	        echo "Option a: Argument is: $OPTARG"
	    ;;
    	b)
   	        echo "Option b: Argument is: $OPTARG"
   	    ;;
    	c)
   	        echo "Option c: Argument is: $OPTARG"
   	    ;;
    	d)
   	        echo "Option d: Argument is: $OPTARG"
   	    ;;
    	?)
   	        echo "Invalid option: -$OPTARG" >&2
   	    exit 1
   	    ;;
   	    :)
   	    echo "Option: -$OPTARG requires an argument." >&2
   	    exit 1
   	    ;;
       esac
   done

   ## 处理非选项参数
   if [ $OPTIND -ne $(($#+1)) ]
   then
       shift $(($OPTIND-1)) ## 把前面的都去掉
       ## 把参数加入数组
       OtherArgArray=(`echo ${OtherArgArray[*]}` $1)
       shift
   else
       break;
   fi
done

echo "Other arguments:"
for arg in ${OtherArgArray[*]}
do
	echo '-->' "${arg}"
done
