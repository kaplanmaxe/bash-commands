#!/bin/bash
runcode() {
  CONTAINER="";
  VOLUME="";
  HOST_DIR="";
  CONTAINER_DIR="";
  COMMAND="bash";
  ARGS=();

  for i in $@; do ARGS+=($i); done;
  for (( i=0;i<${#ARGS[@]};i++ )) do
      case "${ARGS[i]}" in
          node)
              CONTAINER="node";
              CONTAINER_DIR="/app";;
          go)
              CONTAINER="golang";
              CONTAINER_DIR="/go/src";; # to comply with $GOPATH
          --volume)
              HOST_DIR=${ARGS[i+1]};
              VOLUME="-v $HOST_DIR:/$CONTAINER_DIR";;
          --command)
              COMMAND=${ARGS[i+1]};;
      esac
  done;

  if [ -z $CONTAINER ]
  then
      echo "No container specified!";
      exit 1;
  fi
  docker run -ti --rm $VOLUME $CONTAINER $COMMAND;
}
