#!bin/bash
BUILD_JAR= $(ls /home/ec2-user/jenkins/build/libs/*.jar)
JAR_NAME=$(basename $BUILD_JAR)

DEPLOY_PATH=/home/ec2-user

cp $BUILD_JAR $DEPLOY_PATH

CURRENT_PID=$(pgrep -f $JAR_NAME)

if[ -z $CURRENT_PID ]
then
  echo "> 구동중인 것이 없으므로 종료x"
else
  kill -15 $CURRENT_PID
  sleep 5
fi

DEPLOY_JAR =$DEPLOY_PATH$JAR_NAME

nohup java -jar $DEPLOY_JA >> /home/ec2-user/deploy.log 2>&1 &