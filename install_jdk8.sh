#!/bin/bash

set -e

if [ "" == "$1" ]; then
  echo "Supply the directory name of the JDK stored in the downloads folder"
  exit 999
fi

if [ "" == "$2" ]; then
  echo "Supply the username that the downloads folder is located."
  exit 999
fi

DIR_DOWNLOAD=/home/$2/Downloads/
DIR_LIB64=/usr/lib64/
DIR_OJDK=jdk_Oracle

if [ -d "$DIR_DOWNLOAD$1" ]; then
  echo "Working on the directory $DIR_DOWNLOAD$1"
  read -p "Continue? (Y/n) " ysn_continue
  if [ "$ysn_continue" != "Y" ]; then
    echo "Aborted"
    exit 0
  fi
  mv $DIR_DOWNLOAD$1 $DIR_LIB64$1
  ln -s -T $DIR_LIB64$1 $DIR_LIB64$DIR_OJDK
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/java.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/keytool.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/orbd.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/policytool.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/rmid.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/rmiregistry.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/servertool.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/tnameserv.1)

  sudo mkdir $DIR_LIB64/jvm-exports/$DIR_OJDK
  cd $DIR_LIB64/jvm-exports/$DIR_OJDK
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jaas-${1}_Orac.jar
  ln -s jaas-${1}_Orac.jar jaas-${1}.jar
  ln -s jaas-${1}_Orac.jar jaas.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/jce.jar jce-${1}_Orac.jar
  ln -s jce-${1}_Orac.jar jce-${1}.jar
  ln -s jce-${1}_Orac.jar jce.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jdbc-stdext-${1}_Orac.jar
  ln -s jdbc-stdext-${1}_Orac.jar jdbc-stdext-${1}.jar
  ln -s jdbc-stdext-${1}_Orac.jar jdbc-stdext-3.0.jar
  ln -s jdbc-stdext-${1}_Orac.jar jdbc-stdext.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jndi-${1}_Orac.jar
  ln -s jndi-${1}_Orac.jar jndi-${1}.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jndi-cos-${1}_Orac.jar
  ln -s jndi-cos-${1}_Orac.jar jndi-cos-${1}.jar
  ln -s jndi-cos-${1}_Orac.jar jndi-cos.jar
  ln -s jndi-${1}_Orac.jar jndi.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jndi-ldap-${1}_Orac.jar
  ln -s jndi-ldap-${1}_Orac.jar jndi-ldap-${1}.jar
  ln -s jndi-ldap-${1}_Orac.jar jndi-ldap.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar jndi-rmi-${1}_Orac.jar
  ln -s jndi-rmi-${1}_Orac.jar jndi-rmi-${1}.jar
  ln -s jndi-rmi-${1}_Orac.jar jndi-rmi.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/jsse.jar jsse-${1}_Orac.jar
  ln -s jsse-${1}_Orac.jar jsse-${1}.jar
  ln -s jsse-${1}_Orac.jar jsse.jar
  ln -s $DIR_LIB64$DIR_OJDK/jre/lib/rt.jar sasl-${1}_Orac.jar
  ln -s sasl-${1}_Orac.jar sasl-${1}.jar
  ln -s sasl-${1}_Orac.jar sasl.jar

  sudo /usr/sbin/update-alternatives --install /usr/bin/java java $DIR_LIB64$DIR_OJDK/bin/java 3 --slave /usr/share/man/man1/java.1.gz java.1.gz $DIR_LIB64$DIR_OJDK/man/man1/java.1.gz --slave /usr/lib64/jvm/jre jre $DIR_LIB64$DIR_OJDK/jre --slave /usr/lib64/jvm-exports/jre jre_exports /usr/lib64/jvm-exports/jdk_Oracle --slave /usr/bin/keytool keytool $DIR_LIB64$DIR_OJDK/bin/keytool --slave /usr/share/man/man1/keytool.1.gz keytool.1.gz $DIR_LIB64$DIR_OJDK/man/man1/keytool.1.gz --slave /usr/bin/orbd orbd $DIR_LIB64$DIR_OJDK/bin/orbd --slave /usr/share/man/man1/orbd.1.gz orbd.1.gz $DIR_LIB64$DIR_OJDK/man/man1/orbd.1.gz --slave /usr/bin/policytool policytool $DIR_LIB64$DIR_OJDK/bin/policytool --slave /usr/share/man/man1/policytool.1.gz policytool.1.gz $DIR_LIB64$DIR_OJDK/man/man1/policytool.1.gz --slave /usr/bin/rmid rmid $DIR_LIB64$DIR_OJDK/bin/rmid --slave /usr/share/man/man1/rmid.1.gz rmid.1.gz $DIR_LIB64$DIR_OJDK/man/man1/rmid.1.gz --slave /usr/bin/rmiregistry rmiregistry $DIR_LIB64$DIR_OJDK/bin/rmiregistry --slave /usr/share/man/man1/rmiregistry.1.gz rmiregistry.1.gz $DIR_LIB64$DIR_OJDK/man/man1/rmiregistry.1.gz --slave /usr/bin/servertool servertool $DIR_LIB64$DIR_OJDK/bin/servertool --slave /usr/share/man/man1/servertool.1.gz servertool.1.gz $DIR_LIB64$DIR_OJDK/man/man1/servertool.1.gz --slave /usr/bin/tnameserv tnameserv $DIR_LIB64$DIR_OJDK/bin/tnameserv --slave /usr/share/man/man1/tnameserv.1.gz tnameserv.1.gz $DIR_LIB64$DIR_OJDK/man/man1/tnameserv.1.gz

  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/appletviewer.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/extcheck.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jar.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jarsigner.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/javac.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/javadoc.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/javah.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/javap.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jcmd.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jconsole.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jdb.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jhat.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jinfo.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jmap.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jps.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jrunscript.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jsadebugd.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jstack.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jstat.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/jstatd.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/native2ascii.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/pack200.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/rmic.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/schemagen.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/serialver.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/unpack200.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/wsgen.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/wsimport.1)
  gzip $(readlink -f $DIR_LIB64$DIR_OJDK/man/man1/xjc.1)

  /usr/sbin/update-alternatives --install /usr/bin/javac javac $DIR_LIB64$DIR_OJDK/bin/javac 3 \
  --slave /usr/bin/appletviewer appletviewer $DIR_LIB64$DIR_OJDK/bin/appletviewer \
  --slave /usr/share/man/man1/appletviewer.1.gz appletviewer.1.gz $DIR_LIB64$DIR_OJDK/man/man1/appletviewer.1.gz \
  --slave /usr/bin/extcheck extcheck $DIR_LIB64$DIR_OJDK/bin/extcheck \
  --slave /usr/share/man/man1/extcheck.1.gz extcheck.1.gz $DIR_LIB64$DIR_OJDK/man/man1/extcheck.1.gz \
  --slave /usr/bin/jar jar $DIR_LIB64$DIR_OJDK/bin/jar \
  --slave /usr/share/man/man1/jar.1.gz jar.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jar.1.gz \
  --slave /usr/bin/jarsigner jarsigner $DIR_LIB64$DIR_OJDK/bin/jarsigner \
  --slave /usr/share/man/man1/jarsigner.1.gz jarsigner.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jarsigner.1.gz \
  --slave /usr/lib64/jvm/java java_sdk $DIR_LIB64$DIR_OJDK \
  --slave /usr/lib64/jvm-exports/java java_sdk_exports /usr/lib64/jvm-exports/jdk_Oracle \
  --slave /usr/share/man/man1/javac.1.gz javac.1.gz $DIR_LIB64$DIR_OJDK/man/man1/javac.1.gz \
  --slave /usr/bin/javadoc javadoc $DIR_LIB64$DIR_OJDK/bin/javadoc \
  --slave /usr/share/man/man1/javadoc.1.gz javadoc.1.gz $DIR_LIB64$DIR_OJDK/man/man1/javadoc.1.gz \
  --slave /usr/bin/javah javah $DIR_LIB64$DIR_OJDK/bin/javah \
  --slave /usr/share/man/man1/javah.1.gz javah.1.gz $DIR_LIB64$DIR_OJDK/man/man1/javah.1.gz \
  --slave /usr/bin/javap javap $DIR_LIB64$DIR_OJDK/bin/javap \
  --slave /usr/share/man/man1/javap.1.gz javap.1.gz $DIR_LIB64$DIR_OJDK/man/man1/javap.1.gz \
  --slave /usr/share/man/man1/jcmd.1.gz jcmd.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jcmd.1.gz \
  --slave /usr/bin/jconsole jconsole $DIR_LIB64$DIR_OJDK/bin/jconsole \
  --slave /usr/share/man/man1/jconsole.1.gz jconsole.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jconsole.1.gz \
  --slave /usr/bin/jdb jdb $DIR_LIB64$DIR_OJDK/bin/jdb \
  --slave /usr/share/man/man1/jdb.1.gz jdb.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jdb.1.gz \
  --slave /usr/bin/jhat jhat $DIR_LIB64$DIR_OJDK/bin/jhat \
  --slave /usr/share/man/man1/jhat.1.gz jhat.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jhat.1.gz \
  --slave /usr/bin/jinfo jinfo $DIR_LIB64$DIR_OJDK/bin/jinfo \
  --slave /usr/share/man/man1/jinfo.1.gz jinfo.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jinfo.1.gz \
  --slave /usr/bin/jmap jmap $DIR_LIB64$DIR_OJDK/bin/jmap \
  --slave /usr/share/man/man1/jmap.1.gz jmap.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jmap.1.gz \
  --slave /usr/bin/jps jps $DIR_LIB64$DIR_OJDK/bin/jps \
  --slave /usr/share/man/man1/jps.1.gz jps.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jps.1.gz \
  --slave /usr/bin/jrunscript jrunscript $DIR_LIB64$DIR_OJDK/bin/jrunscript \
  --slave /usr/share/man/man1/jrunscript.1.gz jrunscript.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jrunscript.1.gz \
  --slave /usr/bin/jsadebugd jsadebugd $DIR_LIB64$DIR_OJDK/bin/jsadebugd \
  --slave /usr/share/man/man1/jsadebugd.1.gz jsadebugd.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jsadebugd.1.gz \
  --slave /usr/bin/jstack jstack $DIR_LIB64$DIR_OJDK/bin/jstack \
  --slave /usr/share/man/man1/jstack.1.gz jstack.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jstack.1.gz \
  --slave /usr/bin/jstat jstat $DIR_LIB64$DIR_OJDK/bin/jstat \
  --slave /usr/share/man/man1/jstat.1.gz jstat.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jstat.1.gz \
  --slave /usr/bin/jstatd jstatd $DIR_LIB64$DIR_OJDK/bin/jstatd \
  --slave /usr/share/man/man1/jstatd.1.gz jstatd.1.gz $DIR_LIB64$DIR_OJDK/man/man1/jstatd.1.gz \
  --slave /usr/bin/native2ascii native2ascii $DIR_LIB64$DIR_OJDK/bin/native2ascii \
  --slave /usr/share/man/man1/native2ascii.1.gz native2ascii.1.gz $DIR_LIB64$DIR_OJDK/man/man1/native2ascii.1.gz \
  --slave /usr/bin/pack200 pack200 $DIR_LIB64$DIR_OJDK/bin/pack200 \
  --slave /usr/share/man/man1/pack200.1.gz pack200.1.gz $DIR_LIB64$DIR_OJDK/man/man1/pack200.1.gz \
  --slave /usr/bin/rmic rmic $DIR_LIB64$DIR_OJDK/bin/rmic \
  --slave /usr/share/man/man1/rmic.1.gz rmic.1.gz $DIR_LIB64$DIR_OJDK/man/man1/rmic.1.gz \
  --slave /usr/bin/schemagen schemagen $DIR_LIB64$DIR_OJDK/bin/schemagen \
  --slave /usr/share/man/man1/schemagen.1.gz schemagen.1.gz $DIR_LIB64$DIR_OJDK/man/man1/schemagen.1.gz \
  --slave /usr/bin/serialver serialver $DIR_LIB64$DIR_OJDK/bin/serialver \
  --slave /usr/share/man/man1/serialver.1.gz serialver.1.gz $DIR_LIB64$DIR_OJDK/man/man1/serialver.1.gz \
  --slave /usr/bin/unpack200 unpack200 $DIR_LIB64$DIR_OJDK/bin/unpack200 \
  --slave /usr/share/man/man1/unpack200.1.gz unpack200.1.gz $DIR_LIB64$DIR_OJDK/man/man1/unpack200.1.gz \
  --slave /usr/bin/wsgen wsgen $DIR_LIB64$DIR_OJDK/bin/wsgen \
  --slave /usr/share/man/man1/wsgen.1.gz wsgen.1.gz $DIR_LIB64$DIR_OJDK/man/man1/wsgen.1.gz \
  --slave /usr/bin/wsimport wsimport $DIR_LIB64$DIR_OJDK/bin/wsimport \
  --slave /usr/share/man/man1/wsimport.1.gz wsimport.1.gz $DIR_LIB64$DIR_OJDK/man/man1/wsimport.1.gz \
  --slave /usr/bin/xjc xjc $DIR_LIB64$DIR_OJDK/bin/xjc \
  --slave /usr/share/man/man1/xjc.1.gz xjc.1.gz $DIR_LIB64$DIR_OJDK/man/man1/xjc.1.gz

  /usr/sbin/update-alternatives --config java

  /usr/sbin/update-alternatives --config javac

fi

echo "Finished" 
