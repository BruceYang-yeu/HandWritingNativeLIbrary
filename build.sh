#########################################################################
# File Name: build.sh
# Author: WeiMingYang
# mail: ywm_yang@163.com
# Created Time: 2016年04月06日 星期三 16时02分38秒
#########################################################################
#!/bin/bash


##############################################################################
#
# README
# ----------------------------------------------------------------------------
# This script accept 4 parameters:
# $1: source tree code
# $2: source tag/branch
# $3: product name
# $4: path of object location
#
# to test:
#   rm -rf /home/www/bbb/daily/aaa && mkdir -p /home/www/bbb/daily/aaa && ./build.sh husky HEAD husky /home/www/bbb/daily/aaa
#
##############################################################################
#
# modification history
# ----------------------------------------------------------------------------
# 01a,27Aug2013,lijin        written
#
##############################################################################

SRC=${1}
TAG=${2}
PDT=${3}
#DST=${4}
DIR=`pwd`
DST=${DIR}/out
INSTALLDIR=${DIR}/install/
cd ${DIR}

echo "SRC:$SRC  TAG:$TAG----"
echo "PDT:$PDT  DST:$DST DIR:$DIR---"

########################### Git update####################################
echo ">>>>>>>>>>>>>>>>>>>> Git update.... <<<<<<<<<<<<<<<<<<<<"
#git pull origin master

export PATH=/data1/home/ywm/ProgramFile/android-ndk-r10e:$PATH

install()
{
	INSTALL_DST=${DST}
	MIDDLEWARE_INSTALLDIR=${INSTALL_DST}/out
	rm -fr ${MIDDLEWARE_INSTALLDIR}
	mkdir -p ${MIDDLEWARE_INSTALLDIR}/lib
	mkdir -p ${MIDDLEWARE_INSTALLDIR}/etc
	mkdir -p ${MIDDLEWARE_INSTALLDIR}/bin
	cp -ar ${DIR}/out/lib/armeabi-v7a/lib*.so* ${MIDDLEWARE_INSTALLDIR}/lib
	#git  log >${MIDDLEWARE_INSTALLDIR}/middleware_svn.txt
	echo "install middleware"
	echo "middleware.tar.gz downloaded from:">${MIDDLEWARE_INSTALLDIR}/middleware_url.txt
	echo ${URL} >>${MIDDLEWARE_INSTALLDIR}/middleware_url.txt
	#tar -zcvf ${INSTALL_DST}/out.tar.gz -C ${INSTALL_DST} out
	
	#rm -fr ${MIDDLEWARE_INSTALLDIR}
}

########################### application
build_app()
{
	#ndk-build  -B  APP_BUILD_SCRIPT=./Android.mk NDK_APP_APPLICATION_MK=./Application.mk NDK_OUT=./out/obj NDK_LIBS_OUT=./out/lib APP_ABI=armeabi-v7a  APP_CFLAGS=-Wno-error=format-security
	ndk-build  -B  APP_BUILD_SCRIPT=./Android.mk NDK_APP_APPLICATION_MK=./Application.mk NDK_OUT=./out/obj NDK_LIBS_OUT=./out/lib APP_ABI=armeabi-v7a  APP_CFLAGS=-Wno-error=format-security

    #get git info
    #GIT_INFO=${DIR}/out/GITinfo
    #if [ -f $GIT_INFO ];then
     #   rm $SVN_INFO -f
    #fi
    #touch $GIT_INFO
    #svn info > $GIT_INFO
	
#copy lib to dst,
	#cp -rf ${DIR}/out ${DST}
	#tar -zcvf ${DST}/out.tar.gz  -C ${DIR} out
	#install 
	
    return 0
}
build_app 
